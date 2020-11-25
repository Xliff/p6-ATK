use v6.c;

use ATK::Raw::Types;
use ATK::Raw::Image;

use ATK::Object;

role ATK::Roles::Image {
  has AtkImage $!i;

  method ATK::Raw::Definitions::AtkImage
  { $!i }

  method roleInit-AtkDocument {
    return Nil if $!i;

    my \i = findProperImplementor(self.^attributes);
    $!i   = cast( AtkImage, i.get_value(self) );
  }

  method image_description is rw {
    Proxy.new:
      FETCH => -> $           { self.get_image_description    };
      STORE => -> $, Str() \s { self.set_image_description(s) };
  }

  method get_image_description {
    atk_image_get_image_description($!i);
  }

  method get_image_locale {
    atk_image_get_image_locale($!i);
  }

  proto method get_image_position (|)
  { * }

  multi method get_image_position (Int() $coord_type) {
    samewith($, $, $coord_type);
  }
  multi method get_image_position ($x is rw, $y is rw, Int() $coord_type) {
    my gint         ($xx, $yy) = 0 xx 2;
    my AtkCoordType $c         = $coord_type;

    atk_image_get_image_position($!i, $xx, $yy, $coord_type);
    ($x, $y) = ($xx, $yy);
  }

  proto method get_image_size (|)
  { * }

  multi method get_image_size {
    samewith($, $);
  }
  multi method get_image_size ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    atk_image_get_image_size($!i, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method image_get_type (::?CLASS:U: ) {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &atk_image_get_type, $n, $t );
  }

  method set_image_description (Str() $description) {
    so atk_image_set_image_description($!i, $description);
  }

}

our subset AtkImageAncestry is export of Mu
  where AtkImage | AtkObject;

class ATK::Image is ATK::Object {
  also does ATK::Roles::Image;

  submethod BUILD (:$image) {
    self.setAtkImage($image) if $image;
  }

  method setAtkImage (AtkImageAncestry $_) {
    my $to-parent;

    $!i = do {
      when AtkImage {
        $to-parent = cast(AtkObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkImage, $_);
      }
    }
    self.setAtkObject($to-parent);
  }

  method new (AtkImageAncestry $image, :$ref = True) {
    return Nil unless $image;

    my $o = self.bless( :$image );
    $o.ref if $ref;
    $o;
  }

}
