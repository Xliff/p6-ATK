use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use ATK::Raw::Definitions;
use ATK::Raw::Enums;
use ATK::Raw::Structs;

unit package ATK::Raw::Relation;

### /usr/include/atk-1.0/atk/atkrelation.h

sub atk_relation_add_target (AtkRelation $relation, AtkObject $target)
  is native(atk)
  is export
{ * }

sub atk_relation_get_relation_type (AtkRelation $relation)
  returns AtkRelationType
  is native(atk)
  is export
{ * }

sub atk_relation_get_target (AtkRelation $relation)
  returns GPtrArray
  is native(atk)
  is export
{ * }

sub atk_relation_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_relation_new (
  AtkObject       $targets,
  gint            $n_targets,
  AtkRelationType $relationship
)
  returns AtkRelation
  is native(atk)
  is export
{ * }

sub atk_relation_remove_target (AtkRelation $relation, AtkObject $target)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_relation_type_for_name (Str $name)
  returns AtkRelationType
  is native(atk)
  is export
{ * }

sub atk_relation_type_get_name (AtkRelationType $type)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_relation_type_register (Str $name)
  returns AtkRelationType
  is native(atk)
  is export
{ * }
