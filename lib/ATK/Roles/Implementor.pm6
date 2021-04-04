use v6.c;

use NativeCall;

use ATK::Raw::Types;

role ATK::Roles::Implementor {
  has AtkImplementorIface $!aii;

  method ATK::Raw::Definitions::AtkImplementorIface
  { $!aii }

  # cw: For now, holds single stubbed method for ref_accessible
  method ref_accessible (:$raw = False) {
    die "NYI!";
  }

  method implementor_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_implementor_get_type, $n, $t );
  }

}

sub atk_implementor_ref_accessible (AtkImplementor $implementor)
  returns AtkObject
  is export
  is native(atk)
{ * }

sub atk_implementor_get_type ()
  returns GType
  is export
  is native(atk)
{ * }
