use v6.c;

use NativeCall;

use ATK::Raw::Types;
use ATK::Raw::StateSet;

use GLib::Roles::Object;

our subset AtkStateSetAncestry is export of Mu
  where AtkStateSet | GObject;

class ATK::StateSet {
  also does GLib::Roles::Object;

  has AtkStateSet $!ss is implementor;

  submethod BUILD (:$state-set) {
    self.setAtkStateSet($state-set) if $state-set;
  }

  method setAtkStateSet (AtkStateSetAncestry $_) {
    my $to-parent;

    $!ss = do {
      when AtkStateSet {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkStateSet, $_);
      }
    }
    self!setObject($to-parent);
  }

  method ATK::Raw::Structs::AtkStateSet
  { $!ss }

  multi method new (AtkStateSetAncestry $state-set, :$ref = True) {
    return Nil unless $state-set;

    my $o = self.bless( :$state-set );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $state-set = atk_state_set_new();

    $state-set ?? self.bless(:$state-set) !! Nil;
  }

  method add_state (Int() $type) {
    my AtkStateType $t = $type;

    so atk_state_set_add_state($!ss, $t);
  }

  proto method add_states (|)
  { * }

  multi method add_states (@types) {
    samewith(
      ArrayToCArray(AtkStateType, @types),
      @types.elems;
    );
  }
  multi method add_states (
    CArray[AtkStateType] $types,
    Int()                $n_types
  ) {
    my gint $nn = $n_types;

    atk_state_set_add_states($!ss, $types, $nn);
  }

  method and_sets (AtkStateSet() $compare_set, :$raw = False) {
    my $ss = atk_state_set_and_sets($!ss, $compare_set);

    $ss ??
      ( $raw ?? $ss !! ATK::StateSet.new($ss, :!ref) )
      !!
      Nil;
  }

  method clear_states {
    atk_state_set_clear_states($!ss);
  }

  method contains_state (Int() $type) {
    my AtkStateType $t = $type;

    so atk_state_set_contains_state($!ss, $t);
  }

  proto method contains_states (|)
  { * }

  multi method contains_states (@types) {
    samewith( ArrayToCArray(AtkStateType, @types), @types.elems );
  }
  multi method contains_states (
    CArray[AtkStateType] $types,
    Int()                $n_types
  ) {
    my gint $nn = $n_types;

    so atk_state_set_contains_states($!ss, $types, $nn);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_state_set_get_type, $n, $t );
  }

  method is_empty {
    so atk_state_set_is_empty($!ss);
  }

  method or_sets (AtkStateSet() $compare_set, :$raw = False) {
    my $ss = atk_state_set_or_sets($!ss, $compare_set);

    $ss ??
      ( $raw ?? $ss !! ATK::StateSet.new($ss, :!ref) )
      !!
      Nil;
  }

  method remove_state (AtkStateType $type) {
    my AtkStateType $t = $type;

    so atk_state_set_remove_state($!ss, $t);
  }

  method xor_sets (AtkStateSet() $compare_set, :$raw = False) {
    my $ss = atk_state_set_xor_sets($!ss, $compare_set);

    $ss ??
      ( $raw ?? $ss !! ATK::StateSet.new($ss, :!ref) )
      !!
      Nil;
  }

}
