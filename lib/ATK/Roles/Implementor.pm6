use v6.c;

use NativeCall;

use ATK::Raw::Types;

role ATK::Roles::Implementor {
  has AtkImplementorIface $!ai;

  method ATK::Raw::Definitions::AtkImplementorIface
  { $!ai }

  method roleInit-AtkImplementor {
    my \i = findProperImplementor(self.^attributes);
    $!ai  = cast( AtkImplementorIface, i.get_value(self) );
  }

  # cw: For now, holds single stubbed method for ref_accessible
  method ref_accessible (:$raw = False) {
    die "NYI!";
  }

  method implementor_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_implementor_get_type, $n, $t );
  }

}
