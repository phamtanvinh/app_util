create or replace type app_logger force
under app_extend(
/* **********************************************************************************
 * app_logger
 * **********************************************************************************
 *  description: 
 * **********************************************************************************/
    transaction_id          varchar2(64),
    transaction_code        varchar2(64),
    app_user                varchar2(64),
    unit_name               varchar2(64),
    unit_type               varchar2(64),
    log_step_id             number,
    log_step_name           varchar2(64),
    log_step_description    varchar2(1024),
    error_sqlcode           varchar2(64),
    error_sqlerrm           varchar2(4000),
    error_backtrace         varchar2(4000),
-- static
-- constructor
    constructor function app_logger return self as result,
    constructor function app_logger(
        pi_transaction_code     varchar2,
        pi_app_user             varchar2,
        pi_unit_name            varchar2,
        pi_unit_type            varchar2
    ) return self as result,
-- initialize
    member procedure initialize(
        pi_name                 varchar2    default null,
        pi_config_code          varchar2    default null,
        pi_description          varchar2    default null,
        pi_mode                 varchar2    default null,
        pi_transaction_code     varchar2    default null,
        pi_app_user             varchar2    default null,
        pi_unit_name            varchar2    default null,
        pi_unit_type            varchar2    default null,
        pi_log_step_name        varchar2    default null,
        pi_log_step_description varchar2    default null
    ),
    member procedure set_transaction(pi_transaction_code     varchar2    default null),
    member procedure set_process_unit(
        pi_unit_name            varchar2    default null,
        pi_unit_type            varchar2    default null
    ),
    member procedure set_log_step(
        pi_log_step_name        varchar2    default null,
        pi_log_step_description varchar2    default null
    ),
    overriding member procedure get_attributes_info,
-- manipulate
    member procedure update_step(
        pi_log_step_name        varchar2    default null,
        pi_log_step_description varchar2    default null
    ),
    member procedure initialize_exception,
    overriding member procedure update_all
) not final;
/
