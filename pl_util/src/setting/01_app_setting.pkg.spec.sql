create or replace package app_setting
/**
* Project: app_util <br/>
* Description: this package will hold all user setting.
* @author Vinhpt
*/
as
    /** 
    * Initializes all user config setting.
    */
    procedure load_customization;
    /** Reset all setting to default.*/
    procedure reset_all;
    /** Setting meta data.*/
    /** Setting config.*/
    procedure set_config;
    /** Setting logger.*/
    procedure set_logger;
    /** */
    function get_meta_data return pljson;
    /** */
    function get_config return pljson;
    /** */
    function get_logger return pljson;
end app_setting;
/