use v6.c;

use ATK::Raw::Types;
use ATK::Raw::EditableText;

use ATK::Object;

role ATK::Roles::EditableText {
  has AtkEditableText $!et;

  method ATK::Raw::Definitions::AtkEditableText
  { $!et }

  method roleInit-AtkEditableText {
    return Nil if $!et;

    my \i = findProperImplementor(self.^attributes);
    $!et  = cast( AtkEditableText, i.get_value(self) );
  }

  method copy_text (Int() $start_pos, Int() $end_pos) {
    my gint ($s, $e) = ($start_pos, $end_pos);

    atk_editable_text_copy_text($!et, $s, $e);
  }

  method cut_text (Int() $start_pos, Int() $end_pos) {
    my gint ($s, $e) = ($start_pos, $end_pos);

    atk_editable_text_cut_text($!et, $s, $e);
  }

  method delete_text (Int() $start_pos, Int() $end_pos) {
    my gint ($s, $e) = ($start_pos, $end_pos);

    atk_editable_text_delete_text($!et, $s, $e);
  }

  method editabletext_get_type (::?CLASS:U: ) {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &atk_editable_text_get_type, $n, $t );
  }

  method insert_text (Str $string, Int() $length, Int() $position) {
    my gint ($l, $p) = ($length, $position);

    atk_editable_text_insert_text($!et, $string, $l, $p);
  }

  method paste_text (gint $position) {
    atk_editable_text_paste_text($!et, $position);
  }

  method set_run_attributes (
    GSList() $attrib_set,    # AtkAttributeSet
    Int()    $start_offset,
    Int()    $end_offset
  ) {
    my gint ($s, $e) = ($start_offset, $end_offset);

    so atk_editable_text_set_run_attributes($!et, $attrib_set, $s, $e);
  }

  method set_text_contents (Str() $string) {
    atk_editable_text_set_text_contents($!et, $string);
  }

}


our subset AtkEditableTextAncestry is export of Mu
  where AtkEditableText | AtkObjectAncestry;

class ATK::EditableText is ATK::Object {
  also does ATK::Roles::EditableText;

  submethod BUILD (:$editable-text) {
    self.setAtkEditableText($editable-text) if $editable-text;
  }

  method setAtkEditableText (AtkEditableTextAncestry $_) {
    my $to-parent;

    $!et = do {
      when AtkEditableText {
        $to-parent = cast(AtkObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkEditableText, $_);
      }
    }
    self.setAtkObject($to-parent);
  }

  method new (AtkEditableTextAncestry $editable-text, :$ref = True) {
    return Nil unless $editable-text;

    my $o = self.bless(:$editable-text);
    $o.ref if $ref;
    $o;
  }

}
