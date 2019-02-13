create or replace package app_config_util
/**
* Project:      app_util<br/>
* Description:  App tool for data management.
* @author Vinhpt
* @headcom
*/
authid current_user
as
-- global config
    /** */
    g_config                pljson;
-- private config
    /** */
    "__config__"            varchar2(4000);
-- manipulate attributes
    /** */
    procedure set_config(pi_app_config  app_config default null);
    procedure get_config;
    procedure get_config(
        pi_config_id        varchar2 default null,
        pi_config_code      varchar2,
        pi_config_name      varchar2,
        pi_status           varchar2 default 'active'
    );
    /** Get config from table and set into variable.
    * @param po_app_config Output to config variable
    */    
    procedure get_config(
        pi_config_id        varchar2 default null,
        pi_config_code      varchar2,
        pi_config_name      varchar2,
        pi_status           varchar2 default 'active',
        po_app_config       out app_config
    );
-- manipulate tables
    /** */
    procedure initialize(pi_is_forced boolean default false);
    procedure insert_config;
end app_config_util;
/