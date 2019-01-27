create or replace package body app_config_util
as 
-- manipulate config
    procedure refresh_config
    is
    begin
        app_config_sql.g_config     := g_config;
    end;
-- manipulate attributes
    procedure set_config(pi_app_config  app_config default null)
    is
    begin
        g_app_config    := nvl(pi_app_config, g_app_config);
    end;

-- manipulate tables
    procedure initialize(pi_is_forced boolean default false)
    is
        l_sql               varchar2(4000);
    begin
        refresh_config();
        dbms_output.put_line('initialize ...');
        if pi_is_forced then
            dbms_output.put_line('drop table '||g_config.get_string('table_name') ||' ...');
            app_util.drop_table(g_config.get_string('table_name'), true);
        else
            dbms_output.put_line('warning: all config data will be clear if you pass "true", please follow code below');
        end if;
        l_sql   := app_config_sql.get_config_sql();
        if pi_is_forced then
            dbms_output.put_line('create table '||g_config.get_string('table_name') ||' ...');
            execute immediate l_sql;
        else
            dbms_output.put_line(l_sql);
        end if;
        dbms_output.put_line('done.');
    end;

    procedure insert_config
    is
        l_sql               varchar2(4000);
    begin
        refresh_config();
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
                g_app_config.description,
                g_app_config.status,
                g_app_config.created_date,
                g_app_config.updated_date;
    end;

    procedure get_config(
        pi_config_id        varchar2 default null,
        pi_config_code      varchar2 default null,
        pi_config_name      varchar2 default null,
        pi_status           varchar2 default 'active'
    )
    is
        l_sql               varchar2(4000);
        l_config_value      varchar2(4000);
    begin
        refresh_config();
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
                g_app_config.description,
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
        pi_config_code      varchar2 default null,
        pi_config_name      varchar2 default null,
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
begin
-- setup by default
    g_app_config        := new app_config();
    g_config            := new pljson() ;
    g_config.put('table_name', app_meta_data_util.get_table_name(pi_table_name => 'config'));
end app_config_util;
/