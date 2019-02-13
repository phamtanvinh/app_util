create or replace package body app_setting
as
    /** Setting meta data.*/
    g_meta_data         pljson;
    /** Setting config.*/
    g_config            pljson;
    /** Setting logger.*/
    g_logger            pljson;

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

    function get_meta_data return pljson
    is
    begin
        return g_meta_data;
    end;

    function get_config return pljson
    is
    begin
        return g_config;
    end;

    function get_logger return pljson
    is
    begin
        return g_logger;
    end;

begin
    reset_all;
    load_customization;
end app_setting;
/