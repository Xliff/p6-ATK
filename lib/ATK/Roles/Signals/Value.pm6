use v6.c;

use NativeCall;

use GLib::Raw::Definitions;

role ATK::Roles::Signals::Value {
  has %!signals-v;

  # AtkValue, gdouble, gchar, gpointer
  method connect-value-changed (
    $obj,
    $signal = 'value-changed',
    &handler?
  ) {
    my $hid;
    %!signals-v{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-value-changed($obj, $signal,
        -> $, $d, $s, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $d, $s, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-v{$signal}[0].tap(&handler) with &handler;
    %!signals-v{$signal}[0];
  }

}

# AtkValue, gdouble, gchar, gpointer
sub g-connect-value-changed(
  Pointer $app,
  Str     $name,
          &handler (Pointer, gdouble, Str, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
