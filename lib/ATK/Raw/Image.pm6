use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use ATK::Raw::Definitions;
use ATK::Raw::Enums;

unit package ATK::Raw::Image;

### /usr/include/atk-1.0/atk/atkimage.h

sub atk_image_get_image_locale (AtkImage $image)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_image_get_image_position (
  AtkImage     $image,
  gint         $x,
  gint         $y,
  AtkCoordType $coord_type
)
  is native(atk)
  is export
{ * }

sub atk_image_get_image_size (AtkImage $image, gint $width, gint $height)
  is native(atk)
  is export
{ * }

sub atk_image_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_image_get_image_description (AtkImage $image)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_image_set_image_description (AtkImage $image, Str $description)
  returns uint32
  is native(atk)
  is export
{ * }
