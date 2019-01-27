declare
    l_dictionary app_util.DICTIONARY;
begin
    l_dictionary('name') := 'VINH';
    l_dictionary('job') := 'engineer';
    app_util.print_string_format(l_dictionary, 40);
end;
/

declare
    l_test      APP_BASE_OBJECT := new APP_BASE_OBJECT();
begin
    l_test.print_attributes_info();
    dbms_lock.sleep(1);
    l_test.update_all();
    l_test.print_attributes_info();
end;
/

declare 
    l_config    APP_CONFIG := APP_CONFIG();
begin
    l_config.print_attributes_info();
    l_config.set_config(pi_config_value => PLJSON('{"name": "vinhpt", "job": "engineer"}'));
    l_config.print_config_value();   
    l_config.print_attributes_info();

end;
/

create table app_config_tab of app_config;
/

declare
begin
    dbms_output.put_line(APP_META_DATA_UTIL.g_config_default.get_string('table_name'));
    dbms_output.put_line(APP_META_DATA_UTIL.get_object_name('test_name', pi_suffix => 'test'));
end;
/

begin
    dbms_output.put_line(coalesce(NULL || '_' ||'12345', '12345'));

end;
/
-- test extend
declare
    l_extend APP_EXTEND := new APP_EXTEND();
begin
    null;
    l_extend.print_attributes_info();
    --dbms_lock.sleep(1);
    l_extend.update_all(); 
    l_extend.print_attributes_info(true);
    --dbms_lock.sleep(2);
    --l_extend.update_all();
    --l_extend.print_attributes_info(true);
end;
/


-- update json
declare
    l_json1 PLJSON := new PLJSON('{"a": 1, "b": 2}');
    l_json2 PLJSON := new PLJSON('{"a": 4, "b": 6}');
begin
    app_util.update_json(l_json1, l_json2);
    l_json1.print;
end;
