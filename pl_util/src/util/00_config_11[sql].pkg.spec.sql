create or replace package app_config_sql
/**
* Project:      app_util<br/>
* Description:  App tool for data management.
* @author Vinhpt
* @headcom
*/
as
-- global config
    /** */
    g_config                pljson;
    /** */
    "__config__"            pljson;
-- manipulate config
    /** */
    procedure get_config;
-- manipulate private attributes
    /** */
    procedure set_private_attributes;
-- get sql
    /** */
    function get_create_table_sql return varchar2;
    function get_insert_sql return varchar2;
    function get_config_sql return varchar2;
end app_config_sql;
/