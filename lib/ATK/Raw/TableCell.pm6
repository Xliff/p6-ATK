use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use ATK::Raw::Definitions;
use ATK::Raw::Structs;

unit package ATK::Raw::TableCell;

### /usr/include/atk-1.0/atk/atktablecell.h

sub atk_table_cell_get_column_header_cells (AtkTableCell $cell)
  returns GPtrArray
  is native(atk)
  is export
{ * }

sub atk_table_cell_get_column_span (AtkTableCell $cell)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_table_cell_get_position (
  AtkTableCell $cell, 
  gint         $row    is rw, 
  gint         $column is rw
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_table_cell_get_row_column_span (
  AtkTableCell $cell, 
  gint         $row         is rw, 
  gint         $column      is rw, 
  gint         $row_span    is rw, 
  gint         $column_span is rw
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_table_cell_get_row_header_cells (AtkTableCell $cell)
  returns GPtrArray
  is native(atk)
  is export
{ * }

sub atk_table_cell_get_row_span (AtkTableCell $cell)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_table_cell_get_table (AtkTableCell $cell)
  returns AtkObject
  is native(atk)
  is export
{ * }

sub atk_table_cell_get_type ()
  returns GType
  is native(atk)
  is export
{ * }
