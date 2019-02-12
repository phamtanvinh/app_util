create or replace package app_logger_custom
as
/* **********************************************************************************
 * app_logger_util
 * **********************************************************************************
 *  description: 
 * **********************************************************************************/
    g_config        pljson;
-- setting config
    procedure reset_config;
end app_logger_custom;
/

create or replace package body app_logger_custom
as
    procedure reset_config
    is
    begin
        g_config        := new pljson();
        g_config.put('running_table'    ,'ods_logger_running');
        g_config.put('exception_table'  ,'ods_logger_exception');      
    end;
begin
    reset_config();
end app_logger_custom;
/