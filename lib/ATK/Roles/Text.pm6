use v6.c;

use ATK::Raw::Types;
use ATK::Raw::Text;

use ATK::Roles::Signals::Text;

use GLib::GList;
use ATK::Object;

use GLib::Roles::ListData;
use GLib::Roles::StaticClass;
use ATK::Roles::Signals::Text;

role ATK::Roles::Text {
  also does ATK::Roles::Signals::Text;

  has AtkText $!text;

  method ATK::Raw::Definitions::AtkText
  { $!text }

  method roleInit-AtkText {
    return Nil if $!text;

    my \i = findProperImplementor(self.^attributes);
    $!text = cast( AtkText, i.get_value(self) );
  }

  method caret_offset is rw {
    Proxy.new(
      FETCH => sub ($) {
        so atk_text_get_caret_offset($!text);
      },
      STORE => sub ($, Int() $offset is copy) {
        my gboolean $o = $offset.so.Int;

        atk_text_set_caret_offset($!text, $o);
      }
    );
  }

  # Is originally:
  # AtkText, gpointer --> void
  method text-attributes-changed {
    self.connect($!text, 'text-attributes-changed');
  }

  # Is originally:
  # AtkText, gint, gpointer --> void
  method text-caret-moved {
    self.connect-int($!text);
  }

  # Is originally:
  # AtkText, gint, gint, gpointer --> void
  method text-changed {
    self.connect-intint($!text);
  }

  # Is originally:
  # AtkText, gint, gint, gchar, gpointer --> void
  method text-insert {
    self.connect-text-action($!text, 'text-insert');
  }

  # Is originally:
  # AtkText, gint, gint, gchar, gpointer --> void
  method text-remove {
    self.connect-text-action($!text, 'text-remove');
  }

  # Is originally:
  # AtkText, gpointer --> void
  method text-selection-changed {
    self.connect($!text, 'text-selection-changed');
  }

  method add_selection (Int() $start_offset, Int() $end_offset) {
    my gint ($s, $e) = ($start_offset, $end_offset);

    so atk_text_add_selection($!text, $start_offset, $end_offset);
  }

  # for ::Subs?
  method attribute_set_free (AtkAttributeSet $set) {
    atk_attribute_set_free($set);
  }

  method free_ranges (::?CLASS:U: gpointer $ranges) {
    atk_text_free_ranges($ranges);
  }

  method get_bounded_ranges (
    AtkTextRectangle $rect,
    Int()            $coord_type,
    Int()            $x_clip_type,
    Int()            $y_clip_type,
                     :$raw         = False
  ) {
    my AtkCoordType    $c       = $coord_type;
    my AtkTextClipType ($x, $y) = ($x_clip_type, $y_clip_type);

    my $r = atk_text_get_bounded_ranges($!text, $rect, $c, $x, $y);
    return Nil unless $r;
    return $r if $raw;

    GLib::Roles::TypedBuffer.new($r).Array;
  }

  method get_character_at_offset (Int() $offset) {
    my gint $o = $offset;

    atk_text_get_character_at_offset($!text, $o);
  }

  method get_character_count {
    atk_text_get_character_count($!text);
  }

  proto method get_character_extents (|)
  { * }

  multi method get_character_extents (
    Int() $offset,
    Int() $coords
  ) {
    samewith($offset, $, $, $, $, $coords);
  }
  multi method get_character_extents (
    Int() $offset,
          $x       is rw,
          $y       is rw,
          $width   is rw,
          $height  is rw,
    Int() $coords
  ) {
    my gint         ($o, $xx, $yy, $w, $h) = ($offset, 0, 0, 0, 0);
    my AtkCoordType $c                     = $coords;

    atk_text_get_character_extents($!text, $offset, $xx, $yy, $w, $h, $c);
    ($x, $y, $width, $height) = ($xx, $yy, $w, $h);
  }

  method get_default_attributes (:$glist = False, :$raw = False) {
    my $al = atk_text_get_default_attributes($!text);

    return Nil unless $al;
    return $al if $glist && $raw;

    $al = GLib::GList.new($al) but GLib::Roles::ListData[AtkAttribute];
    return $al if $glist;

    $al.Array;
  }

  method get_n_selections {
    atk_text_get_n_selections($!text);
  }

  method get_offset_at_point (Int() $x, Int() $y, Int() $coords) {
    my gint         ($xx, $yy) = ($x, $y);
    my AtkCoordType $c         = $coords;

    atk_text_get_offset_at_point($!text, $x, $y, $coords);
  }

  proto method get_range_extents (|)
  { * }

  multi method get_range_extents (
    Int() $start_offset,
    Int() $end_offset,
    Int() $coord_type,
  ) {
    samewith($start_offset, $end_offset, $coord_type, $);
  }
  multi method get_range_extents (
    Int() $start_offset,
    Int() $end_offset,
    Int() $coord_type,
          $rect        is rw
  ) {
    my gint         ($s, $e) = ($start_offset, $end_offset);
    my AtkCoordType $c       = $coord_type;
    my $r                    = AtkTextRectangle.new;

    atk_text_get_range_extents($!text, $s, $e, $c, $r);
    $rect = $r;
  }

  proto method get_run_attributes (|)
  { * }

  multi method get_run_attributes (Int() $offset) {
    my ($so, $eo);
    my $a = samewith($offset, $so, $eo);

    ($a, $so, $eo);
  }
  multi method get_run_attributes (
    Int() $offset,
          $start_offset is rw,
          $end_offset   is rw,
          :$glist       =  False,
          :$raw         =  False
  ) {
    my gint ($o, $s, $e) = ($offset, 0, 0);
    my $al               = atk_text_get_run_attributes($!text, $o, $s, $e);

    return Nil unless $al;
    return $al if $glist && $raw;

    $al = GLib::GList.new($al) but GLib::Roles::ListData[AtkAttribute];
    return $al if $glist;

    $al.Array;
  }

  proto method get_selection (|)
  { * }

  multi method get_selection (Int() $selection_num) {
    samewith($selection_num, $, $);
  }
  multi method get_selection (
    Int() $selection_num,
          $start_offset   is rw,
          $end_offset     is rw
  ) {
    my gint ($n, $s, $e) = ($selection_num, 0, 0);

    atk_text_get_selection($!text, $n, $s, $e);
    ($start_offset, $end_offset) = ($s, $e);
  }

  method get_string_at_offset (
    Int() $offset,
    Int() $granularity,
    Int() $start_offset,
    Int() $end_offset
  ) {
    my gint               ($o, $s, $e) = ($offset, $start_offset, $end_offset);
    my AtkTextGranularity $g           = $granularity;

    atk_text_get_string_at_offset($!text, $o, $granularity, $s, $e);
  }

  method get_text (Int() $start_offset, Int() $end_offset) {
    my gint ($s, $e) = ($start_offset, $end_offset);

    atk_text_get_text($!text, $start_offset, $end_offset);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_text_get_type, $n, $t );
  }

  method remove_selection (Int() $selection_num) {
    my gint $s = $selection_num;

    atk_text_remove_selection($!text, $s);
  }

  method scroll_substring_to (
    Int() $start_offset,
    Int() $end_offset,
    Int() $type
  ) {
    my gint          ($s, $e) = ($start_offset, $end_offset);
    my AtkScrollType $t       = $type;

    atk_text_scroll_substring_to($!text, $s, $e, $t);
  }

  method scroll_substring_to_point (
    Int() $start_offset,
    Int() $end_offset,
    Int() $coords,
    Int() $x,
    Int() $y
  ) {
    my gint         ($s, $e, $xx, $yy) = ($start_offset, $end_offset, $x, $y);
    my AtkCoordType $c                 =  $coords;

    atk_text_scroll_substring_to_point($!text, $s, $e, $c, $xx, $yy);
  }

  method set_selection (
    Int() $selection_num,
    Int() $start_offset,
    Int() $end_offset
  ) {
    my gint ($n, $s, $e) = ($selection_num, $start_offset, $end_offset);

    atk_text_set_selection($!text, $n, $s, $e);
  }

}

our subset AtkTextAncestry is export of Mu
  where AtkText | AtkObject;

class ATK::Text is ATK::Object {
  also does ATK::Roles::Text;

  submethod BUILD (:$text) {
    self.setAtkText($text) if $text;
  }

  method setAtkText (AtkTextAncestry $_) {
    my $to-parent;

    $!text = do {
      when AtkText {
        $to-parent = cast(AtkObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkText, $_);
      }
    }
    self.setAtkObject($to-parent);
  }

  method new (AtkTextAncestry $text, :$ref = True) {
    return Nil unless $text;

    my $o = self.bless(:$text);
    $o.ref if $ref;
    $o;
  }

}

class ATK::Text::Attribute {
  also does GLib::Roles::StaticClass;

  method for_name (Str() $name, :$enum = True) {
    my $v = atk_text_attribute_for_name($name);

    if $enum {
      return AtkTextAttributeEnum($v)
        if AtkTextAttributeEnum.enums.values.any == $v;
    }
    $v;
  }

  method get_name (Int() $attr) {
    my AtkTextAttribute $a = $attr;

    atk_text_attribute_get_name($attr);
  }

  method get_value (Int() $attr, Int() $index) {
    my AtkTextAttribute $a = $attr;

    atk_text_attribute_get_value($a, $index);
  }

  method register (Str() $name) {
    atk_text_attribute_register($name);
  }
}

class ATK::Text::Range {
  also does GLib::Roles::StaticClass;

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_text_range_get_type, $n, $t );
  }
}
