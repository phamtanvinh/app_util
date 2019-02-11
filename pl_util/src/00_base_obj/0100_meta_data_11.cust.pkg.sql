create or replace package meta_data_custom
/**
* Project:      app_util<br/>
* Description:  App tool for data management.
* @author Vinhpt
* @headcom
*/
as
    g_config        pljson;
end meta_data_custom;
/

create or replace package body meta_data_custom
as
begin
    g_config        := new pljson();
end meta_data_custom;
/