create or replace type app_base_object force
as object(
/* **********************************************************************************
** app_base_object
** **********************************************************************************
**  description: this is abstractive object for custom type to inheriate
** **********************************************************************************/
-- attributes
    "__name__"          varchar2(64),
    "__config_code__"   varchar2(64),
    "__attributes__"    pljson,
    "__ts__"            timestamp,
    description         varchar2(1024),
    created_date        date,
    updated_date        date,
-- static
-- constructor
    constructor function app_base_object return self as result,
-- initialize
    member procedure initialize(        
        pi_name             varchar2 default null,
        pi_config_code      varchar2 default null,
        pi_description      varchar2 default null
    ),
    member procedure get_attributes_info,
    member procedure print_attributes_info,
    member procedure print_attributes_info(pi_is_sorted boolean),
-- manipulate
    member procedure update_all
) not final;
/