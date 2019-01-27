create or replace type body app_logger
as
-- static
-- constructor
    constructor function app_logger return self as result
    is
    begin
        initialize();
        return;
    end;
    constructor function app_logger(
        pi_transaction_code     varchar2,
        pi_app_user             varchar2,
        pi_unit_name            varchar2,
        pi_unit_type            varchar2
    ) return self as result
    is
    begin
        initialize(
            pi_transaction_code     => pi_transaction_code,
            pi_app_user             => pi_app_user,
            pi_unit_name            => pi_unit_name,
            pi_unit_type            => pi_unit_type,
            pi_log_step_name        => '000',
            pi_log_step_description => 'initialize logger'
        );
        return;
    end;
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
    )
    is
    begin
        (self as app_extend).initialize(
            pi_name             => nvl(pi_name          ,'app_logger'),
            pi_config_code      => nvl(pi_config_code   ,'app_logger'),
            pi_description      => pi_description,
            pi_mode             => pi_mode);
        app_user        := pi_app_user;
        set_transaction(pi_transaction_code     => pi_transaction_code);
        set_log_step(
            pi_log_step_name            => pi_log_step_name,
            pi_log_step_description     => pi_log_step_description
        );
        set_process_unit(
            pi_unit_name        => pi_unit_name,
            pi_unit_type        => pi_unit_type
        );
    end;

    member procedure set_transaction(pi_transaction_code     varchar2    default null)
    is
    begin
        transaction_id      := app_util.get_transaction_id();
        transaction_code    := pi_transaction_code;
    end;

    member procedure set_process_unit(
        pi_unit_name            varchar2    default null,
        pi_unit_type            varchar2    default null
    )
    is
    begin
        unit_name   := pi_unit_name;
        unit_type   := pi_unit_type;
    end;

    member procedure set_log_step(
        pi_log_step_name        varchar2    default null,
        pi_log_step_description varchar2    default null
    )
    is
    begin
        log_step_id             := nvl(log_step_id, 0) + 1;
        log_step_name           := pi_log_step_name;
        log_step_description    := pi_log_step_description;
    end;

    overriding member procedure get_attributes_info
    is
    begin
        (self as app_extend).get_attributes_info();
        "__attributes__".put('transaction_id'           ,transaction_id);
        "__attributes__".put('transaction_code'         ,transaction_code);
        "__attributes__".put('app_user'                 ,app_user);
        "__attributes__".put('unit_name'                ,unit_name);
        "__attributes__".put('unit_type'                ,unit_type);
        "__attributes__".put('log_step_id'              ,log_step_id);
        "__attributes__".put('log_step_name'            ,log_step_name);
        "__attributes__".put('log_step_description'     ,log_step_description);
        "__attributes__".put('error_sqlcode'            ,error_sqlcode);
        "__attributes__".put('error_sqlerrm'            ,error_sqlerrm);
        "__attributes__".put('error_backtrace'          ,error_backtrace);
    end;
-- manipulate
    member procedure update_step(
        pi_log_step_name        varchar2    default null,
        pi_log_step_description varchar2    default null
    )
    is
    begin
        update_all();
        set_log_step(
            pi_log_step_name            => pi_log_step_name,
            pi_log_step_description     => pi_log_step_description
        );
    end;
    member procedure initialize_exception
    is
    begin
        error_sqlcode       := sqlcode;
        error_sqlerrm       := sqlerrm(sqlcode);
        error_backtrace     := dbms_utility.format_error_backtrace;
    end;
    overriding member procedure update_all
    is
    begin
        (self as app_extend).update_all();
    end;
end;
/