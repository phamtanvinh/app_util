declare
    l_logger APP_LOGGER := new APP_LOGGER(        
        pi_transaction_code     => '123456',
        pi_app_user             => 'VINHPT',
        pi_unit_name            => 'test',
        pi_unit_type            => 'test');
begin
    l_logger.print_attributes_info(true);
    --dbms_lock.sleep(1);
    l_logger.update_step('step 2');
    --l_logger.print_attributes_info(true);
    l_logger.get_attributes_info();
--    app_util.print_string_format(l_logger."__attributes__");
    raise no_data_found;
exception
    when others then
        l_logger.initialize_exception();
        l_logger.print_attributes_info(true);
end;
/

begin
    app_logger_sql.g_running_table := 'ODS_LOGGER_RUNNING';
    dbms_output.put_line(app_logger_sql.g_running_table);
end;
/

-- logger initialize logger tables
begin
    --app_logger_util.refresh_config();
    --dbms_output.put_line(app_logger_sql.g_config.to_string);
    app_logger_util.initialize(true);
end;
/

truncate table ODS_LOGGER_RUNNING;
/

select * from ODS_LOGGER_RUNNING
/

select * from ODS_LOGGER_EXCEPTION
/

-- test insert logging
declare
    l_logger APP_LOGGER := new APP_LOGGER(        
        pi_transaction_code     => '123456',
        pi_app_user             => 'VINHPT',
        pi_unit_name            => 'test',
        pi_unit_type            => 'test');
begin
    app_logger_util.set_logger(l_logger);
    app_logger_util.insert_logger_running();
    app_logger_util.g_app_logger.print_attributes_info(true);
    app_logger_util.insert_logger_running('step 1', 'test description');
    dbms_lock.sleep(1);
    app_logger_util.g_app_logger.update_step('step 2', 'test description');
    app_logger_util.g_app_logger.print_attributes_info(true);
    app_logger_util.insert_logger_running(true);
    --dbms_lock.sleep(1);
    --app_logger_util.insert_logger_running(true);
    --dbms_lock.sleep(1);
    --app_logger_util.insert_logger_running(true);
    raise no_data_found;
exception
    when others then
        app_logger_util.insert_logger_exception();
end;
/


begin
dbms_output.put_line(APP_LOGGER_UTIL.g_config.to_string);
dbms_output.put_line(APP_LOGGER_UTIL.g_config.to_string);
dbms_output.put_line(APP_LOGGER_CUSTOM.g_config.to_string);
dbms_output.put_line(APP_LOGGER_SQL.g_config.to_string);
--APP_LOGGER_UTIL.set_global_config();
--dbms_output.put_line(APP_LOGGER_UTIL.g_config.to_string);
end;
/

begin
APP_LOGGER_UTIL.initialize();
end;
/

begin
APP_LOGGER_SQL.reset_config();
dbms_output.put_line(APP_LOGGER_SQL.g_config.to_string);
end;
/

-- get config from table
begin
    APP_LOGGER_UTIL.reset_config();
    dbms_output.put_line(APP_LOGGER_UTIL."__config__".to_char);
    APP_LOGGER_UTIL.get_private_config();
    --APP_LOGGER_UTIL.g_app_config.print_attributes_info();
    dbms_output.put_line(APP_LOGGER_UTIL.g_config.to_char);
    dbms_output.put_line(APP_LOGGER_UTIL."__config__".to_char);
end;