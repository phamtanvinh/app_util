create or replace package app_meta_data_util
as
/* **********************************************************************************
 * app_meta_data_util
 * **********************************************************************************
 *  description: 
 * **********************************************************************************/
-- global
    g_config                pljson;
    g_prefix                pljson;
    g_suffix                pljson;
    function get_object_name(
        pi_object_name      varchar2,
        pi_prefix           varchar2 default null,
        pi_suffix           varchar2 default null
    ) return varchar2;

    function get_table_name(
        pi_table_name       varchar2,
        pi_prefix           varchar2 default null,
        pi_suffix           varchar2 default null
    ) return varchar2;
end app_meta_data_util;
/