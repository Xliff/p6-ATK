use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use ATK::Raw::Definitions;
use ATK::Raw::Enums;
use ATK::Raw::Structs;

### /usr/include/atk-1.0/atk/atktext.h

sub atk_text_add_selection (AtkText $text, gint $start_offset, gint $end_offset)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_attribute_set_free (AtkAttributeSet $attrib_set)
  is native(atk)
  is export
{ * }

sub atk_text_attribute_for_name (Str $name)
  returns AtkTextAttribute
  is native(atk)
  is export
{ * }

sub atk_text_attribute_get_name (AtkTextAttribute $attr)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_text_attribute_get_value (AtkTextAttribute $attr, gint $index)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_text_attribute_register (Str $name)
  returns AtkTextAttribute
  is native(atk)
  is export
{ * }

sub atk_text_free_ranges (Pointer $ranges)
  is native(atk)
  is export
{ * }

sub atk_text_get_bounded_ranges (
  AtkText          $text,
  AtkTextRectangle $rect,
  AtkCoordType     $coord_type,
  AtkTextClipType  $x_clip_type,
  AtkTextClipType  $y_clip_type
)
  returns Pointer # AtkTextRange**
  is native(atk)
  is export
{ * }

sub atk_text_get_character_at_offset (AtkText $text, gint $offset)
  returns gunichar
  is native(atk)
  is export
{ * }

sub atk_text_get_character_count (AtkText $text)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_text_get_character_extents (
  AtkText      $text,
  gint         $offset,
  gint         $x,
  gint         $y,
  gint         $width,
  gint         $height,
  AtkCoordType $coords
)
  is native(atk)
  is export
{ * }

sub atk_text_get_default_attributes (AtkText $text)
  returns AtkAttributeSet
  is native(atk)
  is export
{ * }

sub atk_text_get_n_selections (AtkText $text)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_text_get_offset_at_point (
  AtkText      $text,
  gint         $x,
  gint         $y,
  AtkCoordType $coords
)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_text_get_range_extents (
  AtkText          $text,
  gint             $start_offset,
  gint             $end_offset,
  AtkCoordType     $coord_type,
  AtkTextRectangle $rect
)
  is native(atk)
  is export
{ * }

sub atk_text_get_run_attributes (
  AtkText $text,
  gint $offset,
  gint $start_offset,
  gint $end_offset
)
  returns AtkAttributeSet
  is native(atk)
  is export
{ * }

sub atk_text_get_selection (
  AtkText $text,
  gint    $selection_num,
  gint    $start_offset,
  gint    $end_offset
)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_text_get_string_at_offset (
  AtkText            $text,
  gint               $offset,
  AtkTextGranularity $granularity,
  gint               $start_offset,
  gint               $end_offset
)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_text_get_text (AtkText $text, gint $start_offset, gint $end_offset)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_text_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_text_range_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_text_remove_selection (AtkText $text, gint $selection_num)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_text_scroll_substring_to (
  AtkText       $text,
  gint          $start_offset,
  gint          $end_offset,
  AtkScrollType $type
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_text_scroll_substring_to_point (
  AtkText      $text,
  gint         $start_offset,
  gint         $end_offset,
  AtkCoordType $coords,
  gint         $x,
  gint         $y
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_text_set_selection (
  AtkText $text,
  gint    $selection_num,
  gint    $start_offset,
  gint    $end_offset
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_text_get_caret_offset (AtkText $text)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_text_set_caret_offset (AtkText $text, guint $offset)
  returns uint32
  is native(atk)
  is export
{ * }
