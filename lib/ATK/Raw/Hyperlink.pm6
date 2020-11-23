use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use ATK::Raw::Definitions;
use ATK::Raw::Structs;

unit package ATK::Raw::Hyperlink;

### /usr/include/atk-1.0/atk/atkhyperlink.h

sub atk_hyperlink_get_end_index (AtkHyperlink $link)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_hyperlink_get_n_anchors (AtkHyperlink $link)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_hyperlink_get_object (AtkHyperlink $link, gint $i)
  returns AtkObject
  is native(atk)
  is export
{ * }

sub atk_hyperlink_get_start_index (AtkHyperlink $link)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_hyperlink_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_hyperlink_get_uri (AtkHyperlink $link, gint $i)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_hyperlink_is_inline (AtkHyperlink $link)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_hyperlink_is_selected_link (AtkHyperlink $link)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_hyperlink_is_valid (AtkHyperlink $link)
  returns uint32
  is native(atk)
  is export
{ * }
