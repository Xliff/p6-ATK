use v6.c;

use GLib::Raw::Definitions;
use ATK::Raw::Definitions;
use ATK::Raw::Structs;

unit package ATK::Raw::Selection;

### /usr/include/atk-1.0/atk/atkselection.h

sub atk_selection_add_selection (AtkSelection $selection, gint $i)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_selection_clear_selection (AtkSelection $selection)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_selection_get_selection_count (AtkSelection $selection)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_selection_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_selection_is_child_selected (AtkSelection $selection, gint $i)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_selection_ref_selection (AtkSelection $selection, gint $i)
  returns AtkObject
  is native(atk)
  is export
{ * }

sub atk_selection_remove_selection (AtkSelection $selection, gint $i)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_selection_select_all_selection (AtkSelection $selection)
  returns uint32
  is native(atk)
  is export
{ * }
