create or replace package body app_logger_util
as
/*
 *  Private attributes
 */
    /** */
    "__config__"            pljson;
/*
 *  Internal methods
 */
    procedure get_config
    is
    begin
        g_config    := app_setting.g_logger;
    end;

    procedure set_attributes
    is
    begin
        "__config__"            := new pljson;
        g_config                := new pljson;
        g_app_config            := new app_config;
        g_app_logger            := new app_logger;
    end;

/*
 *  Global methods
 */
    procedure initialize(pi_is_forced boolean default false)
    is
        l_sql       varchar2(4000);
    begin
        dbms_output.put_line('Initialize ...');

        app_util.print('Drop tables if any exist...', pi_is_forced);
        app_util.drop_table(g_config.get('running_table').get_string, pi_is_forced);
        app_util.drop_table(g_config.get('exception_table').get_string, pi_is_forced);

        l_sql := app_logger_sql.get_create_logger_running_sql();
        app_util.print(l_sql, not(pi_is_forced));
        app_util.exec(l_sql, pi_is_forced);
        app_util.print('Created table ' || g_config.get('running_table').get_string, pi_is_forced);

        l_sql := app_logger_sql.get_create_logger_exception_sql();
        app_util.print(l_sql, not(pi_is_forced));
        app_util.exec(l_sql, pi_is_forced);
        app_util.print('Created table ' || g_config.get('exception_table').get_string, pi_is_forced);

        dbms_output.put_line('Done');
    end;
    
    procedure set_logger(pi_app_logger app_logger)
    is
    begin
        g_app_logger    := pi_app_logger;
    end;
    -- this is anchor for updating logger (last call)
    procedure insert_logger_running(pi_app_logger app_logger)
    is
        l_sql   varchar2(4000);
    begin
        l_sql   := app_logger_sql.get_insert_logger_running_sql();
        -- dbms_output.put_line(l_sql);
        execute immediate l_sql
            using 
                pi_app_logger.transaction_id,
                pi_app_logger.transaction_code,
                pi_app_logger.app_user,
                pi_app_logger.unit_name,
                pi_app_logger.unit_type,
                pi_app_logger.log_step_description,
                pi_app_logger.log_step_id,
                pi_app_logger.log_step_name,
                pi_app_logger.created_date,
                pi_app_logger.created_unix_ts,
                pi_app_logger.updated_date,
                pi_app_logger.updated_unix_ts,
                pi_app_logger.duration;
    end;

    -- this will be update step and datetime and duration
    procedure insert_logger_running(
        pi_log_step_name        varchar2,
        pi_log_step_description varchar2)
    is
    begin
        g_app_logger.update_step(
            pi_log_step_name        => pi_log_step_name,
            pi_log_step_description => pi_log_step_description
        );
        insert_logger_running(g_app_logger);
    end;

    procedure insert_logger_running(pi_is_default boolean default true)
    is
    begin
        if not(pi_is_default) 
        then
            insert_logger_running(
                pi_log_step_name        => null,
                pi_log_step_description => null
            );
        else
            insert_logger_running(g_app_logger);
        end if;
    end;

    procedure insert_logger_exception(pi_app_logger app_logger)
    is
        l_sql   varchar2(4000);
    begin
        l_sql   := app_logger_sql.get_insert_logger_exception_sql();
        --app_util.print(l_sql, not(pi_is_forced));
        execute immediate l_sql
            using 
                pi_app_logger.transaction_id,
                pi_app_logger.transaction_code,
                pi_app_logger.app_user,
                pi_app_logger.unit_name,
                pi_app_logger.unit_type,
                pi_app_logger.log_step_description,
                pi_app_logger.log_step_id,
                pi_app_logger.log_step_name,
                pi_app_logger.created_date,
                pi_app_logger.created_unix_ts,
                pi_app_logger.updated_date,
                pi_app_logger.updated_unix_ts,
                pi_app_logger.duration,
                pi_app_logger.error_sqlcode,
                pi_app_logger.error_sqlerrm,
                pi_app_logger.error_backtrace;
    end;
    procedure insert_logger_exception(pi_is_forced boolean default false)
    is
    begin
        g_app_logger.initialize_exception();
        g_app_logger.get_duration(pi_is_total => true);
        if pi_is_forced then
            insert_logger_exception(g_app_logger);
        else
            g_app_logger.print;
        end if;
    end;

begin
    /* Load all internal methods. */
    set_attributes;
    get_config;
end;
/