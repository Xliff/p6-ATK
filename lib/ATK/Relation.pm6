use v6.c;

use Method::Also;

use ATK::Raw::Types;
use ATK::Raw::Relation;

use GLib::Array;
use GLib::Value;

use GLib::Roles::Object;
use GLib::Roles::StaticClass;
use GLib::Roles::TypedArray;

our subset AtkRelationAncestry is export of Mu
  where AtkRelation | GObject;

class ATK::Relation {
  also does GLib::Roles::Object;

  has AtkRelation $!r is implementor;

  submethod BUILD (:$relation) {
    self.setAtkRelation($relation) if $relation;
  }

  method setAtkRelation (AtkRelationAncestry $_) {
    my $to-parent;

    $!r = do {
      when AtkRelation {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkRelation, $_);
      }
    }
    self!setObject($to-parent);
  }

  method ATK::Raw::Structs::AtkRelation\
    is also<AtkRelation>
  { $!r }

  multi method new (AtkRelationAncestry $relation, :$ref = True) {
    return Nil unless $relation;

    my $o = self.bless( :$relation );
    $o.ref if $ref;
    $o;
  }
  multi method new (
            @targets,
    Int()   $relationship
  ) {
    samewith(
      GLib::Role::TypedBuffer[AtkObject].new(@targets).p,
      @targets.elems,
      $relationship
    );
  }
  multi method new (
    gpointer $targets,
    Int()    $n_targets,
    Int()    $relationship
  ) {
    my AtkRelationType $r        = $relationship;
    my gint            $n        = $n_targets;
    my                 $relation = atk_relation_new($!r, $n, $relationship);

    $relation ?? self.bless( :$relation ) !! Nil;
  }

  # Type: AtkRelationType
  method relation-type is rw  is also<relation_type> {
    my $gv = GLib::Value.new( GLib::Value.gtypeFromType(AtkRelationType) );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('relation-type', $gv)
        );
        AtkRelationTypeEnum( $gv.enum );
      },
      STORE => -> $,  $val is copy {
        $gv.valueFromType(AtkRelationType) = $val;
        self.prop_set('relation-type', $gv);
      }
    );
  }

  # Type: GValueArray (now GArray)
  method target (:$raw = False) is rw  {
    my $gv = GLib::Value.new( GLib::Array.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('target', $gv)
        );

        my $o = $gv.pointer;
        return Nil unless $o;

        $o = cast(GArray, $o);
        return $o if $raw;

        GLib::Array.new($o, type => AtkObject);
      },
      STORE => -> $, GArray() $val is copy {
        $gv.pointer = $val;
        self.prop_set('target', $gv);
      }
    );
  }

  method add_target (AtkObject() $target) is also<add-target> {
    atk_relation_add_target($!r, $target);
  }

  method get_relation_type is also<get-relation-type> {
    AtkRelationTypeEnum( atk_relation_get_relation_type($!r) );
  }

  method get_target (:$garray = False, :$raw = False) is also<get-target> {
    my $p = atk_relation_get_target($!r);

    return Nil unless $p;
    return $p if $garray && $raw;

    $p = GLib::Array.new($p, type => AtkObject);
    return $p if $garray;

    $raw ?? $p.Array
         !! $p.Array.map({ ::('ATK::Object').new(.deref) });
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_relation_get_type, $n, $t );
  }

  method remove_target (AtkObject() $target) is also<remove-target> {
    so atk_relation_remove_target($!r, $target);
  }

}

class ATK::Relation::Type {
  also does GLib::Roles::StaticClass;

  method for_name (Str() $name, :$enum = True) is also<for-name> {
    my $v = atk_relation_type_for_name($name);
    if $enum {
      return AtkRelationTypeEnum($v)
        if AtkRelationTypeEnum.enums.values.any == $v;
    }
    $v;
  }

  method get_name (Int() $type) is also<get-name> {
    my AtkRelationType $t = $type;

    atk_relation_type_get_name($t);
  }

  # cw: Return type will be a new value associated with $name, so not in
  #     AtkRelationTypeEnum!
  method register (Str() $name) {
    atk_relation_type_register($name);
  }

}
