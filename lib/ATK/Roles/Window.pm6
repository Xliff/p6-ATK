use v6.c;

use ATK::Raw::Types;
use ATK::Raw::Definitions;

use ATK::Object;

use GLib::Roles::Signals::Generic;

role ATK::Roles::Window {
  also does GLib::Roles::Signals::Generic;

  has AtkWindow $!win;

  method ATK::Raw::Definitions::AtkWindow
  { $!win }

  method roleInit-AtkWindow {
    return Nil if $!win;

    my \i = findProperImplementor(self.^attributes);
    $!win = cast( AtkWindow, i.get_value(self) );
  }

  # Is originally:
  # AtkWindow, gpointer --> void
  method activate {
    self.connect($!win, 'activate');
  }

  # Is originally:
  # AtkWindow, gpointer --> void
  method create {
    self.connect($!win, 'create');
  }

  # Is originally:
  # AtkWindow, gpointer --> void
  method deactivate {
    self.connect($!win, 'deactivate');
  }

  # Is originally:
  # AtkWindow, gpointer --> void
  method destroy {
    self.connect($!win, 'destroy');
  }

  # Is originally:
  # AtkWindow, gpointer --> void
  method maximize {
    self.connect($!win, 'maximize');
  }

  # Is originally:
  # AtkWindow, gpointer --> void
  method minimize {
    self.connect($!win, 'minimize');
  }

  # Is originally:
  # AtkWindow, gpointer --> void
  method move {
    self.connect($!win, 'move');
  }

  # Is originally:
  # AtkWindow, gpointer --> void
  method resize {
    self.connect($!win, 'resize');
  }

  # Is originally:
  # AtkWindow, gpointer --> void
  method restore {
    self.connect($!win, 'restore');
  }

}

our subset AtkWindowAncestry is export of Mu
  where AtkWindow | AtkObject;

class ATK::Window is ATK::Object {
  also does ATK::Roles::Window;

  submethod BUILD (:$window) {
    self.setAtkWindow($window) if $window;
  }

  method setAtkWindow (AtkWindowAncestry $_) {
    my $to-parent;

    $!win = do {
      when AtkWindow {
        $to-parent = cast(AtkObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkWindow, $_);
      }
    }
    self.setAtkObject($to-parent);
  }

  method new (AtkWindowAncestry $window, :$ref = True) {
    return Nil unless $window;

    my $o = self.bless(:$window);
    $o.ref if $ref;
    $o;
  }

}
