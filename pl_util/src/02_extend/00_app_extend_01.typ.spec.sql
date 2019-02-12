create or replace type app_extend force
under app_base_object(
/**
* Project:      app_util<br/>
* Description:  App tool for data management.
* @author Vinhpt
* @headcom
*/
-- private attributes
    /** Private attribute.*/
    "__app_config__"    app_config,
    /** Private attribute.*/
    "__config__"        pljson,
    /** Private attribute.*/
    "__mode__"          varchar2(64),
-- globall attributes
    /** */
    created_ts          timestamp,
    created_dnum        number,
    created_tnum        number,
    created_unix_ts     number,
    updated_ts          timestamp,
    updated_dnum        number,
    updated_tnum        number,
    updated_unix_ts     number,
    duration            number,
    created_date        date,
    updated_date        date,
-- static
-- constructor
    /** */
    constructor function app_extend return self as result,
-- initialize
    /** */
    member procedure initialize(
        pi_name             varchar2    default null,
        pi_config_code      varchar2    default null,
        pi_config           varchar2    default null,
        pi_mode             varchar2    default null
    ),
    /** */
    member procedure set_private_attributes(
        pi_config           varchar2    default null,
        pi_mode             varchar2    default null
    ),
    /** */
    member procedure get_datetime_dim(
        pio_ts              in out timestamp,
        pio_dnum            in out number,
        pio_tnum            in out number,
        pio_unix_ts         in out number,
        pio_date            in out date
    ),
    /** Implemented method.
    */
    overriding member procedure get_attributes_info,
-- manipulate
    /** */
    member procedure get_created_datetime_dim,
    member procedure get_updated_datetime_dim,    
    member procedure get_duration,
    overriding member procedure update_all
) not final;
/
