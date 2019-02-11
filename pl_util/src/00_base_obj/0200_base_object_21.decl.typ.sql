create or replace type app_base_object force
/**
* Project:      app_util<br/>
* Description:  App tool for data management.
* @author Vinhpt
* @headcom
*/
as object(
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
    /** */
    constructor function app_base_object return self as result,
-- initialize
    /** */
    member procedure initialize(        
        pi_name             varchar2 default null,
        pi_config_code      varchar2 default null
    ),
    member procedure get_attributes_info,
    member procedure print_attributes_info,
    member procedure print_attributes_info(pi_is_sorted boolean),
-- manipulate
    /**
    * This method will be orverried to update all attributes.
    */
    member procedure update_all
) not final;
/