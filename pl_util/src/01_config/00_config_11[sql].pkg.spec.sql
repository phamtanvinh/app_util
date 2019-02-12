create or replace package app_config_sql
/**
* Project:      app_util<br/>
* Description:  App tool for data management.
* @author Vinhpt
* @headcom
*/
as
-- global config
    /***/
    g_config                pljson;
    g_table_name            varchar2(64);
-- private config
    /***/
    "__config__"            pljson;
-- global attributes
-- update config
    /***/
    procedure update_config;
-- get sql
    /***/
    function get_create_table_sql return varchar2;
    function get_insert_sql return varchar2;
    function get_config_sql return varchar2;
end app_config_sql;
/