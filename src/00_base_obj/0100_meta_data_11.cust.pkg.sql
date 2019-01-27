create or replace package meta_data_custom
as
/* **********************************************************************************
 * app_meta_data_util
 * **********************************************************************************
 *  description: 
 * **********************************************************************************/
    g_config        pljson;
end meta_data_custom;
/

create or replace package body meta_data_custom
as
begin
    g_config        := new pljson();
end meta_data_custom;