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
-- manipulate config
    -- default config
    /** */
    procedure reset_config;
    procedure get_private_config;
    procedure set_global_config(
        pi_package_name     varchar2 default null,
        pi_config_name      varchar2 default null
    );
    -- [__config__] < [private] < [custom]
    /** */
    procedure refresh_config;
-- manipulate tables
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