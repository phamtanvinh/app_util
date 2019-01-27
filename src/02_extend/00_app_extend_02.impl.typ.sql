create or replace type body app_extend
as
-- static
-- constructor
    constructor function app_extend return self as result
    is
    begin
        initialize();
        return;
    end;
-- initialize
    member procedure initialize(
        pi_name             varchar2    default null,
        pi_config_code      varchar2    default null,
        pi_description      varchar2    default null,
        pi_config           varchar2    default null,
        pi_mode             varchar2    default null
    )
    is
    begin
        (self as app_base_object).initialize(
            pi_name         => nvl(pi_name          ,'app_extend'),
            pi_config_code  => nvl(pi_config_code   ,'app_extend'),
            pi_description  => pi_description);
        -- apply custom config
        set_private_attributes(
            pi_mode         => pi_mode,
            pi_config       => pi_config
        );
        get_created_datetime_dim();
        get_updated_datetime_dim();
        get_duration();
    end;

    member procedure set_private_attributes(
        pi_config           varchar2    default null,
        pi_mode             varchar2    default null
    )
    is
    begin
        if pi_config is not null then
            "__config__"    := new pljson(pi_config);     
        else
            "__config__"    := nvl("__app_config__".config_value, new pljson());
        end if;
        
        if pi_mode is not null then
            "__mode__"      := pi_mode;
        elsif "__config__".get('__mode__') is not null then
            "__mode__"      := "__config__".get('__mode__').get_string();
        end if;
    end;

    member procedure get_datetime_dim(
        pio_ts              in out timestamp,
        pio_dnum            in out number,
        pio_tnum            in out number,
        pio_unix_ts         in out number,
        pio_date            in out date
    )
    is
    begin
        pio_ts          := current_timestamp;
        pio_dnum        := app_util.get_dnum(pio_ts);
        pio_tnum        := app_util.get_tnum(pio_ts);
        pio_unix_ts     := app_util.get_unix_ts(pio_ts);
        pio_date        := cast(pio_ts as date);

    end;

    overriding member procedure get_attributes_info
    is
    begin
        (self as app_base_object).get_attributes_info();
        "__attributes__".put('__mode__'         ,"__mode__");
        "__attributes__".put('__config__'       ,"__config__".to_char(false));
        "__attributes__".put('created_ts'       ,created_ts);
        "__attributes__".put('created_dnum'     ,created_dnum);
        "__attributes__".put('created_tnum'     ,created_tnum);
        "__attributes__".put('created_unix_ts'  ,created_unix_ts);        
        "__attributes__".put('updated_ts'       ,updated_ts);
        "__attributes__".put('updated_dnum'     ,updated_dnum);
        "__attributes__".put('updated_tnum'     ,updated_tnum);
        "__attributes__".put('updated_unix_ts'  ,updated_unix_ts);
        "__attributes__".put('duration'         ,duration);
    end;
-- manipulate
    member procedure get_created_datetime_dim
    is
    begin
        get_datetime_dim(
            pio_ts          => created_ts,
            pio_dnum        => created_dnum,
            pio_tnum        => created_tnum,
            pio_unix_ts     => created_unix_ts,
            pio_date        => created_date
        );
    end;

    member procedure get_updated_datetime_dim
    is
    begin
        get_datetime_dim(
            pio_ts          => updated_ts,
            pio_dnum        => updated_dnum,
            pio_tnum        => updated_tnum,
            pio_unix_ts     => updated_unix_ts,
            pio_date        => updated_date
        );
    end;

    member procedure get_duration
    is
    begin
        duration    := app_util.get_unix_ts() - updated_unix_ts;
    end;

    overriding member procedure update_all
    is
    begin
        (self as app_base_object).update_all();
        get_duration();
        get_updated_datetime_dim();
    end;
end;
/