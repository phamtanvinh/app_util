create or replace package app_logger_sql
/**
* Project:      app_util<br/>
* Description:  App tool for data management.
* @author Vinhpt
* @headcom
*/
as
/*
 *  Global attributes
 */
    /** */
    g_config                pljson;
    g_app_logger            app_logger;

/*
 *  Internal methods
 */
    /** Internal method. */
    procedure get_config;
    /** Internal method. */
    procedure set_attributes;

/*
 *  Global methods
 */
    /** */
    function get_create_logger_running_sql return varchar2;
    function get_create_logger_exception_sql return varchar2;
    function get_insert_logger_running_sql return varchar2;
    function get_insert_logger_exception_sql return varchar2;
end app_logger_sql;
/
