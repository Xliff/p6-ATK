use v6.c;

use ATK::Raw::Types;
use ATK::Raw::Table;

use ATK::Object;

role ATK::Roles::Table {
  has AtkTable $!t;

  method ATK::Raw::Definitions::AtkTable
  { $!t }

  method roleInit-AtkTable {
    return Nil if $!t;

    \i   = findProperImplementor(self.^attributes);
    $!t = cast( AtkTable, i.get_value(self) );
  }

  method caption (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $o = atk_table_get_caption($!t);

        $o ??
          ( $raw ?? $o !! ATK::Object.new($o, :!ref) )
          !!
          Nil;
      },
      STORE => sub ($, AtkObject() $caption is copy) {
        atk_table_set_caption($!t, $caption);
      }
    );
  }

  method summary (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $o = atk_table_get_summary($!t);

        $o ??
          ( $raw ?? $o !! ATK::Object.new($o, :!ref) )
          !!
          Nil;
      },
      STORE => sub ($, AtkObject() $accessible is copy) {
        atk_table_set_summary($!t, $accessible);
      }
    );
  }

  # Is originally:
  # AtkTable, gint, gint, gpointer --> void
  method column-deleted {
    self.connect-intint($!t, 'column-deleted');
  }

  # Is originally:
  # AtkTable, gint, gint, gpointer --> void
  method column-inserted {
    self.connect-intint($!t, 'column-inserted');
  }

  # Is originally:
  # AtkTable, gpointer --> void
  method column-reordered {
    self.connect($!t, 'column-reordered');
  }

  # Is originally:
  # AtkTable, gpointer --> void
  method model-changed {
    self.connect($!t, 'model-changed');
  }

  # Is originally:
  # AtkTable, gint, gint, gpointer --> void
  method row-deleted {
    self.connect-intint($!t, 'row-deleted');
  }

  # Is originally:
  # AtkTable, gint, gint, gpointer --> void
  method row-inserted {
    self.connect-intint($!t, 'row-inserted');
  }

  # Is originally:
  # AtkTable, gpointer --> void
  method row-reordered {
    self.connect($!t, 'row-reordered');
  }

  method add_column_selection (Int() $column) {
    my gint $c = $column;

    so atk_table_add_column_selection($!t, $c);
  }

  method add_row_selection (Int() $row) {
    my gint $r = $row;

    so atk_table_add_row_selection($!t, $r);
  }

  method get_column_at_index (Int() $index) {
    my gint $i = $index;

    atk_table_get_column_at_index($!t, $i);
  }

  method get_column_description (Int() $column) {
    my gint $c = $column;

    atk_table_get_column_description($!t, $c);
  }

  method get_column_extent_at (Int() $row, Int() $column) {
    my gint ($r, $c) = ($row, $column);

    atk_table_get_column_extent_at($!t, $r, $c);
  }

  method get_column_header (Int() $column, :$raw = False) {
    my gint $c = $column;
    my      $o = atk_table_get_column_header($!t, $c);

    $o ??
      ( $raw ?? $o !! ATK::Object.new($o, :!ref) )
      !!
      Nil;
  }

  method get_n_columns () {
    atk_table_get_n_columns($!t);
  }

  method get_n_rows () {
    atk_table_get_n_rows($!t);
  }

  method get_row_at_index (Int() $index) {
    my gint $i = $index;

    atk_table_get_row_at_index($!t, $i);
  }

  method get_row_description (Int() $row) {
    my gint $r = $row;

    atk_table_get_row_description($!t, $r);
  }

  method get_row_extent_at (Int() $row, Int() $column) {
    my gint ($r, $c) = ($row, $column);

    atk_table_get_row_extent_at($!t, $r, $c);
  }

  method get_row_header (Int() $row, :$raw = False) {
    my gint $r = $row;
    my      $o = atk_table_get_row_header($!t, $r);

    $o ??
      ( $raw ?? $o !! ATK::Object.new($o, :!ref) )
      !!
      Nil;
  }

  method get_selected_columns (Int() $selected) {
    my gint $s = $selected;

    atk_table_get_selected_columns($!t, $s);
  }

  method get_selected_rows (Int() $selected) {
    my gint $s = $selected;

    atk_table_get_selected_rows($!t, $s);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_table_get_type, $n, $t );
  }

  method is_column_selected (Int() $column) {
    my gint $c = $column;

    atk_table_is_column_selected($!t, $c);
  }

  method is_row_selected (Int() $row) {
    my gint $r = $row;

    so atk_table_is_row_selected($!t, $r);
  }

  method is_selected (Int() $row, Int() $column) {
    my gint ($r, $c) = ($row, $column);

    so atk_table_is_selected($!t, $r, $c);
  }

  method ref_at (Int() $row, Int() $column) {
    my gint ($r, $c) = ($row, $column);

    atk_table_ref_at($!t, $r, $c);
  }

  method remove_column_selection (Int() $column) {
    my gint $c = $column;

    atk_table_remove_column_selection($!t, $c);
  }

  method remove_row_selection (Int() $row) {
    my gint $r = $row;

    atk_table_remove_row_selection($!t, $r);
  }

  method set_column_description (Int() $column, Str $description) {
    my gint $c = $column;

    atk_table_set_column_description($!t, $c, $description);
  }

  method set_column_header (Int() $column, AtkObject $header) {
    my gint $c = $column;

    atk_table_set_column_header($!t, $c, $header);
  }

  method set_row_description (Int() $row, Str $description) {
    my gint $r = $row;

    atk_table_set_row_description($!t, $r, $description);
  }

  method set_row_header (Int() $row, AtkObject() $header) {
    my gint $r = $row;

    atk_table_set_row_header($!t, $r, $header);
  }

}

our subset AtkTableAncestry is export of Mu
  where AtkTable | AtkObject;


class ATK::Table is ATK::Object {
  also does ATK::Roles::Table;

  submethod BUILD (:$table) {
    self.setAtkTable($table) if $table;
  }

  method setAtkTable (AtkTableAncestry $_) {
    my $to-parent;

    $!t = do {
      when AtkTable {
        $to-parent = cast(AtkObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkTable, $_);
      }
    }
    self.setAtkObject($to-parent);
  }

  method new (AtkTableAncestry $table, :$ref = True) {
    return Nil unless $table;

    my $o = self.bless(:$table);
    $o.ref if $ref;
    $o;
  }

}
