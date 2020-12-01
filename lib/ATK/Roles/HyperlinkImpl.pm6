use v6.c;

use NativeCall;

use ATK::Raw::Types;

use ATK::Hyperlink;

role ATK::Roles::HyperlinkImpl {
  has AtkHyperlinkImpl $!hli;

  method roleInit-AtkHyperlinkImpl {
    return if $!hli;

    my \i = findProperImplementor(self.^attributes);
    $!hli = cast( AtkHyperlinkImpl, i.get_value(self) );
  }

  method get_hyperlink (:$raw = False) {
    my $h = atk_hyperlink_impl_get_hyperlink($!hli);

    $h ??
      ( $raw ?? $h !! ATK::Hyperlink.new($h) )
      !!
      Nil;
  }

  method hyperlinkimpl_get_type (::?CLASS:U: ) {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &atk_hyperlink_impl_get_type, $n, $t );
  }

}

our subset AtkHyperlinkImplAncestry is export of Mu
  where AtkHyperlinkImpl | AtkObject;

class ATK::HyperlinkImpl is ATK::Object {
  also does ATK::Roles::HyperlinkImpl;

  submethod BUILD (:$hyperlinkimpl) {
    self.setAtkHyperlinkImpl($hyperlinkimpl) if $hyperlinkimpl;
  }

  method setAtkHyperlinkImpl (AtkHyperlinkImplAncestry $_) {
    my $to-parent;

    $!hli = do {
      when AtkHyperlinkImpl {
        $to-parent = cast(AtkObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkHyperlinkImpl, $_);
      }
    }
    self.setAtkObject($to-parent);
  }

  method new (AtkHyperlinkImplAncestry $hyperlinkimpl, :$ref = True) {
    return Nil unless $hyperlinkimpl;

    my $o = self.bless(:$hyperlinkimpl);
    $o.ref if $ref;
    $o;
  }

}

### /usr/include/atk-1.0/atk/atkhyperlinkimpl.h

sub atk_hyperlink_impl_get_hyperlink (AtkHyperlinkImpl $impl)
  returns AtkHyperlink
  is native(atk)
  is export
{ * }

sub atk_hyperlink_impl_get_type ()
  returns GType
  is native(atk)
  is export
{ * }
