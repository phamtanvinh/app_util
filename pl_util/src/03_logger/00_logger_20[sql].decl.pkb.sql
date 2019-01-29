create or replace package app_logger_sql
as
/* **********************************************************************************
** app_logger_sql
** **********************************************************************************
**  description: 
** **********************************************************************************/
-- global config
    g_app_logger            app_logger;
    g_config                pljson;
-- private config
    "__config__"            pljson;
-- manipulate config
    procedure reset_config;
-- get sql
    function get_create_logger_running_sql return varchar2;
    function get_create_logger_exception_sql return varchar2;
    function get_insert_logger_running_sql return varchar2;
    function get_insert_logger_exception_sql return varchar2;
end app_logger_sql;
/
