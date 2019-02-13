create or replace package body app_logger_sql
as
-- manipulate config
    procedure get_config
    is
    begin
        g_config        := new pljson;
        g_app_logger    := new app_logger;
        g_config        := app_setting.get_logger;
    end;

-- get sql
    function get_create_logger_running_sql return varchar2
    is
        l_sql   varchar2(4000);
    begin
        l_sql := '
            create table '|| g_config.get('running_table').get_string ||'(
                transaction_id        varchar2(64),
                transaction_code      varchar2(64),
                app_user              varchar2(64),
                unit_name             varchar2(64),
                unit_type             varchar2(64),
                log_step_description  varchar2(1024),
                log_step_id           number,
                log_step_name         varchar2(64),
                created_date          date,
                created_unix_ts       number,
                updated_date          date,
                updated_unix_ts       number,
                duration              number
            )';
        return l_sql;
    end;

    function get_create_logger_exception_sql return varchar2
    is
        l_sql   varchar2(4000);
    begin
        l_sql := '
            create table '|| g_config.get('exception_table').get_string ||'(
                transaction_id        varchar2(64),
                transaction_code      varchar2(64),
                app_user              varchar2(64),
                unit_name             varchar2(64),
                unit_type             varchar2(64),
                log_step_description  varchar2(1024),
                log_step_id           number,
                log_step_name         varchar2(64),
                created_date          date,
                created_unix_ts       number,
                updated_date          date,
                updated_unix_ts       number,
                duration              number,
                error_sqlcode         varchar2(64),
                error_sqlerrm         varchar2(1024),
                error_backtrace       varchar2(1024)
            )';
        return l_sql;
    end;
    function get_insert_logger_running_sql return varchar2
    is
        l_sql   varchar2(4000);
    begin
        l_sql :='
            insert into '|| g_config.get('running_table').get_string ||'(
                    transaction_id,
                    transaction_code,
                    app_user,
                    unit_name,
                    unit_type,
                    log_step_description,
                    log_step_id,
                    log_step_name,
                    created_date,
                    created_unix_ts,
                    updated_date,
                    updated_unix_ts,
                    duration)
            values(
                    :transaction_id,
                    :transaction_code,
                    :app_user,
                    :unit_name,
                    :unit_type,
                    :log_step_description,
                    :log_step_id,
                    :log_step_name,
                    :created_date,
                    :created_unix_ts,
                    :updated_date,
                    :updated_unix_ts,
                    :duration)
        ';
        return l_sql;
    end;
    function get_insert_logger_exception_sql return varchar2
    is
        l_sql   varchar2(4000);
    begin
        l_sql := '
            insert into '|| g_config.get('exception_table').get_string ||'(
                    transaction_id,
                    transaction_code,
                    app_user,
                    unit_name,
                    unit_type,
                    log_step_description,
                    log_step_id,
                    log_step_name,
                    created_date,
                    created_unix_ts,
                    updated_date,
                    updated_unix_ts,
                    duration,
                    error_sqlcode,
                    error_sqlerrm,
                    error_backtrace)
            values(
                    :transaction_id,
                    :transaction_code,
                    :app_user,
                    :unit_name,
                    :unit_type,
                    :log_step_description,
                    :log_step_id,
                    :log_step_name,
                    :created_date,
                    :created_unix_ts,
                    :updated_date,
                    :updated_unix_ts,
                    :duration,
                    :error_sqlcode,
                    :error_sqlerrm,
                    :error_backtrace)
        ';
        return l_sql;
    end;
begin
    get_config;
end app_logger_sql;
/