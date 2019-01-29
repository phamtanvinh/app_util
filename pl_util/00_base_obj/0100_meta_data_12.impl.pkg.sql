create or replace package body app_meta_data_util
as
    function get_object_name(
        pi_object_name      varchar2,
        pi_prefix           varchar2 default null,
        pi_suffix           varchar2 default null
    ) return varchar2
    is
        l_object_name   varchar2(64);
    begin
        l_object_name   := nvl(pi_prefix, g_prefix.get('prefix').get_string()) || '_' || pi_object_name;
        if pi_suffix is not null then
            l_object_name := l_object_name || '_' || pi_suffix; 
        end if;

        return l_object_name;
    end;

    function get_table_name(
        pi_table_name       varchar2,
        pi_prefix           varchar2 default null,
        pi_suffix           varchar2 default null
    ) return varchar2
    is
        l_table_name    varchar2(64);
    begin
        l_table_name    := get_object_name(
                pi_object_name  => pi_table_name,
                pi_prefix       => nvl(pi_prefix, g_prefix.get('prefix').get_string()),
                pi_suffix       => nvl(pi_suffix, g_suffix.get('table').get_string())
            );

        return l_table_name; 
    end;
begin
    g_config            pljson := new pljson();
    g_prefix            pljson := new pljson();
    g_suffix            pljson := new pljson();
    g_prefix.put('prefix'       ,'app');
    g_suffix.put('table'        ,'tab');
    g_suffix.put('type'         ,'typ');
    g_suffix.put('package'      ,'pkg');
end app_meta_data_util;
/