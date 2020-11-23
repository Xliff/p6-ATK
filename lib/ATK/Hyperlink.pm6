use v6.c;

use ATK::Raw::Types;
use ATK::Raw::Hyperlink;

use ATK::Object;

use GLib::Roles::Object;
use GLib::Roles::Signals::Generic;

our subset AtkHyperlinkAncestry is export of Mu
  where AtkHyperlink | AtkAction | GObject;

class ATK::Hyperlink {
  also does GLib::Roles::Object;
  also does GLib::Roles::Signals::Generic;

  has AtkHyperlink $!h is implementor;

  submethod BUILD (:$hyperlink) {
    self.setAtkHyperlink($hyperlink) if $hyperlink;
  }

  method setAtkHyperLink (AtkHyperlinkAncestry $_) {
    my $to-parent;

    $!h = do {
      when AtkHyperlink {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when AtkAction {
        $to-parent = cast(GObject, $_);
        $!a = $_;
        cast(AtkHyperlink, $_);
      }

      default {
        $to-parent = $_;
        cast(AtkHyperlink, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-AtkAction;
  }

  method ATK::Raw::Structs::AtkHyperlink
  { $!h }

  method new (AtkHyperlinkAncestry $hyperlink, :$ref = True) {
    return Nil unless $hyperlink;

    my $o = self.bless(:$hyperlink);
    $o.ref if $ref;
    $o;
  }

  # Is originally:
  # AtkHyperlink, gpointer --> void
  method link-activated {
    self.connect($!h, 'link-activated');
  }

  method get_end_index {
    atk_hyperlink_get_end_index($!h);
  }

  method get_n_anchors {
    atk_hyperlink_get_n_anchors($!h);
  }

  method get_object (gint $i) {
    my gint $ii = $i;
    my      $o  = atk_hyperlink_get_object($!h, $ii);

    $o ??
      ( $raw ?? $o !! ATK::Object.new($o) )
      !!
      Nil;
  }

  method get_start_index {
    atk_hyperlink_get_start_index($!h);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_hyperlink_get_type, $n, $t );
  }

  method get_uri (Int() $i) {
    my gint $ii = $i

    atk_hyperlink_get_uri($!h, $ii);
  }

  method is_inline {
    atk_hyperlink_is_inline($!h);
  }

  method is_selected_link {
    so atk_hyperlink_is_selected_link($!h);
  }

  method is_valid {
    so atk_hyperlink_is_valid($!h);
  }

}
