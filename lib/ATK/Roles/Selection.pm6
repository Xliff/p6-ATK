use v6.c;

use ATK::Raw::Types;
use ATK::Raw::Selection;

use ATK::Object;

use GLib::Roles::Signals::Generic;

role ATK::Roles::Selection {
  also does GLib::Roles::Signals::Generic;

  has AtkSelection $!sel;

  # Is originally:
  # AtkSelection, gpointer --> void
  method selection-changed {
    self.connect($!sel, 'selection-changed');
  }

  method add_selection (Int() $i) {
    my gint $ii = $i;

    so atk_selection_add_selection($!sel, $ii)
  }

  method clear_selection {
    so atk_selection_clear_selection($!sel);
  }

  method get_selection_count {
    atk_selection_get_selection_count($!sel);
  }

  method selection_get_type (::?CLASS:U: ) {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &atk_selection_get_type, $n, $t );
  }

  method is_child_selected (Int() $i) {
    my gint $ii = $i;

    so atk_selection_is_child_selected($!sel, $ii)
  }

  method ref_selection (Int() $i, :$raw = False) {
    my gint $ii = $i;
    my      $o  = atk_selection_ref_selection($!sel, $ii);

    $o ??
      ( $raw ?? $o !! ATK::Object.new($o, :!ref) )
      !!
      Nil;
  }

  method remove_selection (Int() $i) {
    my gint $ii = $i;

    atk_selection_remove_selection($!sel, $ii)
  }

  method select_all_selection {
    so atk_selection_select_all_selection($!sel);
  }

}

our subset AtkSelectionAncestry is export of Mu
  where AtkSelection | AtkObject;

class ATK::Selection is ATK::Object {
  also does ATK::Roles::Selection;

  submethod BUILD (:$selection) {
    self.setAtkSelection($selection) if $selection;
  }

  method setAtkSelection (AtkSelectionAncestry $_) {
    my $to-parent;

    $!sel = do {
      when AtkSelection {
        $to-parent = cast(AtkObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkSelection, $_);
      }
    }
    self.setAtkObject($to-parent);
  }

  method new (AtkSelectionAncestry $selection, :$ref = True) {
    return Nil unless $selection;

    my $o = self.bless(:$selection);
    $o.ref if $ref;
    $o;
  }

}
