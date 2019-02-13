create or replace package app_util
/**
* Project: app_util <br/>
* Description: This package will hold base methods for other packages, types, functions
* or produres.<br/>
* Features:<br/>
* <pre>
*   1. manipulate string
*   2. manipulate table
*   3. manipulate date and time
*   4. manipulate dictionary
*   5. manipulate transaction
*   6. manipulate json
*   7. manipulate package
* </pre>
* @author Vinhpt
* @headcom
*/
as
    /** Pading print format.*/
    g_rpad_size         number := 30;
    /** List of data, max size 4000.*/
    type tuple is table of varchar2(4000);
    /** Key length: 64, Value length: 4000.*/
    type dictionary is table of varchar2(4000) index by varchar2(64);
/*
 *  Feature: manipulate string
 */
    /**
    * Generate string to print format.
    * @param pi_key Pass key string
    * @param pi_value Pass value string
    * @param pi_rpad_size Pading size, if ignore then using g_rpad_size(30) 
    * @return varchar2
    */
    function get_string_format(
        pi_key          varchar2, 
        pi_value        varchar2, 
        pi_rpad_size    number default g_rpad_size) return varchar2;
    /** 
    * Generate string to print format.
    * @param pi_dictionary Pass dictionary
    * @param pi_rpad_size Pading size, if ignore then using g_rpad_size(30) 
    * @return varchar2
    */    
    function get_string_format(
        pi_dictionary   dictionary,
        pi_rpad_size    number default g_rpad_size) return varchar2;
    /** 
    * Generate string to print format.
    * @param pi_jo Pass pljson type
    * @param pi_rpad_size Pading size, if ignore then using g_rpad_size(30) 
    * @return varchar2
    */
    function get_string_format(
        pi_jo           pljson,
        pi_rpad_size    number default g_rpad_size) return varchar2;
    /** Print string from key, value.
    * @param pi_key Pass key
    * @param pi_value Pass value
    */
    procedure print(
        pi_key          varchar2, 
        pi_value        varchar2, 
        pi_rpad_size    number default g_rpad_size);
    /** Print string from dictionary.
    * @param pi_dictionary Pass dictionary, defined by app_util
    */
    procedure print(
        pi_dictionary   dictionary,
        pi_rpad_size    number default g_rpad_size);
    /** Print string from pljson.
    * @param pi_jo Pass plsjon
    */
    procedure print(
        pi_jo           pljson,
        pi_rpad_size    number default g_rpad_size );
    /** Print string with condition.
    * @param pi_string Pass string to preview
    * @param pi_is_previewed If true then print, or do nothing
    */
    procedure print(
        pi_string       varchar2,
        pi_is_previewed boolean default true
    );

/*
 *  Feature: manipulate table
 */
    /** 
    * Check table if exist.
    * @param pi_table_name Table name
    * @return boolean. If true then the table exists
    */
    function exist_table(pi_table_name varchar2) return boolean;
    /**
    * Drop table if exist.
    * @param pi_table_name Pass table name to drop
    * @param pi_is_forced Defaul false, if set true, this table will drop cascade
    */
    procedure drop_table(pi_table_name varchar2, pi_is_forced boolean default false);
/*
 *  Feature: manipulate date and time
 */
    /** 
    * Convert timestamp to format yyyymmdd.
    * @param pi_ts Pass timestamp
    * @return number
    */
    function get_dnum(pi_ts timestamp default current_timestamp) return number;
    /** 
    * Convert timestamp to format hh24miss.
    * @param pi_ts Pass timestamp
    * @return number
    */
    function get_tnum(pi_ts timestamp default current_timestamp) return number;
    /** 
    * Convert timestamp to unix timestamp.
    * @param pi_ts Pass timestamp
    * @return number
    */
    function get_unix_ts(pi_ts timestamp default current_timestamp) return number;

/*
 *  Feature: manipulate dictionary
 */
    /**
    * Generate a dictionary from pljson type.
    * @param pi_json Pass pljson
    * @return dictionary
    */
    function get_dictionary(pi_json    pljson) return dictionary;

/*
 *  Feature: manipulate transaction
 */
    /** 
    * Generate local transaction id.
    * @return varchar2
    */
    function get_transaction_id return varchar2;

/*
 *  Feature: manipulate json
 */
    /**
    * Update pljson from another, only keys exist.
    * @param pio_json Pass pljson object to update
    * @param pi_json This is source to update
    */
    procedure update_json(
        pio_json in out pljson,
        pi_json         pljson
    );
    /**
    * Update pljson from a json string, only keys exist.
    * @param pio_json Pass pljson object to update
    * @param pi_json This is source string to update
    */    
    procedure update_json(
        pio_json in out pljson,
        pi_json         varchar2
    );
    /** 
    * Merge json from other.
    * @param pio_tar_json   Pass target pljson
    * @param pi_src_json    Pass source pljson
    */
    procedure merge_json(
        pio_tar_json in out pljson,
        pi_src_json         pljson
    );
    /** 
    * Merge json from other.
    * @param pio_tar_json   Pass target pljson
    * @param pi_src_json    Pass source json string
    */    procedure merge_json(
        pio_tar_json in out pljson,
        pi_src_json         varchar2
    );

/*
 *  Feature: manipulate package
 */
    /** 
    * Check package is existed.
    * @param pi_package_name Pass package name
    */
    function exist_package(pi_package_name varchar2) return boolean;

/*
 * Featue: execute sql
 */
    /** 
    * Execute sql with condition
    * @param pi_is_forced Pass true, and run
    */
    procedure exec(
        pi_sql          varchar2, 
        pi_is_forced    boolean     default false)
    ;
end app_util;
/