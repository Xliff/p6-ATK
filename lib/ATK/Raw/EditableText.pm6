use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use ATK::Raw::Definitions;

### /usr/include/atk-1.0/atk/atkeditabletext.h

sub atk_editable_text_copy_text (
  AtkEditableText $text,
  gint            $start_pos,
  gint            $end_pos
)
  is native(atk)
  is export
{ * }

sub atk_editable_text_cut_text (
  AtkEditableText $text,
  gint            $start_pos,
  gint            $end_pos
)
  is native(atk)
  is export
{ * }

sub atk_editable_text_delete_text (
  AtkEditableText $text,
  gint            $start_pos,
  gint            $end_pos
)
  is native(atk)
  is export
{ * }

sub atk_editable_text_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_editable_text_insert_text (
  AtkEditableText $text,
  Str             $string,
  gint            $length,
  gint            $position
)
  is native(atk)
  is export
{ * }

sub atk_editable_text_paste_text (AtkEditableText $text, gint $position)
  is native(atk)
  is export
{ * }

sub atk_editable_text_set_run_attributes (
  AtkEditableText $text,
  AtkAttributeSet $attrib_set,
  gint            $start_offset,
  gint            $end_offset
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_editable_text_set_text_contents (AtkEditableText $text, Str $string)
  is native(atk)
  is export
{ * }
