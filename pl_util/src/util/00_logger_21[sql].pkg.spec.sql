create or replace package app_logger_sql
/**
* Project:      app_util<br/>
* Description:  Generate sql to work with logger tables.
* <p>Features:</p>
* <code>
* 1. SQL to reate logger tables <br/>
* 2. SQL to insert into logger tables <br/>
* </code>
* @author Vinhpt
* @headcom
*/
as
/*
 *  Global attributes
 */
    /** <code>[config]</code><br/> 
    * Config setting for this package.
    */
    g_config                pljson;
    /** <code>[logger]</code><br/>
    * Update and manipulate logger.
    */
    g_app_logger            app_logger;

/*
 *  Internal methods
 */
    /** <code>[internal]</code><br/> */
    procedure get_config;
    /** <code>[internal]</code><br/> */
    procedure set_attributes;

/*
 *  Global methods
 */
    /** <code>[sql]</code><br/>
    * Generate sql to create table logger running.
    */
    function get_create_running return varchar2;
    /** <code>[sql]</code><br/>
    * Generate sql to create table logger exception.
    */
    function get_create_exception return varchar2;
    /** <code>[sql]</code><br/>
    * Generate sql to insert logger running.
    */
    function get_insert_running return varchar2;
    /** <code>[sql]</code><br/>
    * Generate sql to insert logger exception.
    */
    function get_insert_exception return varchar2;
end app_logger_sql;
/
