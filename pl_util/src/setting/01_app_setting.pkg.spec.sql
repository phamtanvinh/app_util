create or replace package app_setting
/**
* Project: app_util <br/>
* Description: this package will hold all user setting.
* @author Vinhpt
*/
as
    /** Setting meta data.*/
    g_meta_data         pljson;
    /** Setting config.*/
    g_config            pljson;
    /** Setting logger.*/
    g_logger            pljson;
    /** Reset all setting to default.*/
    procedure reset_all;
    /** Setting meta data*/
    /** Setting config.*/
    /** Setting logger.*/
    procedure set_logger;
end app_setting;
/