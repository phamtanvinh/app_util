create or replace package body app_ut
as
    pass_count          number;
    fail_count          number;
    total_count         number;
    rpad_size           number;
    test_case           pljson;

    procedure reload
    is
    begin
        pass_count          := 0;
        fail_count          := 0;
        total_count         := 0;
        rpad_size           := 20;
        test_case           := new pljson;
    end;

    procedure pass(pi_test_case varchar2)
    is
    begin
        pass_count      := pass_count + 1;
        total_count     := total_count + 1;
        test_case.put(pi_test_case, 'Passed');
        dbms_output.put_line('Passed: ' || pi_test_case);
    end;

    procedure fail(pi_test_case varchar2)
    is
    begin
        fail_count      := fail_count + 1;
        total_count     := total_count + 1;
        test_case.put(pi_test_case, 'Failed');
        dbms_output.put_line('Failed: ' || pi_test_case);
    end;

    procedure assertTrue(pi_is_true boolean, pi_test_case varchar2)
    is
    begin
        if pi_is_true then
            pass(pi_test_case);
        else
            fail(pi_test_case);
        end if;
    end;

    procedure assertFasle(pi_is_true boolean, pi_test_case varchar2)
    is
    begin
        if not pi_is_true then
            pass(pi_test_case);
        else
            fail(pi_test_case);
        end if;
    end;

    procedure result_test
    is
    begin
        dbms_output.put_line(rpad('TOTAL', rpad_size, chr(32)) || ':' || total_count);
        dbms_output.put_line(rpad('PASSED', rpad_size, chr(32)) || ':' || pass_count);
        dbms_output.put_line(rpad('FAILED', rpad_size, chr(32)) || ':' || fail_count);
        app_util.print(test_case);
    end;
begin
    reload;
    g_pljson1 := new pljson('{"a":"1", "b": "2", "c": "3", "d": "4", "e": "5"}');
    g_pljson2 := new pljson('{"a":"1", "b": "updated", "c": "updated", "city": "add more", "province": "Tien Giang"}');
    g_pljson3 := new pljson('{"a1": "12", "a2": "13", "a4": "nothing", "a5": "texas"}');
    g_pljson4 := new pljson('{"dt": "datetime", "bl": "boolean", "ts": "timestamp", "es": "elasticsearch", "gg": "google"}');
end app_ut;
/