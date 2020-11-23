use v6.c;

use NativeCall;

use ATK::Raw::Types;

role ATK::Roles::Signals::Component {
  has %!signals-c;

  # AtkComponent, AtkRectangle, gpointer
  method connect-bounds-changed (
    $obj,
    $signal = 'bounds-changed',
    &handler?
  ) {
    my $hid;
    %!signals-c{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-bounds-changed($obj, $signal,
        -> $, $ar, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $ar, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-c{$signal}[0].tap(&handler) with &handler;
    %!signals-c{$signal}[0];
  }

}

# AtkComponent, AtkRectangle, gpointer
sub g-connect-bounds-changed(
  Pointer $app,
  Str $name,
  &handler (Pointer, AtkRectangle, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
