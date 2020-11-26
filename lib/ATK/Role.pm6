use v6.c;

use ATK::Raw::Types;
use ATK::Raw::Object;

use GLib::Roles::StaticClass;

class ATK::Role {
  also does GLib::Roles::StaticClass;

  method for_name (Str() $name) {
    AtkRoleEnum( atk_role_for_name($name) );
  }

  method get_localized_name (Int() $role) {
    my AtkRole $r = $role;

    atk_role_get_localized_name($r);
  }

  method get_name (Int() $role) {
    my AtkRole $r = $role;

    atk_role_get_name($r);
  }

  method register (Str() $name) is DEPRECATED {
    atk_role_register($name);
  }
}
