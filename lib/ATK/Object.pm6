use v6.c;

use Method::Also;

use ATK::Raw::Types;
use ATK::Raw::Object;

use GLib::Value;
use ATK::RelationSet;
use ATK::StateSet;

use GLib::Roles::Object;
use ATK::Roles::Signals::Object;

our subset AtkObjectAncestry is export of Mu
  where AtkObject | GObject;

class ATK::Object {
  also does GLib::Roles::Object;
  also does ATK::Roles::Signals::Object;

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

  method ATK::Raw::Structs::AtkObject
    is also<AtkObject>
  { $!ao }

  multi method new (AtkObjectAncestry $atk-object, :$ref = True) {
    return Nil unless $atk-object;

    my $o = self.bless( :$atk-object );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $atk-object = self.new-object-ptr( ATK::Object.get-type );

    $atk-object ?? self.bless( :$atk-object ) !! Nil;
  }

  # Type: gint
  method accessible-component-layer is rw
    is also<accessible_component_layer>
  {
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
  method accessible-component-mdi-zorder is rw
    is also<accessible_component_mdi_zorder>
  {
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
  method accessible-description is rw  is also<accessible_description> {
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
  method accessible-hypertext-nlinks is rw
    is also<accessible_hypertext_nlinks>
  {
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
  method accessible-name is rw  is also<accessible_name> {
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
  method accessible-parent (:$raw = False) is rw is also<accessible_parent> {
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
  method accessible-role is rw  is also<accessible_role> {
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
  method accessible-table-caption
    is rw
    is DEPRECATED<table-caption-object>
    is also<accessible_table_caption>
  {
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
  method accessible-table-caption-object (:$raw = False)
    is rw
    is also<accessible_table_caption_object>
  {
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
    is also<accessible_table_column_description>
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
    is also<accessible_table_column_header>
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
    is also<accessible_table_row_description>
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
    is also<accessible_table_row_header>
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
  method accessible-table-summary (:$raw = False)
    is rw
    is also<accessible_table_summary>
  {
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
  method accessible-value is rw is DEPRECATED is also<accessible_value> {
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
  method active-descendant-changed is also<active_descendant_changed> {
    self.connect-active-descendant-changed($!ao);
  }

  # Is originally:
  # AtkObject, guint, gpointer, gpointer --> void
  method children-changed is also<children_changed> {
    self.connect-children-changed($!ao);
  }

  # Is originally:
  # AtkObject, gboolean, gpointer --> void
  method focus-event is also<focus_event> {
    self.connect-focus-event($!ao);
  }

  # Is originally:
  # AtkObject, gpointer, gpointer --> void
  method property-change is also<property_change> {
    self.connect-property-change($!ao);
  }

  # Is originally:
  # AtkObject, gchar, gboolean, gpointer --> void
  method state-change is also<state_change> {
    self.connect-state-change($!ao);
  }

  # Is originally:
  # AtkObject, gpointer --> void
  method visible-data-changed is also<visible_data_changed> {
    self.connect($!ao, 'visible-data-changed');
  }

  method add_relationship (Int() $relationship, AtkObject() $target)
    is also<add-relationship>
  {
    my AtkRelationType $r = $relationship;

    so atk_object_add_relationship($!ao, $r, $target);
  }

  method connect_property_change_handler (&handler)
    is DEPRECATED<property-changed>
    is also<connect-property-change-handler>
  {
    atk_object_connect_property_change_handler($!ao, &handler);
  }

  method get_accessible_id is also<get-accessible-id> {
    atk_object_get_accessible_id($!ao);
  }

  method get_attributes (:$glist = False, :$raw = False)
    is also<get-attributes>
  {
    my $al = atk_object_get_attributes($!ao);

    return Nil unless $al;
    return $al if $glist && $raw;

    $al = GLib::GList.new($al) but GLib::Roles::ListData[AtkAttribute];
    return $al if $glist;

    $al.Array;
  }

  method get_description is also<get-description> {
    atk_object_get_description($!ao);
  }

  method get_index_in_parent is also<get-index-in-parent> {
    atk_object_get_index_in_parent($!ao);
  }

  method get_layer is also<get-layer> {
    atk_object_get_layer($!ao);
  }

  method get_mdi_zorder is also<get-mdi-zorder> {
    atk_object_get_mdi_zorder($!ao);
  }

  method get_n_accessible_children is also<get-n-accessible-children> {
    atk_object_get_n_accessible_children($!ao);
  }

  method get_name is also<get-name> {
    atk_object_get_name($!ao);
  }

  method get_object_locale is also<get-object-locale> {
    atk_object_get_object_locale($!ao);
  }

  method get_parent is also<get-parent> {
    atk_object_get_parent($!ao);
  }

  method get_role is also<get-role> {
    atk_object_get_role($!ao);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_object_get_type, $n, $t );
  }

  method initialize (ATK::Object:U: AtkObject $accessible, gpointer $data) {
    atk_object_initialize($accessible, $data);
  }

  method notify_state_change (Int() $state, Int() $value)
    is also<notify-state-change>
  {
    my AtkState $s = $state;
    my gboolean $v = $value.so.Int;

    atk_object_notify_state_change($!ao, $s, $value);
  }

  method peek_parent (:$raw = False) is also<peek-parent> {
    my $p = atk_object_peek_parent($!ao);

    $p ??
      ( $raw ?? $p !! ATK::Object.new($p, :!ref) )
      !!
      Nil;
  }

  method ref_accessible_child (Int() $i, :$raw = False)
    is also<ref-accessible-child>
  {
    my gint $ii = $i;
    my      $c  = atk_object_ref_accessible_child($!ao, $ii);

    $c ??
      ( $raw ?? $c !! ATK::Object.new($c, :!ref) )
      !!
      Nil;
  }

  method ref_relation_set (:$raw = False) is also<ref-relation-set> {
    my $rs = atk_object_ref_relation_set($!ao);

    $rs ??
      ( $raw ?? $rs !! ATK::RelationSet.new($rs, :!ref) )
      !!
      Nil;
  }

  method ref_state_set (:$raw = False) is also<ref-state-set> {
    my $ss = atk_object_ref_state_set($!ao);

    $ss ??
      ( $raw ?? $ss !! ATK::StateSet.new($ss, :!ref) )
      !!
      Nil;
  }

  method remove_property_change_handler (Int() $handler_id)
    is DEPRECATED
    is also<remove-property-change-handler>
  {
    my guint $h = $handler_id;

    atk_object_remove_property_change_handler($!ao, $h);
  }

  method remove_relationship (Int() $relationship, AtkObject() $target)
    is also<remove-relationship>
  {
    my AtkRelationType $r = $relationship;

    so atk_object_remove_relationship($!ao, $r, $target);
  }

  method set_accessible_id (Str() $name) is also<set-accessible-id> {
    atk_object_set_accessible_id($!ao, $name);
  }

  method set_description (Str() $description) is also<set-description> {
    atk_object_set_description($!ao, $description);
  }

  method set_name (Str() $name) is also<set-name> {
    atk_object_set_name($!ao, $name);
  }

  method set_parent (AtkObject() $parent) is also<set-parent> {
    atk_object_set_parent($!ao, $parent);
  }

  method set_role (Int() $role) is also<set-role> {
    my AtkRole $r = $role;

    atk_object_set_role($!ao, $r);
  }

}
