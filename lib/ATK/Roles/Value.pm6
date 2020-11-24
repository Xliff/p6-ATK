use v6.c;

use NativeCall;

use ATK::Raw::Types;
use ATK::Raw::Value;

use GLib::GList;
use ATK::Range;

use GLib::Roles::ListData;
use GLib::Roles::Object;
use GLib::Roles::StaticClass;

use ATK::Roles::Signals::Value;

role ATK::Roles::Value {
  also does ATK::Roles::Signals::Value;

  has AtkValue $!v;

  method ATK::Raw::Definitions::AtkValue
  { $!v }

  method roleInit-AtkValue {
    return Nil if $!v;

    \i = findProperImplementor(self.^attributes);
    $!v = cast( AtkValue, i.get_value(self) );
  }

  # Is originally:
  # AtkValue, gdouble, gchar, gpointer --> void
  method value-changed {
    self.connect-value-changed($!v);
  }

  method get_current_value (GValue() $value)
    is DEPRECATED<get_value_and_text>
  {
    atk_value_get_current_value($!v, $value);
  }

  method get_increment {
    atk_value_get_increment($!v);
  }

  method get_maximum_value (GValue() $value) is DEPRECATED<get_range> {
    atk_value_get_maximum_value($!v, $value);
  }

  method get_minimum_increment (GValue() $value) is DEPRECATED<get_increment> {
    atk_value_get_minimum_increment($!v, $value);
  }

  method get_minimum_value (GValue() $value) is DEPRECATED<get_range> {
    atk_value_get_minimum_value($!v, $value);
  }

  method get_range (:$glist = False, :$raw = False) {
    my $rl = atk_value_get_range($!v);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[AtkRange];
    return $rl if $glist;

    $raw ?? $rl.Array !! $rl.Array.map({ ATK::Range.new($_, :!ref) });
  }

  method get_sub_ranges {
    atk_value_get_sub_ranges($!v);
  }

  method value_get_type (::?CLASS:U: ) {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &atk_value_get_type, $n, $t );
  }

  proto method get_value_and_text (|)
  { * }

  multi method get_value_and_text {
    samewith($, $);
  }
  multi method get_value_and_text ($value is rw, $text is rw) {
    my gdouble     $v = 0;
    my CArray[Str] $t = CArray[Str].new;

    $t[0] = Str;
    atk_value_get_value_and_text($!v, $v, $t);
    ($value, $text) = ( $v, ppr($t) );
  }

  method set_current_value (GValue() $value) is DEPRECATED<set_value> {
    atk_value_set_current_value($!v, $value);
  }

  method set_value (Num() $new_value) {
    my gdouble $nv = $new_value;

    atk_value_set_value($!v, $nv);
  }

}

our subset AtkValueAncestry is export of Mu
  where AtkValue | GObject;

class ATK::Value {
  also does GLib::Roles::Object;
  also does ATK::Roles::Value;

  submethod BUILD (:$value) {
    self.setAtkValue($value) if $value;
  }

  method setAtkValue (AtkValueAncestry $_) {
    my $to-parent;

    $!v = do {
      when AtkValue {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkValue, $_);
      }
    }
    self!setObject($to-parent);
  }

  method new (AtkValueAncestry $value, :$ref = True) {
    return Nil unless $value;

    my $o = self.bless( :$value );
    $o.ref if $ref;
    $o;
  }

}

class ATK::Value::Type {
  also does GLib::Roles::StaticClass;

  method get_localized_name (Int() $type) {
    my AtkValueType $t = $type;

    atk_value_type_get_localized_name($t);
  }

  method get_name (Int() $type) {
    my AtkValueType $t = $type;

    atk_value_type_get_name($t);
  }

}
