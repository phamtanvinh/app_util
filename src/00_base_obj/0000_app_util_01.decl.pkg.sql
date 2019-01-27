create or replace package app_util
as
/* **********************************************************************************
 * app_util
 * **********************************************************************************
 *  description: 
 * **********************************************************************************/
-- global attributes
    g_rpad_size         number := 30;
-- global types
    type tuple is table of varchar2(4000);
    type dictionary is table of varchar2(4000) index by varchar2(64);
-- feature: manipulate string
    function get_string_format(
        pi_key          varchar2, 
        pi_value        varchar2, 
        pi_rpad_size    number default g_rpad_size) return varchar2;
    
    function get_string_format(
        pi_dictionary   dictionary,
        pi_rpad_size    number default g_rpad_size) return varchar2;
    function get_string_format(
        pi_jo           pljson,
        pi_rpad_size    number default g_rpad_size) return varchar2;
    procedure print_string_format(
        pi_key          varchar2, 
        pi_value        varchar2, 
        pi_rpad_size    number default g_rpad_size);

    procedure print_string_format(
        pi_dictionary   dictionary,
        pi_rpad_size    number default g_rpad_size);
    
    procedure print_string_format(
        pi_jo           pljson,
        pi_rpad_size    number default g_rpad_size );
-- feature: manipulate table
    function exist_table(pi_table_name varchar2) return boolean;
    procedure drop_table(pi_table_name varchar2, pi_is_forced boolean default false);
-- feature: manipulate date and time
    function get_dnum(pi_ts timestamp default current_timestamp) return number;
    function get_tnum(pi_ts timestamp default current_timestamp) return number;
    function get_unix_ts(pi_ts timestamp default current_timestamp) return number;
-- feature: manipulate dictionary
    function get_dictionary(pi_json    pljson) return dictionary;
-- feature: manipulate transaction
    function get_transaction_id return varchar2;
-- feature: manipulate json
    procedure update_json(
        pio_json in out pljson,
        pi_json         pljson
    );    
    procedure update_json(
        pio_json in out pljson,
        pi_json         varchar2
    );
end app_util;
/