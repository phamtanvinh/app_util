create or replace type app_base_object force
as object(
/**
* Project:      app_util <br/>
* Description: This type is base object for all suptype in this project,
* include private attributes, abstract methods and inherit methods.
* @author Vinhpt
* @headcom
*/
    /** Private attribute.*/
    "__name__"          varchar2(64),
    /** Private attribute.*/
    "__config_code__"   varchar2(64),
    /** Private attribute.*/
    "__attributes__"    pljson,
    /** Private attribute.*/
    "__ts__"            timestamp,
-- static
-- constructor
    /** Create new object.*/
    constructor function app_base_object return self as result,
-- initialize
    /** Abstract method. <br/>
    * Used to create constructor
    */
    member procedure initialize(        
        pi_name             varchar2 default null,
        pi_config_code      varchar2 default null
    ),
    /** Inherit method. <br/>
    * Store attributes info into <code>__attributes__</code>
    */
    member procedure get_attributes_info,
    /** Abstract method. <br/>
    * Print (no sort) all global attributes from <code>__attributes__</code>
    */
    member procedure print_attributes_info,
    /** Inherit method. <br/>
    * Print (sorted) all global attributes from <code>__attributes__</code>
    */
    member procedure print_attributes_info(pi_is_sorted boolean),
-- manipulate
    /** Abstract method. <br/>
    * Update all attributes.
    */
    member procedure update_all
) not final;
/