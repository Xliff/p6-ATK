use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use ATK::Raw::Definitions;
use ATK::Raw::Structs;

unit package ATK::Raw::Table;

### /usr/include/atk-1.0/atk/atktable.h

sub atk_table_add_column_selection (AtkTable $table, gint $column)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_table_add_row_selection (AtkTable $table, gint $row)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_table_get_column_at_index (AtkTable $table, gint $index_)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_table_get_column_description (AtkTable $table, gint $column)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_table_get_column_extent_at (AtkTable $table, gint $row, gint $column)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_table_get_column_header (AtkTable $table, gint $column)
  returns AtkObject
  is native(atk)
  is export
{ * }

sub atk_table_get_n_columns (AtkTable $table)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_table_get_n_rows (AtkTable $table)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_table_get_row_at_index (AtkTable $table, gint $index_)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_table_get_row_description (AtkTable $table, gint $row)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_table_get_row_extent_at (AtkTable $table, gint $row, gint $column)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_table_get_row_header (AtkTable $table, gint $row)
  returns AtkObject
  is native(atk)
  is export
{ * }

sub atk_table_get_selected_columns (AtkTable $table, gint $selected)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_table_get_selected_rows (AtkTable $table, gint $selected)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_table_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_table_is_column_selected (AtkTable $table, gint $column)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_table_is_row_selected (AtkTable $table, gint $row)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_table_is_selected (AtkTable $table, gint $row, gint $column)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_table_ref_at (AtkTable $table, gint $row, gint $column)
  returns AtkObject
  is native(atk)
  is export
{ * }

sub atk_table_remove_column_selection (AtkTable $table, gint $column)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_table_remove_row_selection (AtkTable $table, gint $row)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_table_set_column_description (
  AtkTable $table,
  gint     $column,
  Str      $description
)
  is native(atk)
  is export
{ * }

sub atk_table_set_column_header (
  AtkTable  $table,
  gint      $column,
  AtkObject $header
)
  is native(atk)
  is export
{ * }

sub atk_table_set_row_description (
  AtkTable $table,
  gint     $row,
  Str      $description
)
  is native(atk)
  is export
{ * }

sub atk_table_set_row_header (AtkTable $table, gint $row, AtkObject $header)
  is native(atk)
  is export
{ * }

sub atk_table_get_caption (AtkTable $table)
  returns AtkObject
  is native(atk)
  is export
{ * }

sub atk_table_get_summary (AtkTable $table)
  returns AtkObject
  is native(atk)
  is export
{ * }

sub atk_table_set_caption (AtkTable $table, AtkObject $caption)
  is native(atk)
  is export
{ * }

sub atk_table_set_summary (AtkTable $table, AtkObject $accessible)
  is native(atk)
  is export
{ * }
