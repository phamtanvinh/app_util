create or replace type app_base_object force
as object(
/**
* Project:      app_util <br/>
* Description: This type is base object for all suptype in this project,
* include private attributes, abstract methods and inherit methods.
* @author Vinhpt
* @headcom
*/
/*
 *  Internal attributes
 */
    /** <code>[internal]</code><br/> */
    "__name__"          varchar2(64),
    /** <code>[internal]</code><br/> */
    "__config_code__"   varchar2(64),
    /** <code>[internal]</code><br/> */
    "__attributes__"    pljson,
    /** <code>[internal]</code><br/> */
    "__ts__"            timestamp,
/*
 *  Constructors
 */
    /** <code>[constructor]</code><br/> */
    constructor function app_base_object return self as result,
/*
 *  Global methods
 */
    /** <code>[abstract][anchor]</code><br/>
    * Used to create constructor.
    */
    member procedure initialize(
        pi_name             varchar2,
        pi_config_code      varchar2
    ),
    /** <code>[abstract]</code><br/>
    * Used to create constructor.
    */
    member procedure initialize,
    /** <code>[abstract]</code><br/>
    * Store attributes info into <code>__attributes__</code>
    */
    member procedure get_attributes_info,
    /** <code>[inherit]</code><br/>
    * Print (sorted) all global attributes from <code>__attributes__</code>
    */
    member procedure print(pi_is_sorted boolean default false),
    /** <code>[abstract]</code><br/>
    * Update all attributes.
    */
    member procedure update_all
) not final;
/