create or replace package body app_config_util
as
-- private attributes
    g_app_config            app_config;
-- manipulate attributes
    procedure set_config(pi_app_config  app_config default null)
    is
    begin
        g_app_config    := nvl(pi_app_config, g_app_config);
    end;

    procedure get_config
    is
    begin
        g_config := app_setting.get_config;
    end;

    procedure get_config(
        pi_config_id        varchar2 default null,
        pi_config_code      varchar2,
        pi_config_name      varchar2,
        pi_status           varchar2 default 'active'
    )
    is
        l_sql               varchar2(4000);
        l_config_value      varchar2(4000);
    begin
        l_sql   := app_config_sql.get_config_sql();
        --dbms_output.put_line(l_sql);
        execute immediate l_sql 
            into 
                g_app_config.config_id,
                g_app_config.config_code,
                g_app_config.config_user,
                g_app_config.config_name,
                l_config_value,
                g_app_config.config_type,
                g_app_config.status,
                g_app_config.created_date,
                g_app_config.updated_date 
            using 
                pi_config_id, 
                pi_config_code, 
                pi_config_name, 
                pi_status;
        g_app_config.config_value := pljson(l_config_value);
    exception
        when no_data_found then
            dbms_output.put_line('you have not set up config in the table');
    end;

    procedure get_config(
        pi_config_id        varchar2 default null,
        pi_config_code      varchar2,
        pi_config_name      varchar2,
        pi_status           varchar2 default 'active',
        po_app_config out   app_config
    )
    is
    begin
        get_config(
            pi_config_id        => pi_config_id,
            pi_config_code      => pi_config_code,
            pi_config_name      => pi_config_name,
            pi_status           => pi_status
        );
        po_app_config   := g_app_config;
    end;
-- manipulate tables
    procedure initialize(pi_is_forced boolean default false)
    is
        l_sql               varchar2(4000);
        l_message           varchar2(4000);
        l_is_previewed      boolean := true;
        l_table_name        varchar2(64) := g_config.get_string('table_name');
    begin
        if pi_is_forced then
            l_is_previewed := false;
        end if;
        dbms_output.put_line('initialize ...');
        if pi_is_forced then
            dbms_output.put_line('drop table '||l_table_name ||' ...');
            app_util.drop_table(l_table_name, true);
        end if;

        l_message := 'warning: all config data will be clear if you pass "true", please follow code below';
        app_util.print( pi_string => l_message, pi_is_previewed => l_is_previewed);

        l_sql   := app_config_sql.get_config_sql();
        if pi_is_forced then
            dbms_output.put_line('create table '||l_table_name ||' ...');
            execute immediate l_sql;
        end if;
        
        app_util.print(pi_string => l_sql , pi_is_previewed => l_is_previewed);
        dbms_output.put_line('done.');
    end;

    procedure insert_config
    is
        l_sql               varchar2(4000);
    begin
        l_sql   := app_config_sql.get_insert_sql();
        --dbms_output.put_line(l_sql);
        execute immediate l_sql
            using
                g_app_config.config_id,
                g_app_config.config_code,
                g_app_config.config_user,
                g_app_config.config_name,
                g_app_config.config_value.to_char(false),
                g_app_config.config_type,
                g_app_config.status,
                g_app_config.created_date,
                g_app_config.updated_date;
    end;

begin
-- setup by default
    g_app_config        := new app_config();
    g_config            := new pljson() ;
    get_config;
end app_config_util;
/