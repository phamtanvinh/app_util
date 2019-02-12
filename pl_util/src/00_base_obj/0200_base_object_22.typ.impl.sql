create or replace type body app_base_object
as
-- static
-- constructor
    constructor function app_base_object return self as result
    is
    begin
        self.initialize();
        update_all();
        return;
    end;
-- initialize
    member procedure get_attributes_info
    is
    begin
        "__attributes__" := new pljson();
        "__attributes__".put('__name__'         ,"__name__");
        "__attributes__".put('__config_code__'  ,"__config_code__");
        "__attributes__".put('__ts__'           ,"__ts__");
    end;

    member procedure initialize(
        pi_name             varchar2 default null,
        pi_config_code      varchar2 default null
    )
    is
    begin
        "__name__"          := nvl(pi_name          ,'app_base_object');
        "__config_code__"   := nvl(pi_config_code   ,'app_base_object');
        "__ts__"            := current_timestamp;
    end;

    member procedure print_attributes_info
    is
    begin
        get_attributes_info();
        app_util.print_string_format("__attributes__");
    end;

    member procedure print_attributes_info(pi_is_sorted boolean)
    is
        l_dictionary    app_util.dictionary;
    begin
        get_attributes_info();
        l_dictionary := app_util.get_dictionary("__attributes__");
        app_util.print_string_format(l_dictionary);
    end;

-- manipulate

    member procedure update_all
    is
    begin
        null;
    end;
end;
/