/* **********************************************************************************
*   type_template
** *********************************************************************************/

create or replace type type_template force
as object(
    __name__        varchar2(64),
-- static
-- constructor
-- initialize
-- manipulate
);
/

create or replace type body type_template
as
-- static
-- constructor
-- initialize
-- manipulate
end;
/

/* **********************************************************************************
*   type_template
** *********************************************************************************/

create or replace type type_template force
under app_base_object(
-- static
-- constructor
-- initialize
    member procedure initialize,
    overriding member procedure get_attributes_info,
-- manipulate
    overriding member procedure update_all
);
/

create or replace type body type_template
as
-- static
-- constructor
-- initialize
-- manipulate
end;
/

