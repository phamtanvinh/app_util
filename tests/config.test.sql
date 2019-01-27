-- initialize config table
begin
    APP_CONFIG_UTIL.initialize();
end;
/

select * from app_config_tab;
/

-- 

drop table app_config_ods;

begin
    APP_META_DATA_UTIL.g_config_default.put('table_name', 'app_config_ods');
    execute immediate 'alter package APP_META_DATA_UTIL COMPILE body';
end;
/

begin
    APP_CONFIG_UTIL.g_app_config.print_attributes_info();
end;

/

select * from app_config_tab;
/

truncate table app_config_tab;
/

-- insert new config
declare
    l_app_config        APP_CONFIG;
begin
    l_app_config := new app_config();
    l_app_config.initialize(
        pi_config_code			=> 'APP_LOGGER',
        pi_config_user			=> 'VINHPT',
        pi_config_name			=> 'APP_LOGGER',
        pi_config_value			=> JSON_OBJECT_T('{"__mode__": "ACTIVE"}'),
        pi_description          => 'Initialize logger config',
        pi_config_type			=> 'APP_LOGGER'
    );
    app_config_util.set_config(l_app_config);
    app_config_util.g_app_config.print_attributes_info();
    --dbms_output.put_line(app_config_util.g_config_name);
    app_config_util.insert_config();
end;
/

-- get config
declare
    l_app_config        APP_CONFIG;
begin
    app_config_util.get_config(
        pi_config_code => 'APP_LOGGER', 
        pi_config_name => 'APP_LOGGER', 
        po_app_config  => l_app_config
    );
    l_app_config := APP_CONFIG_UTIL.g_app_config;
    l_app_config.print_attributes_info();
end;
