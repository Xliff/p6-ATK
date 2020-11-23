use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use ATK::Raw::Definitions;
use ATK::Raw::Structs;

unit package ATK::Raw::Action;

### /usr/include/atk-1.0/atk/atkaction.h

sub atk_action_do_action (AtkAction $action, gint $i)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_action_get_description (AtkAction $action, gint $i)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_action_get_keybinding (AtkAction $action, gint $i)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_action_get_localized_name (AtkAction $action, gint $i)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_action_get_n_actions (AtkAction $action)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_action_get_name (AtkAction $action, gint $i)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_action_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_action_set_description (AtkAction $action, gint $i, Str $desc)
  returns uint32
  is native(atk)
  is export
{ * }
