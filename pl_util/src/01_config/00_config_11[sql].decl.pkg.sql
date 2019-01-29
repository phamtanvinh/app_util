create or replace package app_config_sql
as
/* **********************************************************************************
 * app_config_sql
 * **********************************************************************************
 *  description: 
 * **********************************************************************************/
-- global config
    g_config                pljson;
    g_table_name            varchar2(64);
-- private config
    "__config__"            pljson;
-- global attributes
-- update config
    procedure update_config;
-- get sql
    function get_create_table_sql return varchar2;
    function get_insert_sql return varchar2;
    function get_config_sql return varchar2;
end app_config_sql;
/