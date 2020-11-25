use v6.c;

use Method::Also;

use NativeCall;

use ATK::Raw::Types;

use GLib::Roles::StaticClass;

class ATK::State {
  also does GLib::Roles::StaticClass;

  method for_name (Str() $name, :$enum = True) is also<for-name> {
    my $st = atk_state_type_for_name($name);
    if $enum {
      return AtkStateTypeEnum($st)
        if AtkStateTypeEnum.enums.values.any == $st;
    }
    $st;
  }

  method get_name (Int() $type) is also<get-name> {
    atk_state_type_get_name($type);
  }

  # cw: Return type will be a new value associated with $name, so not in
  #     AtkStateTypeEnum!
  method register (Str() $name) {
    atk_state_type_register($name);
  }
}

### /usr/include/atk-1.0/atk/atkstate.h

sub atk_state_type_for_name (Str $name)
  returns AtkStateType
  is native(atk)
  is export
{ * }

sub atk_state_type_get_name (AtkStateType $type)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_state_type_register (Str $name)
  returns AtkStateType
  is native(atk)
  is export
{ * }
