create or replace type app_extend force
under app_base_object(
/* **********************************************************************************
 * app_extend
 * **********************************************************************************
 *  description: this is extend object of base object for some config and auto update
 *      date time methods
 * **********************************************************************************/
-- private attributes
    "__app_config__"    app_config,
    "__config__"        pljson,
    "__mode__"          varchar2(64),
-- globall attributes
    created_ts          timestamp,
    created_dnum        number,
    created_tnum        number,
    created_unix_ts     number,
    updated_ts          timestamp,
    updated_dnum        number,
    updated_tnum        number,
    updated_unix_ts     number,
    duration            number,
-- static
-- constructor
    constructor function app_extend return self as result,
-- initialize
    member procedure initialize(
        pi_name             varchar2    default null,
        pi_config_code      varchar2    default null,
        pi_description      varchar2    default null,
        pi_config           varchar2    default null,
        pi_mode             varchar2    default null
    ),
    member procedure set_private_attributes(
        pi_config           varchar2    default null,
        pi_mode             varchar2    default null
    ),
    member procedure get_datetime_dim(
        pio_ts              in out timestamp,
        pio_dnum            in out number,
        pio_tnum            in out number,
        pio_unix_ts         in out number,
        pio_date            in out date
    ),
    overriding member procedure get_attributes_info,
-- manipulate
    member procedure get_created_datetime_dim,
    member procedure get_updated_datetime_dim,    
    member procedure get_duration,
    overriding member procedure update_all
) not final;
/
