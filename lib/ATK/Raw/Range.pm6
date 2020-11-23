use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use ATK::Raw::Definitions;
use ATK::Raw::Structs;

unit package ATK::Raw::Range;

### /usr/include/atk-1.0/atk/atkrange.h

sub atk_range_copy (AtkRange $src)
  returns AtkRange
  is native(atk)
  is export
{ * }

sub atk_range_free (AtkRange $range)
  is native(atk)
  is export
{ * }

sub atk_range_get_description (AtkRange $range)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_range_get_lower_limit (AtkRange $range)
  returns gdouble
  is native(atk)
  is export
{ * }

sub atk_range_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_range_get_upper_limit (AtkRange $range)
  returns gdouble
  is native(atk)
  is export
{ * }

sub atk_range_new (
  gdouble $lower_limit,
  gdouble $upper_limit,
  Str     $description
)
  returns AtkRange
  is native(atk)
  is export
{ * }
