use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use ATK::Raw::Definitions;
use ATK::Raw::Enums;
use ATK::Raw::Structs;

unit package ATK::Raw::Value;

### /usr/include/atk-1.0/atk/atkvalue.h

sub atk_value_get_current_value (AtkValue $obj, GValue $value)
  is native(atk)
  is export
{ * }

sub atk_value_get_increment (AtkValue $obj)
  returns gdouble
  is native(atk)
  is export
{ * }

sub atk_value_get_maximum_value (AtkValue $obj, GValue $value)
  is native(atk)
  is export
{ * }

sub atk_value_get_minimum_increment (AtkValue $obj, GValue $value)
  is native(atk)
  is export
{ * }

sub atk_value_get_minimum_value (AtkValue $obj, GValue $value)
  is native(atk)
  is export
{ * }

sub atk_value_get_range (AtkValue $obj)
  returns AtkRange
  is native(atk)
  is export
{ * }

sub atk_value_get_sub_ranges (AtkValue $obj)
  returns GSList
  is native(atk)
  is export
{ * }

sub atk_value_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_value_get_value_and_text (
  AtkValue $obj,
  gdouble  $value is rw,
  Str      $text
)
  is native(atk)
  is export
{ * }

sub atk_value_set_current_value (AtkValue $obj, GValue $value)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_value_set_value (AtkValue $obj, gdouble $new_value)
  is native(atk)
  is export
{ * }

sub atk_value_type_get_localized_name (AtkValueType $value_type)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_value_type_get_name (AtkValueType $value_type)
  returns Str
  is native(atk)
  is export
{ * }
