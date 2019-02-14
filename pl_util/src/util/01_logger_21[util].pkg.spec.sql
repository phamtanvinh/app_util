create or replace package app_logger_util
/**
* Project:      app_util<br/>
* Description:  This package is used to log application processes.
* <p>Features:</p>
* <code>
* 1. Tracking process running <br/>
* 2. Catching exception <br/>
* 3. Create all logger tables <br/>
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
    g_app_config            app_config;
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
    /** */
    procedure set_logger(pi_app_logger app_logger);

    /** <code>[table]</code><br/>
    * Create all tables for logging, for running process and tracking exception.
    * @param pi_is_forced Pass true, drop and create table any way
    */
    procedure initialize(pi_is_forced boolean default false);
    /** <code>[table][anchor]</code><br/>
    */
    procedure insert_running(pi_app_logger app_logger);
    /** <code>[table]</code><br/>
    * Update step and insert into table. <br/>
    * Example:
    * <pre>
    * begin
    *   app_logger_util.insert_running('test name', 'test description');
    * end;
    * </pre>
    * @param pi_log_step_name Step name
    * @param pi_log_step_description Description for this step
    */
    procedure insert_running(
        pi_log_step_name        varchar2,
        pi_log_step_description varchar2
    );
    /** <code>[table]</code><br/>
    * @param pi_is_default If true insert last step,
    * otherwise insert unidentified step.
    */
    procedure insert_running(pi_is_default boolean default true);
    /** <code>[table][anchor][exception]</code><br/>
    * Auto get exception and insert into table.
    */
    procedure insert_exception(pi_app_logger app_logger);
    /** <code>[table][anchor][exception]</code><br/>
    * Auto get exception and insert into table.
    * @param pi_is_forced If true insert last step,
    * otherwise preview exception.
    */
    procedure insert_exception(pi_is_forced boolean default false);
end app_logger_util;
/