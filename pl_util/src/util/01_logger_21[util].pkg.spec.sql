create or replace package app_logger_util
/**
* Project:      app_util<br/>
* Description:  This package is used to log application processes.
* @author Vinhpt
* @headcom
*/
as
-- global config
    /** */
    g_config                pljson;
    g_app_config            app_config;
    g_app_logger            app_logger;
-- private config
    /** */
    "__config__"            pljson;
-- manipulate tables
    /** */
    procedure get_config;
    /** */
    procedure initialize(pi_is_forced boolean default false);
    procedure set_logger(pi_app_logger app_logger);
    procedure insert_logger_running(pi_app_logger app_logger);
    procedure insert_logger_running(
        pi_log_step_name        varchar2,
        pi_log_step_description varchar2
    );
    procedure insert_logger_running(
        pi_is_repeated      boolean default false
    );
    procedure insert_logger_exception;
end app_logger_util;
/