use v6.c;

use NativeCall;

use ATK::Raw::Types;

use ATK::Object;

use ATK::Roles::Action;
use ATK::Roles::Component;
use ATK::Roles::Document;
use ATK::Roles::EditableText;
use ATK::Roles::Image;
use ATK::Roles::Selection;
use ATK::Roles::Table;
use ATK::Roles::TableCell;
use ATK::Roles::Value;
use ATK::Roles::Window;

our @no-op-object-composable-roles is export;

our subset AtkNoOpObjectAncestry is export of Mu where
  AtkNoOpObject   | AtkAction       | AtkComponent    | AtkDocument        |
  AtkEditableText | AtkImage        | AtkSelection    | AtkTable           |
  AtkTableCell    | AtkValue        | AtkWindow       | AtkObjectAncestry;

class ATK::NoOpObject is ATK::Object {
  also does ATK::Roles::Action;
  also does ATK::Roles::Component;
  also does ATK::Roles::Document;
  also does ATK::Roles::EditableText;
  also does ATK::Roles::Image;
  also does ATK::Roles::Selection;
  also does ATK::Roles::Table;
  also does ATK::Roles::TableCell;
  also does ATK::Roles::Value;
  also does ATK::Roles::Window;

  has AtkNoOpObject $!noo;

  submethod BUILD (:$no-op) {
    self.setAtkNoOpObject($no-op) if $no-op;
  }

  method setAtkNoOpObject (AtkNoOpObjectAncestry $_) {
    my $to-parent;

    $!noo = {
      when AtkNoOpObject {
        $to-parent = cast(AtkObject, $_);
        $_;
      }

      when AtkAction {
        $to-parent = cast(AtkObject, $_);
        $!a = $_;
        cast(AtkNoOpObject, $_);
      }

      when AtkComponent {
        $to-parent = cast(AtkObject, $_);
        $!c = $_;
        cast(AtkNoOpObject, $_);
      }

      when AtkDocument {
        $to-parent = cast(AtkObject, $_);
        $!d = $_;
        cast(AtkNoOpObject, $_);
      }

      when AtkEditableText {
        $to-parent = cast(AtkObject, $_);
        $!et = $_;
        cast(AtkNoOpObject, $_);
      }

      when AtkImage {
        $to-parent = cast(AtkObject, $_);
        $!et = $_;
        cast(AtkNoOpObject, $_);
      }

      when AtkImage {
        $to-parent = cast(AtkObject, $_);
        $!i = $_;
        cast(AtkNoOpObject, $_);
      }

      when AtkSelection {
        $to-parent = cast(AtkObject, $_);
        $!sel = $_;
        cast(AtkNoOpObject, $_);
      }

      when AtkTable {
        $to-parent = cast(AtkObject, $_);
        $!t = $_;
        cast(AtkNoOpObject, $_);
      }

      when AtkTableCell {
        $to-parent = cast(AtkObject, $_);
        $!tc = $_;
        cast(AtkNoOpObject, $_);
      }

      when AtkTableCell {
        $to-parent = cast(AtkObject, $_);
        $!tc = $_;
        cast(AtkNoOpObject, $_);
      }

      when AtkValue {
        $to-parent = cast(AtkObject, $_);
        $!v = $_;
        cast(AtkNoOpObject, $_);
      }

      when AtkWindow {
        $to-parent = cast(AtkObject, $_);
        $!win = $_;
        cast(AtkNoOpObject, $_);
      }

      default {
        $to-parent = $_;
        cast(AtkNoOpObject, $_);
      }
    }
    self.setAtkObject($to-parent);
    self."roleInit-$_"() for @no-op-object-composable-roles;
  }

  multi method new (AtkNoOpObjectAncestry $no-op, :$ref = True) {
    return Nil unless $no-op;

    my $o = self.bless(:$no-op);
    $o.ref if $ref;
    $o;
  }
  multi method new (GObject() $object) {
    my $no-op = atk_no_op_object_new($object);

    $no-op ?? self.bless(:$no-op) !! Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_no_op_object_get_type, $n, $t );
  }

}

### /usr/include/atk-1.0/atk/atknoopobject.h

sub atk_no_op_object_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_no_op_object_new (GObject $obj)
  returns AtkObject
  is native(atk)
  is export
{ * }

BEGIN {
  @no-op-object-composable-roles = ATK::NoOpObject.^roles.grep({
                                     my $n = .^name;
                                     [&&](
                                       $n.starts-with('ATK::Roles'),
                                       $n.contains('Signals').not
                                     )
                                   }).map( 'Atk' ~ *.^shortname )
}
