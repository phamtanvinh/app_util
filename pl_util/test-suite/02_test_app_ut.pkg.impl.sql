create or replace package body app_ut
as
begin
    g_pljson1 := new pljson('{"a":"1", "b": "2", "c": "3", "d": "4", "e": "5"}');
    g_pljson2 := new pljson('{"a":"1", "b": "updated", "c": "updated", "city": "add more", "province": "Tien Giang"}');
    g_pljson3 := new pljson('{"a1": "12", "a2": "13", "a4": "nothing", "a5": "texas"}');
    g_pljson4 := new pljson('{"dt": "datetime", "bl": "boolean", "ts"; "timestamp", "es"; "elasticsearch", "gg": "google"}');
end app_ut;
/