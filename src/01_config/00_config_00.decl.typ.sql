create or replace type app_config force
under app_base_object(
/* **********************************************************************************
 * app_config
 * **********************************************************************************
 *  description: 
 * **********************************************************************************/
    config_id       number,
    config_code     varchar2(64),
    config_user     varchar2(64),
    config_name     varchar2(64),
    config_value    pljson       ,
    config_type     varchar2(64),
    status          varchar2(16),
-- static
-- constructor
    constructor function app_config return self as result,
-- initialize
    member procedure set_config(
        pi_config_id        varchar2        default null,
        pi_config_code      varchar2        default null,
        pi_config_user      varchar2        default null,
        pi_config_name      varchar2        default null,
        pi_config_value     pljson          default pljson(),
        pi_config_type      varchar2        default null,
        pi_status           varchar2        default null


    ),
    member procedure print_config_value,
    overriding member procedure get_attributes_info,
    member procedure initialize(        
        pi_name             varchar2        default null,
        pi_description      varchar2        default null,
        pi_config_id        varchar2        default null,
        pi_config_code      varchar2        default null,
        pi_config_user      varchar2        default null,
        pi_config_name      varchar2        default null,
        pi_config_value     pljson          default pljson(),
        pi_config_type      varchar2        default null,
        pi_status           varchar2        default null
    )
-- manipulate
) not final;
/
