create or replace package app_meta_data
/**
* Project:      app_util<br/>
* Description:  This package is used to config global config as default,
* which is able to be overrided by custom package.
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
    /** <code>[config]</code><br/> */
    g_prefix                pljson;
    /** <code>[config]</code><br/> */
    g_suffix                pljson;
/*
 *  Global methods
 */
    /** <code>[undefined]</code><br/>
    * Generate object string from global config by default.
    * @param pi_object_name Pass object name
    * @param pi_prefix Pass prefix, default g_prefix
    * @param pi_suffix Pass suffix, default g_suffix
    * @return varchar2
    */
    function get_object_name(
        pi_object_name      varchar2,
        pi_prefix           varchar2 default null,
        pi_suffix           varchar2 default null
    ) return varchar2;
    /** <code>[undefined]</code><br/>
    * Generate table name from global config.
    * @return varchar2
    */
    function get_table_name(
        pi_table_name       varchar2,
        pi_prefix           varchar2 default null,
        pi_suffix           varchar2 default null
    ) return varchar2;
end app_meta_data;
/