use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use ATK::Raw::Definitions;
use ATK::Raw::Enums;
use ATK::Raw::Structs;

unit package ATK::Raw::RelationSet;

### /usr/include/atk-1.0/atk/atkrelationset.h

sub atk_relation_set_add (AtkRelationSet $set, AtkRelation $relation)
  is native(atk)
  is export
{ * }

sub atk_relation_set_add_relation_by_type (
  AtkRelationSet $set,
  AtkRelationType $relationship,
  AtkObject $target
)
  is native(atk)
  is export
{ * }

sub atk_relation_set_contains (
  AtkRelationSet $set,
  AtkRelationType $relationship
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_relation_set_contains_target (
  AtkRelationSet $set,
  AtkRelationType $relationship,
  AtkObject $target
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_relation_set_get_n_relations (AtkRelationSet $set)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_relation_set_get_relation (AtkRelationSet $set, gint $i)
  returns AtkRelation
  is native(atk)
  is export
{ * }

sub atk_relation_set_get_relation_by_type (
  AtkRelationSet $set,
  AtkRelationType $relationship
)
  returns AtkRelation
  is native(atk)
  is export
{ * }

sub atk_relation_set_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_relation_set_new ()
  returns AtkRelationSet
  is native(atk)
  is export
{ * }

sub atk_relation_set_remove (AtkRelationSet $set, AtkRelation $relation)
  is native(atk)
  is export
{ * }
