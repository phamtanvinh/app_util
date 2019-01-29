create or replace package app_config_util
authid current_user
as
/* **********************************************************************************
 * app_config_util
 * **********************************************************************************
 *  description: 
 * **********************************************************************************/
-- global config
    g_app_config            app_config;
    g_config                pljson;
-- private config
    "__config__"            varchar2(4000);
-- manipulate config
    procedure refresh_config;
-- manipulate attributes
    procedure set_config(pi_app_config  app_config default null);
-- manipulate tables
    procedure initialize(pi_is_forced boolean default false);
    procedure insert_config;
    procedure get_config(
        pi_config_id        varchar2 default null,
        pi_config_code      varchar2 default null,
        pi_config_name      varchar2 default null,
        pi_status           varchar2 default 'active'
    );    
    procedure get_config(
        pi_config_id        varchar2 default null,
        pi_config_code      varchar2 default null,
        pi_config_name      varchar2 default null,
        pi_status           varchar2 default 'active',
        po_app_config       out app_config
    );
end app_config_util;
/