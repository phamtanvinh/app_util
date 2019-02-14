create or replace type body app_base_object
as
/*
 *  Constructors
 */
    constructor function app_base_object return self as result
    is
    begin
        self.initialize();
        update_all();
        return;
    end;

/*
 *  Global methods
 */
    member procedure get_attributes_info
    is
    begin
        "__attributes__" := new pljson();
        "__attributes__".put('__name__'         ,"__name__");
        "__attributes__".put('__config_code__'  ,"__config_code__");
        "__attributes__".put('__ts__'           ,"__ts__");
    end;

    member procedure initialize(
        pi_name             varchar2,
        pi_config_code      varchar2
    )
    is
    begin
        "__name__"          := pi_name;
        "__config_code__"   := pi_config_code;
        "__ts__"            := current_timestamp;
    end;

    member procedure initialize
    is
    begin
        initialize(
            pi_name             => 'app_base_object',
            pi_config_code      => 'app_base_object'            
        );
    end;

    member procedure print(pi_is_sorted boolean default false)
    is
        l_dictionary    app_util.dictionary;
    begin
        get_attributes_info();
        if pi_is_sorted then
            l_dictionary := app_util.get_dictionary("__attributes__");
            app_util.print(l_dictionary);
        else
            app_util.print("__attributes__");
        end if;
    end;

    member procedure update_all
    is
    begin
        null;
    end;
end;
/