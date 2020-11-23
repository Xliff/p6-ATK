use v6.c;

use ATK::Raw::Types;
use ATK::Raw::RelationSet;

use ATK::Relation;

use GLib::Roles::Object;

our subset AtkRelationSetAncestry is export of Mu
  where AtkRelationSet | GObject;

 class ATK::RelationSet {
   also does GLib::Roles::Object;

   has AtkRelationSet $!rs is implementor;

   submethod BUILD (:$relation-set) {
     self.setAtkRelationSet($relation-set) if $relation-set;
   }

   method setAtkRelationSet (AtkRelationSetAncestry $_) {
     my $to-parent;

     $!rs = do {
       when AtkRelationSet {
         $to-parent = cast(GObject, $_);
         $_;
       }

       default {
         $to-parent = $_;
         cast(AtkRelationSet, $_);
       }
     }
     self!setObject($to-parent);
   }

   method ATK::Raw::Structs::AtkRelationSet
   { $!rs }

   multi method new (AtkRelationSetAncestry $relation-set, :$ref = True) {
     return Nil unless $relation-set;

     my $o = self.bless( :$relation-set );
     $o.ref if $ref;
     $o;
   }
   multi method new {
     my $relation-set = atk_relation_set_new();

     $relation-set ?? self.bless( :$relation-set ) !! Nil;
   }

   method add (AtkRelation() $relation) {
    atk_relation_set_add($!rs, $relation);
  }

  method add_relation_by_type (
    Int()       $relationship,
    AtkObject() $target
  ) {
    my AtkRelationType $rt = $relationship;

    atk_relation_set_add_relation_by_type($!rs, $rt, $target);
  }

  method contains (Int() $relationship) {
    my AtkRelationType $rt = $relationship;

    atk_relation_set_contains($!rs, $rt);
  }

  method contains_target (Int() $relationship, AtkObject() $target) {
    my AtkRelationType $rt = $relationship;

    atk_relation_set_contains_target($!rs, $rt, $target);
  }

  method get_n_relations {
    atk_relation_set_get_n_relations($!rs);
  }

  method get_relation (Int() $i, :$raw = False) {
    my gint $ii = $i;
    my      $r  = atk_relation_set_get_relation($!rs, $ii);

    $r ??
      ( $raw ?? $r !! ATK::Relation.new($r, :!ref) )
      !!
      Nil;
  }

  method get_relation_by_type (Int() $relationship, :$raw = False) {
    my AtkRelationType $rt = $relationship;
    my                 $r = atk_relation_set_get_relation_by_type($!rs, $rt);

    $r ??
      ( $raw ?? $r !! ATK::Relation.new($r, :!ref) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_relation_set_get_type, $n, $t );
  }

  method remove (AtkRelation() $relation) {
    atk_relation_set_remove($!rs, $relation);
  }

}
