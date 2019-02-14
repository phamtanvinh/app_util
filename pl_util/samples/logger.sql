begin
    dbms_session.reset_package;
end;
/

/* demo create table */
declare
begin
    /* preview logger setting */
    --app_util.print(app_setting.g_logger);
    --dbms_output.put_line('1');
    --app_util.print(app_logger_sql.g_config);
    --dbms_output.put_line('2');
    --app_util.print(app_logger_util.g_config);
    /* print sql */
    --app_logger_util.initialize;
    /* force to create tables */
    app_logger_util.initialize(true);
end;
/
sho err
/
/* check table existed */
select * from ods_logger_running
/

/* check table existed */
select * from ods_logger_exception
/

sho err
/

/* demo init attributes */
declare
begin
    app_logger_util.g_app_logger.print;    
end;
/

sho err
/

/* demo insert log step */
declare
    l_logger app_logger := new app_logger(
        pi_transaction_code => 'test code',
        pi_app_user         => 'vinhpt',
        pi_unit_name        => 'test process',
        pi_unit_type        => 'test process'
    );
begin
    app_logger_util.set_logger(l_logger);
    app_logger_util.insert_running;
    app_logger_util.insert_running('step 1', 'no description');
    /* apex */
    --dbms_session.sleep(1);
    --dbms_lock.sleep(1);
    app_logger_util.insert_running('step 2', 'no description');
    app_logger_util.insert_running(false);
    /* apex */
    --dbms_session.sleep(1);
    --dbms_lock.sleep(1);
    app_logger_util.insert_running(false);
    raise no_data_found;
exception
    when no_data_found then
        app_logger_util.insert_exception(true);
end;
/

/* check new logging */
select * from ods_logger_running
/

/* check new exception */
select * from ods_logger_exception
/
