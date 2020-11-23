use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use ATK::Raw::Definitions;
use ATK::Raw::Enums;
use ATK::Raw::Structs;

unit package ATK::Raw::Object;

### /usr/include/atk-1.0/atk/atkobject.h

sub atk_object_add_relationship (
  AtkObject       $object,
  AtkRelationType $relationship,
  AtkObject       $target
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_object_connect_property_change_handler (
  AtkObject $accessible,
            &handler #= AtkPropertyChangeHandler
)
  returns guint
  is native(atk)
  is export
{ * }

sub atk_object_get_accessible_id (AtkObject $accessible)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_object_get_attributes (AtkObject $accessible)
  returns AtkAttributeSet
  is native(atk)
  is export
{ * }

sub atk_object_get_description (AtkObject $accessible)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_object_get_index_in_parent (AtkObject $accessible)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_object_get_layer (AtkObject $accessible)
  returns AtkLayer
  is native(atk)
  is export
{ * }

sub atk_object_get_mdi_zorder (AtkObject $accessible)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_object_get_n_accessible_children (AtkObject $accessible)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_object_get_name (AtkObject $accessible)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_object_get_object_locale (AtkObject $accessible)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_object_get_parent (AtkObject $accessible)
  returns AtkObject
  is native(atk)
  is export
{ * }

sub atk_object_get_role (AtkObject $accessible)
  returns AtkRole
  is native(atk)
  is export
{ * }

sub atk_object_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_object_initialize (AtkObject $accessible, gpointer $data)
  is native(atk)
  is export
{ * }

sub atk_object_notify_state_change (
  AtkObject $accessible,
  AtkState  $state,
  gboolean  $value
)
  is native(atk)
  is export
{ * }

sub atk_object_peek_parent (AtkObject $accessible)
  returns AtkObject
  is native(atk)
  is export
{ * }

sub atk_object_ref_accessible_child (AtkObject $accessible, gint $i)
  returns AtkObject
  is native(atk)
  is export
{ * }

sub atk_object_ref_relation_set (AtkObject $accessible)
  returns AtkRelationSet
  is native(atk)
  is export
{ * }

sub atk_object_ref_state_set (AtkObject $accessible)
  returns AtkStateSet
  is native(atk)
  is export
{ * }

sub atk_object_remove_property_change_handler (
  AtkObject $accessible,
  guint $handler_id
)
  is native(atk)
  is export
{ * }

sub atk_object_remove_relationship (
  AtkObject       $object,
  AtkRelationType $relationship,
  AtkObject       $target
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_object_set_accessible_id (AtkObject $accessible, Str $name)
  is native(atk)
  is export
{ * }

sub atk_object_set_description (AtkObject $accessible, Str $description)
  is native(atk)
  is export
{ * }

sub atk_object_set_name (AtkObject $accessible, Str $name)
  is native(atk)
  is export
{ * }

sub atk_object_set_parent (AtkObject $accessible, AtkObject $parent)
  is native(atk)
  is export
{ * }

sub atk_object_set_role (AtkObject $accessible, AtkRole $role)
  is native(atk)
  is export
{ * }

sub atk_role_for_name (Str $name)
  returns AtkRole
  is native(atk)
  is export
{ * }

sub atk_role_get_localized_name (AtkRole $role)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_role_get_name (AtkRole $role)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_role_register (Str $name)
  returns AtkRole
  is native(atk)
  is export
{ * }
