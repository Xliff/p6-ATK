use v6.c;

use ATK::Raw::Types;
use ATK::Raw::Component;

use ATK::Object;

use ATK::Roles::Signals::Component;

role ATK::Roles::Component {
  also does ATK::Roles::Signals::Component;

  has AtkComponent $!c;

  method ATK::Raw::Definitions::AtkComponent
  { $!c }

  method roleInit-AtkComponent {
    return Nil if $!c;

    \i = findProperImplementor(self.^attributes);
    $!c = cast( AtkComponent, i.get_value(self) );
  }

  method add_focus_handler (&handler) is DEPRECATED<state-change signal> {
    atk_component_add_focus_handler($!c, &handler);
  }

  method contains (Int() $x, Int() $y, Int() $coord_type) {
    my gint         ($xx, $yy) = ($x, $y);
    my AtkCoordType $c         = $coord_type;

    so atk_component_contains($!c, $xx, $yy, $c);
  }

  method get_alpha {
    atk_component_get_alpha($!c);
  }

  proto method get_extents (|)
  { * }

  multi method get_extents (Int() $coord_type) {
    samewith($, $, $, $, $coord_type);
  }
  multi method get_extents (
          $x          is rw,
          $y          is rw,
          $width      is rw,
          $height     is rw,
    Int() $coord_type
  ) {
    my gint         ($xx, $yy, $w, $h) = 0 xx 4;
    my AtkCoordType $c                 = $coord_type;

    atk_component_get_extents($!c, $xx, $yy, $w, $h, $c);
    ($x, $y, $width, $height) = ($xx, $yy, $w, $h);
  }

  method get_layer {
    AtkLayerEnum( atk_component_get_layer($!c) );
  }

  method get_mdi_zorder {
    atk_component_get_mdi_zorder($!c);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_component_get_type, $n, $t );
  }

  method grab_focus {
    so atk_component_grab_focus($!c);
  }

  method ref_accessible_at_point (
    Int() $x,
    Int() $y,
    Int() $coord_type
          :$raw       = False
  ) {
    my gint         ($xx, $yy) = ($x, $y);
    my AtkCoordType $c         = $coord_type;

    my $o = atk_component_ref_accessible_at_point($!c, $xx, $yy, $c);

    $o ??
      ( $raw ?? $o !! ATK::Object.new($o) )
      !!
      Nil;
  }

  method remove_focus_handler (Int() $handler_id) {
    my guint $h = $handler_id;

    atk_component_remove_focus_handler($!c, $hInt());
  }

  method scroll_to (Int() $type) {
    my AtkScrollType $t = $type;

    so atk_component_scroll_to($!c, $t);
  }

  method scroll_to_point (Int() $coords, Int() $x, Int() $y) {
    my gint         ($xx, $yy) = ($x, $y);
    my AtkCoordType $c         = $coord_type;

    so atk_component_scroll_to_point($!c, $c, $xx, $yy);
  }

  method set_extents (
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height,
    Int() $coord_type
  ) {
    my gint         ($xx, $yy, $w, $h) = 0 xx 4;
    my AtkCoordType $c                 = $coord_type;

    so atk_component_set_extents($!c, $xx, $yy, $w, $h, $c);
  }

  method set_position (Int() $x, Int() $y, Int() $coord_type) {
    my gint         ($xx, $yy) = ($x, $y);
    my AtkCoordType $c         = $coord_type;

    so atk_component_set_position($!c, $xx, $yy, $c);
  }

  method set_size (Int() $width, Int() $height) {
    my gint ($w, $h) = ($width, $height);

    so atk_component_set_size($!c, $w, $h);
  }

}

our subset AtkComponentAncestry is export of Mu
  where AtkComponent | AtkObjectAncestry;

class ATK::Component is ATK::Object {
  also does ATK::Roles::Component;

  submethod BUILD (:$component) {
    self.setAtkComponent($component) if $component;
  }

  method setAtkComponent (AtkComponentAncestry $_) {
    my $to-parent;

    $!c = do {
      when AtkComponent {
        $to-parent = cast(AtkObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkComponent, $_);
      }
    }
    self.setAtkObject($to-parent);
  }

  method new (AtkComponentAncestry $component, :$ref = True) {
    return Nil unless $component;

    my $o = self.bless(:$component);
    $o.ref if $ref;
    $o;
  }

}
