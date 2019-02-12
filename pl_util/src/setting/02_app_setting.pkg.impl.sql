create or replace package body app_setting
as
    procedure reset_all
    is
    begin
        set_logger();
    end;

    procedure set_logger
    is
    begin
        g_logger := new pljson();
        g_logger.put('running_table'    ,'ods_logger_running');
        g_logger.put('exception_table'  ,'ods_logger_exception');   
    end;
begin
    reset_all;
end app_setting;
/