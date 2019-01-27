declare
    l_json APP_JSON := new APP_JSON();
begin
    l_json := new APP_JSON('{"name": "vinh", "age": 25, "job": "engineer"}');
    dbms_output.put_line(l_json.get('name'));
--    l_json.print_attributes_info();
    
end;
/

declare
    l_json PLJSON := new PLJSON('{"name": "vinh", "age": 25, "job": "engineer"}');
    list pljson_list;
begin
    l_json.put('status', 'single');
    l_json.put('status', 'in relationship');
    list := pljson_list();
    list.append(pljson('{"lazy construction": true}').to_json_value);
    list.append(pljson_list('[1,2,3,4,5]'));
    list.print(false);
    l_json := pljson(
    '{
      "a" : true,
      "b" : [1,2,"3"],
      "c" : {
        "d" : [["array of array"], null, { "e": 7913 }]
      }
    }');
    pljson_ext.put(l_json, 'c.d[3].e', 123);
    
    dbms_output.put_line(l_json.get_keys().count);

end;
/


select * from table(pljson_table.json_table(
  '[
    { "id": 0, "displayname": "Back",  "qty": 5, "extras": [ { "xid": 1, "xtra": "extra_1" }, { "xid": 21, "xtra": "extra_21" } ] },
    { "id": 2, "displayname": "Front", "qty": 2, "extras": [ { "xid": 9, "xtra": "extra_9" }, { "xid": 90, "xtra": "extra_90" } ] },
    { "id": 3, "displayname": "Middle", "qty": 9, "extras": [ { "xid": 5, "xtra": "extra_5" }, { "xid": 20, "xtra": "extra_20" } ] }
  ]',
  pljson_varray('[*].id', '[*].displayname', '[*].qty', '[*].extras[*].xid', '[*].extras[*].xtra'),
  pljson_varray('id', 'displayname', 'qty', 'xid', 'xtra'),
  table_mode => 'nested'
));
/


declare
    l_json PLJSON := new PLJSON();
begin
    l_json.print(false);
end;