use v6.c;

use NativeCall;

use ATK::Raw::Types;

use GLib::Roles::Signals::Generic;

role ATK::Roles::Signals::Text {
  also does GLib::Roles::Signals::Generic;
  
  has %!signals-text;

  # AtkText, gint, gint, Str, gpointer
  method connect-text-action (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-text{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-text-action($obj, $signal,
        -> $, $g1, $g2, $s, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $g1, $g2, $s, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-text{$signal}[0].tap(&handler) with &handler;
    %!signals-text{$signal}[0];
  }

}

# AtkText, gint, gint, gchar, gpointer
sub g-connect-text-action (
  Pointer $app,
  Str     $name,
          &handler (Pointer, gint, gint, Str, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
