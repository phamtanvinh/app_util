create or replace package body app_util
as
/*
 *  Feature: manipulate string
 */
    function get_string_format(
        pi_key          varchar2, 
        pi_value        varchar2, 
        pi_rpad_size    number default g_rpad_size) return varchar2
    is
        l_string            varchar2(4000);
    begin
        return  rpad(pi_key, pi_rpad_size, chr(32))|| ':' || pi_value || chr(10);
    end;

    function get_string_format(
        pi_dictionary   dictionary,
        pi_rpad_size    number default g_rpad_size) return varchar2
    is
        l_key           varchar2(64) := pi_dictionary.first;
        l_value         varchar2(4000);
        l_string        varchar2(4000);
    begin
        while l_key is not null loop
            l_value     := pi_dictionary(l_key);
            l_string    := l_string || get_string_format(l_key, l_value, pi_rpad_size);
            l_key       := pi_dictionary.next(l_key);
        end loop;
        return l_string;
    end;

    function get_string_format(
        pi_jo           pljson,
        pi_rpad_size    number default g_rpad_size) return varchar2
    is
        l_keys          pljson_list := pi_jo.get_keys;
        l_key           varchar2(64);
        l_value         varchar2(4000);
        l_string        varchar2(4000);
    begin
        for i in 1..l_keys.count loop
            l_key       := l_keys.get(i).get_string;
            l_value     := pi_jo.get(l_key).get_string;
            l_string    := l_string || get_string_format(pi_key => l_key, pi_value => l_value, pi_rpad_size => pi_rpad_size);
        end loop;
        return l_string;
    end;

    procedure print(
        pi_key          varchar2, 
        pi_value        varchar2, 
        pi_rpad_size    number default g_rpad_size)
    is
        l_string        varchar2(4000);
    begin
        l_string        := get_string_format(pi_key, pi_value, pi_rpad_size);
        dbms_output.put_line(l_string);
    end;

    procedure print(
        pi_dictionary   dictionary,
        pi_rpad_size    number default g_rpad_size)
    is
        l_string        varchar2(4000);
    begin
        l_string        := get_string_format(pi_dictionary, pi_rpad_size);
        dbms_output.put_line(l_string);
    end;

    procedure print(
        pi_jo           pljson,
        pi_rpad_size    number default g_rpad_size )
    is
        l_string        varchar2(4000);
    begin
        l_string        := get_string_format(pi_jo => pi_jo, pi_rpad_size => pi_rpad_size);
        dbms_output.put_line(l_string);
    end;

     procedure print(
        pi_string       varchar2,
        pi_is_previewed boolean default true
    )
    is
    begin
        if pi_is_previewed then
            dbms_output.put_line(pi_string);
        end if;
    end;

/*
 *  Feature: manipulate table
 */
    function exist_table(pi_table_name varchar2) return boolean
    is
        l_is_true   boolean := false;
        l_counter   number;
    begin
        select count(*)
        into l_counter 
        from tab 
        where tname = upper(pi_table_name);

        if l_counter > 0 then
            l_is_true := true;
        end if;

        return l_is_true;
    end;
    procedure drop_table(pi_table_name varchar2, pi_is_forced boolean default false)
    is
        l_string        varchar2(4000);
    begin
        l_string    := 'drop table ' || pi_table_name || ' cascade constraints purge';
        if exist_table(pi_table_name) and pi_is_forced then
            execute immediate l_string;
        end if;
          
    end;

/*
 *  Feature: manipulate date and time
 */
    function get_dnum(pi_ts timestamp default current_timestamp) return number
    is
    begin
        return to_number(to_char(pi_ts, 'yyyymmdd'));
    end;
    
    function get_tnum(pi_ts timestamp default current_timestamp) return number
    is
    begin
        return to_number(to_char(pi_ts, 'hh24miss'));
    end;
    
    function get_unix_ts(pi_ts timestamp default current_timestamp) return number
    is
    begin
        return round((cast(pi_ts as date) - date '1970-01-01')*24*60*60);
    end;
/*
 *  Feature: manipulate dictionary
 */
    function get_dictionary(pi_json    pljson) return dictionary
    is
        l_keys          pljson_list := pi_json.get_keys;
        l_dictionary    dictionary;
    begin
        for i in 1..l_keys.count loop
            l_dictionary(l_keys.get(i).get_string) := pi_json.get(l_keys.get(i).get_string).get_string;
        end loop;

        return l_dictionary;
    end;
/*
 *  Feature: manipulate transaction
 */
    function get_transaction_id return varchar2
    is
    begin
        return dbms_transaction.local_transaction_id(true);
    end;
/*
 *  Feature: manipulate json
 */
    procedure update_json(
        pio_json in out pljson,
        pi_json         pljson
    )
    is
        l_keys      pljson_list := pi_json.get_keys;
        l_key       varchar2(64);
    begin
        for i in 1..l_keys.count loop
            l_key   := l_keys.get(i).get_string;
            if pio_json.exist(l_key) then
                pio_json.put(l_key, pi_json.get(l_key));
            end if;
        end loop;
    end;

    procedure update_json(
        pio_json in out pljson,
        pi_json         varchar2
    )
    is
        l_json  pljson := pljson(pi_json);
    begin
        update_json(
            pio_json    => pio_json,
            pi_json     => l_json
        );
    end;

    procedure merge_json(
        pio_tar_json in out pljson,
        pi_src_json         pljson
    )
    is
        l_keys      pljson_list := pi_src_json.get_keys;
        l_key       varchar2(64);
    begin
        for i in 1..l_keys.count loop
            l_key := l_keys.get(i).get_string;
            pio_tar_json.put(l_key, pi_src_json.get(l_key));
        end loop;
    end;
    
    procedure merge_json(
        pio_tar_json in out pljson,
        pi_src_json         varchar2
    )
    is
        l_json  pljson := pljson(pi_src_json);
    begin
        merge_json(
            pio_tar_json    => pio_tar_json,
            pi_src_json     => l_json
        );
    end;
/*
 *  Feature: manipulate package
 */
    function exist_package(pi_package_name varchar2) return boolean
    is
        l_is_true   boolean := false;
        l_counter   number;
    begin
        select count(*) 
        into l_counter 
        from user_objects 
        where object_type = 'PACKAGE' 
            and object_name = upper(pi_package_name);

        if l_counter > 0 then
            l_is_true := true;
        end if;

        return l_is_true;
    end;
/*
 * Featue: execute sql
 */
    procedure exec(
        pi_sql          varchar2, 
        pi_is_forced    boolean     default false)
    is
    begin
        if pi_is_forced then
            execute immediate pi_sql;
        end if;
    end;
end app_util;
/