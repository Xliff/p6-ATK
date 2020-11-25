use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use ATK::Raw::Definitions;
use ATK::Raw::Enums;
use ATK::Raw::Structs;

unit package ATK::Raw::Component;

### /usr/include/atk-1.0/atk/atkcomponent.h

sub atk_component_add_focus_handler (
  AtkComponent    $component,
                  &handler (AtkObject, gpointer)
)
  returns guint
  is native(atk)
  is export
{ * }

sub atk_rectangle_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_component_contains (
  AtkComponent $component,
  gint         $x,
  gint         $y,
  AtkCoordType $coord_type
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_component_get_alpha (AtkComponent $component)
  returns gdouble
  is native(atk)
  is export
{ * }

sub atk_component_get_extents (
  AtkComponent $component,
  gint         $x          is rw,
  gint         $y          is rw,
  gint         $width      is rw,
  gint         $height     is rw,
  AtkCoordType $coord_type
)
  is native(atk)
  is export
{ * }

sub atk_component_get_layer (AtkComponent $component)
  returns AtkLayer
  is native(atk)
  is export
{ * }

sub atk_component_get_mdi_zorder (AtkComponent $component)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_component_get_position (
  AtkComponent $component,
  gint         $x          is rw,
  gint         $y          is rw,
  AtkCoordType $coord_type
)
  is DEPRECATED<atk_component_get_extents>
  is native(atk)
  is export
{ * }

sub atk_component_get_size (
  AtkComponent $component,
  gint         $width      is rw,
  gint         $height     is rw
)
  is DEPRECATED<atk_component_get_extents>
  is native(atk)
  is export
{ * }

sub atk_component_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_component_grab_focus (AtkComponent $component)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_component_ref_accessible_at_point (
  AtkComponent $component,
  gint         $x,
  gint         $y,
  AtkCoordType $coord_type
)
  returns AtkObject
  is native(atk)
  is export
{ * }

sub atk_component_remove_focus_handler (
  AtkComponent $component,
  guint        $handler_id
)
  is native(atk)
  is export
{ * }

sub atk_component_scroll_to (AtkComponent $component, AtkScrollType $type)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_component_scroll_to_point (
  AtkComponent $component,
  AtkCoordType $coords,
  gint         $x,
  gint         $y
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_component_set_extents (
  AtkComponent $component,
  gint         $x,
  gint         $y,
  gint         $width,
  gint         $height,
  AtkCoordType $coord_type
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_component_set_position (
  AtkComponent $component,
  gint         $x,
  gint         $y,
  AtkCoordType $coord_type
)
  returns uint32
  is native(atk)
  is export
{ * }

sub atk_component_set_size (
  AtkComponent $component,
  gint         $width,
  gint         $height
)
  returns uint32
  is native(atk)
  is export
{ * }
