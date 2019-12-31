-- Process for PnL:
-- + Step 0: Prepair source, temp tables
-- + Step 1: Collect data from Gross Revenue and Pnl Items source
-- + Step 2: Pivot data, change columns Actual, Budget,Forecast... into Measure Type
-- + Step 3: Other calculations, such as yearly game rank
-- + Step 4: Add meta info (product info, dept info), date dimension... 


-- ######################################################################
-- # <Step0>: Prepair source, temp tables
-- ######################################################################
with src_account_pnl as
(
    select 
        'RWA57' as account_code,
        'Gross Revenue' as account_name,
        'Gross Revenue' as account_group,
        10 as account_group_order 
    from dual 
    union all
    select distinct bi_account_group_account_code, bi_account_group_account_name, '', 0
    from ODS_HYPERION_ENTITY_BI_ACCOUNT_GROUP_V
    where entity_name = 'grp_GE'
    and year = 'FY19'
    union all
    select account_code,
        case 
            when account_name = 'PnL_Sum_CONTROINEX' then 'Contributing Margin'
            else account_name
        end as account_name, '', 0
    from ODS_HYPERION_ACCOUNT_PNL_MAPPING
    where entity_name = 'grp_GE'
    and account_code = 'PnL_Sum_CONTROINEX'
        and version = 'Version1_MKT'
), src_biz_team as
(
    select '9999' dept_code_name, 'GE others' biz_team from dual union all
    select '9999', 'Publishing' from dual union all
    select '9999', 'Publishing' from dual
), src_dept as
(
    select 
        entity_code as dept, e_code_name as dept_code_name,
        case 
            when entity_code = 'GE_Elim' then 'GE_Elim'
            else substr(e_code_name, instr(e_code_name, ':') + 1)
        end as dept_alias,
        case when bu = 'GE_BU' or entity_code = 'GE_BU' then 'GE' else 'NON GE' end as group_dept,
        (
            select biz_team
            from src_biz_team tmp
            where tmp.dept_code_name = t1.e_code_name
        ) as biz_team
    from hyperion_entity_vng t1
    where regexp_like(entity_code, '^\d{4}$') or entity_code in ('GE_Elim')
), src_pnl_renamed as (
    select t1.*, 
        year as c_year,
        period as c_month,
        entity as dept,
        account as c_account
    from stg_hyperion_pnl_summary t1
)
-- ######################################################################
-- # <Step1>: Collect data from Gross Revenue and Pnl Items source
-- ######################################################################
, src_pnl as
(
    select *
    from src_pnl_renamed
    where (bucket in( 'B_Sea', 'B_DOM') and product = 'P_999')
    or (bucket = 'BUC_TOT' and product not in ('P_Total', 'P_999'))
), src_gross_rev as (
    select t1.*,
        year as years,
        period as months,
        entity as dept,
        account as c_account
    from stg_hyperion_gross_revenue t1
), src_all0 as
(
    select
        to_number(extract(year from to_date(substr(c_year, -2), 'yy'))) as year_origin,
        to_number(extract(month from to_date(c_month, 'MON'))) as month_origin,
        dept, product as product_code, c_account as account_code, bucket,
        budget, actual, forecast        
    from src_pnl
    where 1 = 1
        and c_account in (select account_code from src_account_pnl)
    union all
    select 
        to_number(extract(year from to_date(substr(years, -2), 'yy'))) as year_origin,
        to_number(extract(month from to_date(months, 'MON'))) as month_origin,
        dept, product as product_code, c_account, bucket,
        budget, actual, forecast   
    from src_gross_rev
    where bucket = 'BUC_TOT'
        and product != 'P_Total'
        and c_account = 'RWA57'
), src_all as
(
    select * 
    from src_all0
    where dept in (select dept from src_dept)
)
-- ######################################################################
-- # <Step2>:Pivot data, change columns Actual, Budget,Forecast... 
-- # into Measure Type
-- ######################################################################
, src_unpivot as
(
    select t1.*,
        to_date(year_origin || '-' || month_origin, 'YYYY-MM') as date_origin
    from src_all
    unpivot
    (
        measure_value for measure_type in (budget, actual, forecast)
    ) t1
    where measure_value != 0
        and not (measure_type != 'ACTUAL' and year_origin < 2019)
), tmp_ob_date as 
(
    select 
        product_code, 
        to_date(ob_dated) as ob_date,
        to_date(to_char(ob_dated, 'mm/"01"/yyyy'), 'mm/dd/yyyy') as first_date_of_ob_month,
        extract( year from to_date(ob_dated)) as ob_year,
        extract( month from to_date(ob_dated)) as ob_month,
        extract( day from to_date(ob_dated)) as ob_day
    from dtm_ge_product_info
), src_0 as
(
    select t1.*, 
        last_day(date_origin) - to_date(to_char(date_origin,'"01"-mon-yy')) + 1 as month_duration,
        t2.account_name, t2.account_group, t2.account_group_order,
        t3.dept_code_name, t3.dept_alias, t3.group_dept, t3.biz_team,
        --t4.ob_date, 
        t4.ob_year, t4.ob_month, t4.ob_day, t4.first_date_of_ob_month
    from src_unpivot t1
    left join src_account_pnl t2
        on t1.account_code = t2.account_code
    left join src_dept t3
        on t1.dept = t3.dept
    left join tmp_ob_date t4
        on t1.product_code = t4.product_code
)
-- ######################################################################
-- # <Step3>: Other Calculation region
-- ######################################################################
-- Game Rank
, calc_gross as (
    select 
        t1.measure_type, t1.product_code, t1.measure_value,
        t1.year_origin, t1.month_origin, t1.month_duration,
        t1.first_date_of_ob_month, t1.date_origin,
        case
            when first_date_of_ob_month is null 
                then t1.month_duration
            when date_origin < first_date_of_ob_month 
                then null
            when year_origin = ob_year and month_origin = ob_month
                then t1.month_duration - ob_day + 1
            when date_origin > first_date_of_ob_month
                then t1.month_duration
        end as active_days
    from src_0 t1
    where account_code = 'RWA57'
), src_calc as
(
    select 
        measure_type, product_code, year_origin,
        sum(measure_value) as year_total_gross_rev,
        sum(active_days) as year_active_days, 
        case 
            when sum(measure_value)/sum(active_days) >= 1.32*1000 then 'SS'
            when sum(measure_value)/sum(active_days) >= 0.66*1000 then 'S'
            when sum(measure_value)/sum(active_days) >= 0.33*1000 then 'A'
            when sum(measure_value)/sum(active_days) >= 0.16*1000 then 'B'
            when sum(measure_value)/sum(active_days) >= 0.1*1000 then 'C'
            when sum(measure_value)/sum(active_days) <0.1*1000 then 'F'
            else 'F'
        end as game_rank    
    from calc_gross
    group by measure_type, product_code, year_origin
) 
-- ######################################################################
-- # <Step4>:  Add meta info (product info, dept info), date dimension
-- ######################################################################
,src as (
select t1.*,
    t2.year_active_days,
    t2.year_total_gross_rev,
    t2.game_rank,
    to_char(date_origin, 'q') as quarter_origin,
    case when month_origin <= 6 then 1 else 2 end as half_year_origin,
    to_date(t1.year_origin + 1 || '0101', 'yyyymmdd') - 1 as last_date_of_year,
    to_char(t1.date_origin, 'yyyy-mm') as ym,
    to_char(t1.date_origin, 'yyyy-"Q"q') as quarter,
    t1.year_origin || case when t1.month_origin <= 6 then '-H1' else '-H2' end as half_year
from src_0 t1
left join src_calc t2
    on t1.measure_type = t2.measure_type 
    and t1.product_code = t2.product_code
    and t1.year_origin = t2.year_origin
)
select *
from src
/
