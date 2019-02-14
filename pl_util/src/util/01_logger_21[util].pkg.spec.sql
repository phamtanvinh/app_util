create or replace package app_logger_util
/**
* Project:      app_util<br/>
* Description:  This package is used to log application processes.
* @author Vinhpt
* @headcom
*/
as
/*
 *  Global attributes
 */
    /** */
    g_config                pljson;
    g_app_config            app_config;
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
    /** <code>[table]</code><code>[anchor]</code><br/>
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
    */
    procedure insert_running(pi_is_default boolean default true);
    /** <code>[table]</code><code>[anchor]</code><code>[exception]</code><br/>
    * Auto get exception and insert into table.
    */
    procedure insert_exception(pi_app_logger app_logger);
    procedure insert_exception(pi_is_forced boolean default false);
end app_logger_util;
/