create or replace package body app_setting
as
    procedure load_customization
    is
    begin
        g_logger.put('running_table'    ,'ods_logger_running');
        g_logger.put('exception_table'  ,'ods_logger_exception');   
    end;

    procedure reset_all
    is
    begin
        set_logger();
        set_config();
    end;
    procedure set_config
    is
    begin
        g_config := new pljson;
        g_config.put('table_name', app_meta_data.get_table_name(pi_table_name => 'config'));
    end;

    procedure set_logger
    is
    begin
        g_logger := new pljson;
        g_logger.put('running_table',app_meta_data.get_table_name(pi_table_name => 'logger_running'));
        g_logger.put('exception_table',app_meta_data.get_table_name(pi_table_name => 'logger_exception'));     
    end;
begin
    reset_all;
    load_customization;
end app_setting;
/