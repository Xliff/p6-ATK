use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use ATK::Raw::Definitions;
use ATK::Raw::Enums;
use ATK::Raw::Structs;

unit package ATK::Raw::StateSet;

### /usr/include/atk-1.0/atk/atkstateset.h

sub atk_state_set_add_state (AtkStateSet $set, AtkStateType $type)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_state_set_add_states (
  AtkStateSet  $set,
  AtkStateType $types,
  gint         $n_types
)
  is native(atk)
  is export
{ * }

sub atk_state_set_and_sets (AtkStateSet $set, AtkStateSet $compare_set)
  returns AtkStateSet
  is native(atk)
  is export
{ * }

sub atk_state_set_clear_states (AtkStateSet $set)
  is native(atk)
  is export
{ * }

sub atk_state_set_contains_state (AtkStateSet $set, AtkStateType $type)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_state_set_contains_states (
  AtkStateSet  $set,
  AtkStateType $types,
  gint         $n_types
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_state_set_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_state_set_is_empty (AtkStateSet $set)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_state_set_new ()
  returns AtkStateSet
  is native(atk)
  is export
{ * }

sub atk_state_set_or_sets (AtkStateSet $set, AtkStateSet $compare_set)
  returns AtkStateSet
  is native(atk)
  is export
{ * }

sub atk_state_set_remove_state (AtkStateSet $set, AtkStateType $type)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_state_set_xor_sets (AtkStateSet $set, AtkStateSet $compare_set)
  returns AtkStateSet
  is native(atk)
  is export
{ * }
