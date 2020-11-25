use v6.c;

use ATK::Raw::Types;
use ATK::Raw::Action;

use GLib::Roles::Object;

role ATK::Roles::Action {
  has AtkAction $!a;

  method ATK::Raw::Definitions::AtkAction
  { $!a }

  method roleInit-AtkAction {
    return Nil if $!a;

    my \i = findProperImplementor(self.^attributes);
    $!a   = cast( AtkAction, i.get_value(self) );
  }

  method do_action (Int() $i) {
    my gint $ii = $i;

    so atk_action_do_action($!a, $ii);
  }

  method get_description (Int() $i) {
    my gint $ii = $i;

    atk_action_get_description($!a, $ii);
  }

  method get_keybinding (Int() $i) {
    my gint $ii = $i;

    atk_action_get_keybinding($!a, $ii);
  }

  method get_localized_name (Int() $i) {
    my gint $ii = $i;

    atk_action_get_localized_name($!a, $ii);
  }

  method get_n_actions {
    atk_action_get_n_actions($!a);
  }

  method get_name (Int() $i) {
    my gint $ii = $i;

    atk_action_get_name($!a, $ii);
  }

  method action_get_type (::?CLASS:U: ) {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &atk_action_get_type, $n, $t );
  }

  method set_description (Int() $i, Str() $desc) {
    my gint $ii = $i;

    atk_action_set_description($!a, $ii, $desc);
  }

}

our subset AtkActionAncestry is export of Mu
  where AtkAction | GObject;

class ATK::Action {
  also does GLib::Roles::Object;
  also does ATK::Roles::Action;

  submethod BUILD (:$action) {
    self.setAtkAction($action) if $action;
  }

  method setAtkAction (AtkActionAncestry $_) {
    my $to-parent;

    $!a = do {
      when AtkAction {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkAction, $_);
      }
    }
    self!setObject($to-parent);
  }

  method new (AtkActionAncestry $action, :$ref = True) {
    return Nil unless $action;

    my $o = self.bless(:$action);
    $o.ref if $ref;
    $o;
  }

}
