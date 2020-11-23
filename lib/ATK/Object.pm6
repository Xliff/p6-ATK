use v6.c;

use ATK::Raw::Types;
use ATK::Raw::Object;

use GLib::Value;
use ATK::RelationSet;
use ATK::StateSet;

use GLib::Roles::Object;

our subset AtkObjectAncestry is export of Mu
  where AtkObject | GObject;

class ATK::Object {
  also does GLib::Roles::Object;

  has AtkObject $!ao is implementor;

  submethod BUILD (:$atk-object) {
    self.setAtkObject($atk-object) if $atk-object;
  }

  method setAtkObject (AtkObjectAncestry $_) {
    my $to-parent;

    $!ao = do {
      when AtkObject {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkObject, $_);
      }
    }
    self!setObject($to-parent);
  }

  method ATK::Raw::Definitions::AtkObject
  { $!ao }

  multi method new (AtkObjectAncestry $atk-object, :$ref = True) {
    return Nil unless $atk-object;

    my $o = self.bless( :$atk-object );
    $o.ref if $ref;
    $o;
  }

  # Type: gint
  method accessible-component-layer is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-component-layer', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'accessible-component-layer does not allow writing'
      }
    );
  }

  # Type: gint
  method accessible-component-mdi-zorder is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-component-mdi-zorder', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'accessible-component-mdi-zorder does not allow writing'
      }
    );
  }

  # Type: gchar
  method accessible-description is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-description', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('accessible-description', $gv);
      }
    );
  }

  # Type: gint
  method accessible-hypertext-nlinks is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-hypertext-nlinks', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'accessible-hypertext-nlinks does not allow writing'
      }
    );
  }

  # Type: gchar
  method accessible-name is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('accessible-name', $gv);
      }
    );
  }

  # Type: AtkObject
  method accessible-parent (:$raw = False) is rw  {
    my $gv = GLib::Value.new( self.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-parent', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(AtkObject, $o);
        return $o if $raw;

        ATK::Object.new($o);
      },
      STORE => -> $, AtkObject() $val is copy {
        $gv.object = $val;
        self.prop_set('accessible-parent', $gv);
      }
    );
  }

  # Type: gint
  method accessible-role is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-role', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('accessible-role', $gv);
      }
    );
  }

  # Type: gchar
  method accessible-table-caption is rw is DEPRECATED<table-caption-object> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-table-caption', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('accessible-table-caption', $gv);
      }
    );
  }

  # Type: AtkObject
  method accessible-table-caption-object (:$raw = False) is rw  {
    my $gv = GLib::Value.new( self.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-table-caption-object', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(AtkObject, $o);
        return $o if $raw;

        ATK::Object.new($o);
      },
      STORE => -> $, AtkObject() $val is copy {
        $gv.TYPE = $val;
        self.prop_set('accessible-table-caption-object', $gv);
      }
    );
  }

  # Type: gchar
  method accessible-table-column-description is rw
    is DEPRECATED(
      'atk_table_get_column_description() and atk_table_set_column_description()'
    )
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-table-column-description', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('accessible-table-column-description', $gv);
      }
    );
  }

  # Type: AtkObject
  method accessible-table-column-header (:$raw = False) is rw
    is DEPRECATED(
      'atk_table_get_column_header() and atk_table_set_column_header()'
    )
  {
    my $gv = GLib::Value.new( self.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-table-column-header', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(AtkObject, $o);
        return $o if $raw;

        ATK::Object.new($o);
      },
      STORE => -> $, AtkObject() $val is copy {
        $gv.object = $val;
        self.prop_set('accessible-table-column-header', $gv);
      }
    );
  }

  # Type: gchar
  method accessible-table-row-description is rw
    is DEPRECATED(
      'atk_table_get_row_description() and atk_table_set_row_description()'
    )
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-table-row-description', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('accessible-table-row-description', $gv);
      }
    );
  }

  # Type: AtkObject
  method accessible-table-row-header (:$raw = False) is rw
    is DEPRECATED(
      'atk_table_get_row_header() and atk_table_set_row_header()'
    )
  {
    my $gv = GLib::Value.new( self.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-table-row-header', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(AtkObject, $o);
        return $o if $raw;

        ATK::Object.new($o);
      },
      STORE => -> $, AtkObject() $val is copy {
        $gv.object = $val;
        self.prop_set('accessible-table-row-header', $gv);
      }
    );
  }

  # Type: AtkObject
  method accessible-table-summary (:$raw = False) is rw  {
    my $gv = GLib::Value.new( self.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-table-summary', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(AtkObject, $o);
        return $o if $raw;

        ATK::Object.new($o);
      },
      STORE => -> $, AtkObject() $val is copy {
        $gv.object = $val;
        self.prop_set('accessible-table-summary', $gv);
      }
    );
  }

  # Type: gdouble
  method accessible-value is rw  is DEPRECATED {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('accessible-value', $gv)
        );
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('accessible-value', $gv);
      }
    );
  }

  # Is originally:
  # AtkObject, gpointer, gpointer --> void
  method active-descendant-changed {
    self.connect-active-descendant-changed($!ao);
  }

  # Is originally:
  # AtkObject, guint, gpointer, gpointer --> void
  method children-changed {
    self.connect-children-changed($!ao);
  }

  # Is originally:
  # AtkObject, gboolean, gpointer --> void
  method focus-event {
    self.connect-focus-event($!ao);
  }

  # Is originally:
  # AtkObject, gpointer, gpointer --> void
  method property-change {
    self.connect-property-change($!ao);
  }

  # Is originally:
  # AtkObject, gchar, gboolean, gpointer --> void
  method state-change {
    self.connect-state-change($!ao);
  }

  # Is originally:
  # AtkObject, gpointer --> void
  method visible-data-changed {
    self.connect($!ao, 'visible-data-changed');
  }

  method add_relationship (Int() $relationship, AtkObject() $target) {
    my AtkRelationType $r = $relationship;

    so atk_object_add_relationship($!ao, $r, $target);
  }

  method connect_property_change_handler (&handler)
    is DEPRECATED<property-changed>
  {
    atk_object_connect_property_change_handler($!ao, &handler);
  }

  method get_accessible_id {
    atk_object_get_accessible_id($!ao);
  }

  method get_attributes (:$glist = False, :$raw = False) {
    my $al = atk_object_get_attributes($!ao);

    return Nil unless $al;
    return $al if $glist && $raw;

    $al = GLib::GList.new($al) but GLib::Roles::ListData[AtkAttribute];
    return $al if $glist;

    $al.Array;
  }

  method get_description {
    atk_object_get_description($!ao);
  }

  method get_index_in_parent {
    atk_object_get_index_in_parent($!ao);
  }

  method get_layer {
    atk_object_get_layer($!ao);
  }

  method get_mdi_zorder {
    atk_object_get_mdi_zorder($!ao);
  }

  method get_n_accessible_children {
    atk_object_get_n_accessible_children($!ao);
  }

  method get_name {
    atk_object_get_name($!ao);
  }

  method get_object_locale {
    atk_object_get_object_locale($!ao);
  }

  method get_parent {
    atk_object_get_parent($!ao);
  }

  method get_role {
    atk_object_get_role($!ao);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_object_get_type, $n, $t );
  }

  method initialize (ATK::Object:U: AtkObject $accessible, gpointer $data) {
    atk_object_initialize($accessible, $data);
  }

  method notify_state_change (Int() $state, Int() $value) {
    my AtkState $s = $state;
    my gboolean $v = $value.so.Int;

    atk_object_notify_state_change($!ao, $s, $value);
  }

  method peek_parent (:$raw = False) {
    my $p = atk_object_peek_parent($!ao);

    $p ??
      ( $raw ?? $p !! ATK::Object.new($p, :!ref) )
      !!
      Nil;
  }

  method ref_accessible_child (Int() $i, :$raw = False) {
    my gint $ii = $i;
    my      $c  = atk_object_ref_accessible_child($!ao, $ii);

    $c ??
      ( $raw ?? $c !! ATK::Object.new($c, :!ref) )
      !!
      Nil;
  }

  method ref_relation_set (:$raw = False) {
    my $rs = atk_object_ref_relation_set($!ao);

    $rs ??
      ( $raw ?? $rs !! ATK::RelationSet.new($rs, :!ref) )
      !!
      Nil;
  }

  method ref_state_set (:$raw = False) {
    my $ss = atk_object_ref_state_set($!ao);

    $ss ??
      ( $raw ?? $ss !! ATK::StateSet.new($ss, :!ref) )
      !!
      Nil;
  }

  method remove_property_change_handler (Int() $handler_id)
    is DEPRECATED
  {
    my guint $h = $handler_id;

    atk_object_remove_property_change_handler($!ao, $h);
  }

  method remove_relationship (Int() $relationship, AtkObject() $target) {
    my AtkRelationType $r = $relationship;

    so atk_object_remove_relationship($!ao, $r, $target);
  }

  method set_accessible_id (Str() $name) {
    atk_object_set_accessible_id($!ao, $name);
  }

  method set_description (Str() $description) {
    atk_object_set_description($!ao, $description);
  }

  method set_name (Str() $name) {
    atk_object_set_name($!ao, $name);
  }

  method set_parent (AtkObject() $parent) {
    atk_object_set_parent($!ao, $parent);
  }

  method set_role (Int() $role) {
    my AtkRole $r = $role;

    atk_object_set_role($!ao, $r);
  }

}

class ATK::Role {
  also does GLib::Roles::StaticClass;

  method for_name (Str() $name) {
    AtkRoleEnum( atk_role_for_name($name) );
  }

  method get_localized_name (Int() $role) {
    my AtkRole $r = $role;

    atk_role_get_localized_name($r);
  }

  method get_name (Int() $role) {
    my AtkRole $r = $role;

    atk_role_get_name($r);
  }

  method register (Str() $name) is DEPRECATED {
    atk_role_register($name);
  }
}
