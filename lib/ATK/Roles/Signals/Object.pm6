use v6.c;

use NativeCall;

use ATK::Raw::Types;

role ATK::Roles::Signals::Object {
  has %!signals-ao;

  # AtkObject, gpointer, gpointer
  method connect-active-descendant-changed (
    $obj,
    $signal = 'active-descendant-changed',
    &handler?
  ) {
    my $hid;
    %!signals-ao{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-active-descendant-changed($obj, $signal,
        -> $, $g, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $g, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ao{$signal}[0].tap(&handler) with &handler;
    %!signals-ao{$signal}[0];
  }

  # AtkObject, guint, gpointer, gpointer
  method connect-children-changed (
    $obj,
    $signal = 'children-changed',
    &handler?
  ) {
    my $hid;
    %!signals-ao{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-children-changed($obj, $signal,
        -> $, $g1, $g2, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $g1, $g2, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ao{$signal}[0].tap(&handler) with &handler;
    %!signals-ao{$signal}[0];
  }

  # AtkObject, gboolean, gpointer
  method connect-focus-event (
    $obj,
    $signal = 'focus-event',
    &handler?
  ) {
    my $hid;
    %!signals-ao{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-focus-event($obj, $signal,
        -> $, $g, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $g, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ao{$signal}[0].tap(&handler) with &handler;
    %!signals-ao{$signal}[0];
  }

  # AtkObject, gpointer, gpointer
  method connect-property-change (
    $obj,
    $signal = 'property-change',
    &handler?
  ) {
    my $hid;
    %!signals-ao{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-property-change($obj, $signal,
        -> $, $g, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $g, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ao{$signal}[0].tap(&handler) with &handler;
    %!signals-ao{$signal}[0];
  }

  # AtkObject, Str, gboolean, gpointer
  method connect-state-change (
    $obj,
    $signal = 'state-change',
    &handler?
  ) {
    my $hid;
    %!signals-ao{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-state-change($obj, $signal,
        -> $, $g1, $g2, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $g1, $g2, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ao{$signal}[0].tap(&handler) with &handler;
    %!signals-ao{$signal}[0];
  }

}

# AtkObject, gpointer, gpointer
sub g-connect-active-descendant-changed(
  Pointer $app,
  Str $name,
  &handler (Pointer, gpointer, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# AtkObject, guint, gpointer, gpointer
sub g-connect-children-changed(
  Pointer $app,
  Str $name,
  &handler (Pointer, guint, gpointer, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# AtkObject, gboolean, gpointer
sub g-connect-focus-event(
  Pointer $app,
  Str $name,
  &handler (Pointer, gboolean, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# AtkObject, gpointer, gpointer
sub g-connect-property-change(
  Pointer $app,
  Str $name,
  &handler (Pointer, gpointer, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# AtkObject, Str, gboolean, gpointer
sub g-connect-state-change(
  Pointer $app,
  Str $name,
  &handler (Pointer, Str, gboolean, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
