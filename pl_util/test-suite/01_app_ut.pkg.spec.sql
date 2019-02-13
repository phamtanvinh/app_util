create or replace package app_ut
as
    g_pljson1 pljson;
    g_pljson2 pljson;
    g_pljson3 pljson;
    g_pljson4 pljson;
    g_pljson5 pljson;
    procedure reload;
    procedure pass(pi_test_case varchar2);
    procedure fail(pi_test_case varchar2);
    procedure assertTrue(pi_is_true boolean, pi_test_case varchar2);
    procedure assertFasle(pi_is_true boolean, pi_test_case varchar2);
    procedure result_test;
end app_ut;
/