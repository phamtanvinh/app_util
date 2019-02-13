create or replace package body app_logger_util
as
-- get config
    procedure get_config
    is
    begin
        g_config    := app_setting.get_logger;
    end;
-- manipulate tables
    procedure initialize(pi_is_forced boolean default false)
    is
        l_sql       varchar2(4000);
    begin
        dbms_output.put_line('initialize ...');
        if pi_is_forced
        then 
            app_util.drop_table(g_config.get('running_table').get_string, true);
            app_util.drop_table(g_config.get('exception_table').get_string, true);
        end if;

        l_sql       := app_logger_sql.get_create_logger_running_sql();
        if pi_is_forced
        then 
            execute immediate l_sql;
        else
            dbms_output.put_line(l_sql);
        end if;

        l_sql       := app_logger_sql.get_create_logger_exception_sql();
        if pi_is_forced
        then 
            execute immediate l_sql;
        else
            dbms_output.put_line(l_sql);
        end if;
        dbms_output.put_line('done');
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
        g_app_logger := nvl(pi_app_logger, g_app_logger);
        l_sql   := app_logger_sql.get_insert_logger_running_sql();
        -- dbms_output.put_line(l_sql);
        execute immediate l_sql
            using 
                g_app_logger.transaction_id,
                g_app_logger.transaction_code,
                g_app_logger.app_user,
                g_app_logger.unit_name,
                g_app_logger.unit_type,
                g_app_logger.log_step_description,
                g_app_logger.log_step_id,
                g_app_logger.log_step_name,
                g_app_logger.created_date,
                g_app_logger.created_unix_ts,
                g_app_logger.updated_date,
                g_app_logger.updated_unix_ts,
                g_app_logger.duration;
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

    -- repeat step
    procedure insert_logger_running(
        pi_is_repeated      boolean default false
    )
    is
    begin
        if not(pi_is_repeated) 
        then
            g_app_logger.log_step_name          := null;
            g_app_logger.log_step_description   := null;
        end if;
        insert_logger_running(
            pi_log_step_name        => g_app_logger.log_step_name,
            pi_log_step_description => g_app_logger.log_step_description
        );
    end;

    procedure insert_logger_exception
    is
        l_sql   varchar2(4000);
    begin
        g_app_logger.initialize_exception();
        l_sql   := app_logger_sql.get_insert_logger_exception_sql();
        -- dbms_output.put_line(l_sql);
        execute immediate l_sql
            using 
                g_app_logger.transaction_id,
                g_app_logger.transaction_code,
                g_app_logger.app_user,
                g_app_logger.unit_name,
                g_app_logger.unit_type,
                g_app_logger.log_step_description,
                g_app_logger.log_step_id,
                g_app_logger.log_step_name,
                g_app_logger.created_date,
                g_app_logger.created_unix_ts,
                g_app_logger.updated_date,
                g_app_logger.updated_unix_ts,
                g_app_logger.duration,
                g_app_logger.error_sqlcode,
                g_app_logger.error_sqlerrm,
                g_app_logger.error_backtrace;
    end;

begin
    /** */
    get_config;
end;
/