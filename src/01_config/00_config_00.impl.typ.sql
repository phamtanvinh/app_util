create or replace type body app_config
as
-- static
-- constructor
    constructor function app_config return self as result
    is
    begin
        self.initialize();
        return;
    end;

-- initialize
    member procedure set_config(
        pi_config_id        varchar2        default null,
        pi_config_code      varchar2        default null,
        pi_config_user      varchar2        default null,
        pi_config_name      varchar2        default null,
        pi_config_value     pljson          default pljson(),
        pi_config_type      varchar2        default null,
        pi_status           varchar2        default null
    )
    is
    begin
        config_id       := pi_config_id;
        config_code     := pi_config_code;
        config_user     := pi_config_user;
        config_name     := pi_config_name;
        config_value    := pi_config_value;
        config_type     := pi_config_type;
        status          := pi_status;
    end;
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
    is
    begin
        (self as app_base_object).initialize(
            pi_name         => nvl(pi_name, 'app_config'),
            pi_config_code  => 'app_config', 
            pi_description  => pi_description
        );
        self.set_config(
            pi_config_id        => pi_config_id,
            pi_config_code      => pi_config_code,
            pi_config_user      => pi_config_user,
            pi_config_name      => pi_config_name,
            pi_config_value     => pi_config_value,
            pi_config_type      => pi_config_type,
            pi_status           => nvl(pi_status, 'active')
        );
    end;

    member procedure print_config_value
    is
    begin
        app_util.print_string_format(config_value);
    end;

    overriding member procedure get_attributes_info
    is
    begin
        (self as app_base_object).get_attributes_info();
        "__attributes__".put('config_id'    ,config_id);
        "__attributes__".put('config_code'  ,config_code);
        "__attributes__".put('config_user'  ,config_user);
        "__attributes__".put('config_name'  ,config_name);
        "__attributes__".put('config_value' ,config_value.to_char);
        "__attributes__".put('status'       ,status);
    end;
-- manipulate
end;
/

