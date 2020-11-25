use v6.c;

use ATK::Raw::Types;
use ATK::Raw::TableCell;

use GLib::Array;
use ATK::Object;

role ATK::Roles::TableCell {
  has AtkTableCell;
  
  method ATK::Raw::Definitions::AtkTableCell
  { $!tc }

  method roleInit-AtkTableCell {
    return Nil if $!tc;

    my \i = findProperImplementor(self.^attributes);
    $!tc  = cast( AtkTableCell, i.get_value(self) );
  }
  
   method get_column_header_cells {
    atk_table_cell_get_column_header_cells($!tc);
  }

  method get_column_span {
    atk_table_cell_get_column_span($!tc);
  }

  proto method get_position (|)
  { * }
  
  multi method get_position {
    samewith($, $);
  }
  multi method get_position (
    $row    is rw, 
    $column is rw
  ) {
    my gint ($r, $c) = 0 xx 2;
    
    atk_table_cell_get_position($!tc, $r, $c);
    ($row, $column) = ($r, $c);
  }

  proto method get_row_column_span (|)
  { * }
  
  multi method get_row_column_span {
    my $rv = samewith($, $, $, $);
    
    $rv[0] ?? $rv.skip(1) !! Nil;
  }
  multi method get_row_column_span (
    $row         is rw, 
    $column      is rw, 
    $row_span    is rw, 
    $column_span is rw
  ) {
    my ($r, $c, $rs, $cs) = 0 xx 4;
    
    my $rv = so atk_table_cell_get_row_column_span($!tc, $r, $c, $rs, $cs);
    ($row, $column, $row_span, $column_span) = ($r, $c, $rs, $cs);
    ($rv, $row, $column, $row_span, $column_span);
  }

  method get_row_header_cells (:$array = False, :$raw = False) {
    my $hc = atk_table_cell_get_row_header_cells($!tc);
    
    return Nil unless $hc;
    return $hc if $array && $raw;
    
    $hc = GLib::Array.new($hc) but GLib::Roles::TypedArray[AtkObject];
    return $hc if $array;
    
    $raw ?? $hc.Array
         !! $hc.Array.map({ ATK::Object.new($_) });
  }

  method get_row_span {
    atk_table_cell_get_row_span($!tc);
  }

  method get_table (:$raw = False) {
    my $t = atk_table_cell_get_table($!tc);
    
    $t ??
      ( $raw ?? $t !! ATK::Table.new($t, :!ref) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);
    
    unstable_get_type( self.^name,. &atk_table_cell_get_type, $n, $t );
  }
  
}

our subset AtkTableCellAncestry is export of Mu
  where AtkTableCell | AtkObject;
  
class ATK::TableCell is ATK::Object {
  also does ATK::Roles::TableCell;
  
  submethod BUILD (:$table-cell) {
    self.setAtkTableCell($table-cell) if $table-cell;
  }
  
  method setAtkTableCell (AtkTableCellAncestry $_) {
    my $to-parent;
    
    $!tc = do {
      when AtkTableCell {
        $to-parent = cast(AtkObject, $_);
        $_;
      }
      
      default {
        $to-parent = $_;
        cast(AtkTableCell, $_);
      }
    }
    self.setAtkObject($to-parent);
  }
  
  method new (AtkTableCellAncestry $table-cell, :$ref = True) {
    return Nil unless $table-cell;
    
    my $o = self.bless( :$table-cell );
    $o.ref if $ref;
    $o;
  }
  
}
