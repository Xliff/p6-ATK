use v6.c;

use NativeCall;

use ATK::Raw::Types;

use ATK::Object;

use GLib::Roles::Object;

our subset AtkGObjectAccessibleAncestry is export of Mu
  where AtkGObjectAccessible | AtkObject;

class ATK::GObjectAccessible is ATK::Object {
  has AtkGObjectAccessible $!goa;

  submethod BUILD (:$gobject-access) {
    self.setAtkGObjectAccessible($gobject-access) if $gobject-access;
  }

  method setAtkGObjectAccessible (AtkGObjectAccessibleAncestry $_) {
    my $to-parent;

    $!goa = do {
      when AtkGObjectAccessible {
        $to-parent = cast(AtkObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkObject, $_);
      }
    }
    self.setAtkObject($to-parent);
  }

  method ATK::Raw::Definitions::AtkGObjectAccessible
  { $!goa }

  method new (AtkGObjectAccessibleAncestry $gobject-access, :$ref = True) {
    return Nil unless $gobject-access;

    my $o = self.bless(:$gobject-access);
    $o.ref if $ref;
    $o;
  }

  method for_object (ATK::GObjectAccessible:U: GObject() $obj, :$raw = False) {
    my $ao = atk_gobject_accessible_for_object($obj);

    $ao ??
      ( $raw ?? $ao !! ATK::Object.new($ao, :!ref) )
      !!
      Nil;
  }

  method get_object (:$raw = False) {
    my $o = atk_gobject_accessible_get_object($!goa);

    $o ??
      ( $raw ?? $o !! GLib::Roles::Object.new-object-obj($o, :!ref) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(self.^name, &atk_gobject_accessible_get_type, $n, $t);
  }

}


### /usr/include/atk-1.0/atk/atkgobjectaccessible.h

sub atk_gobject_accessible_for_object (GObject $obj)
  returns AtkObject
  is native(atk)
  is export
{ * }

sub atk_gobject_accessible_get_object (AtkGObjectAccessible $obj)
  returns GObject
  is native(atk)
  is export
{ * }

sub atk_gobject_accessible_get_type ()
  returns GType
  is native(atk)
  is export
{ * }
