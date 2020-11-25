use v6.c;

use Test;

use ATK::Raw::Types;

use ATK::State;
use ATK::StateSet;

sub test-state-set {
  subtest 'State set', {
    my $ss1 = ATK::StateSet.new;

    ok  $ss1.is-empty,                                                   'New state set is empty';
    ok  $ss1.add-state(ATK_STATE_ACTIVE),                                'Adding ATK_STATE_ACTIVE succeeded';
    nok $ss1.is-empty,                                                   'New state set is no longer empty';
    nok $ss1.add-state(ATK_STATE_ACTIVE),                                'Adding ATK_STATE_ACTIVE did NOT succeed';

    my @states = (ATK_STATE_ACTIVE, ATK_STATE_VISIBLE, ATK_STATE_BUSY);
    $ss1.add-states(@states);

    ok  $ss1.contains-state($_),                                         "State set contains $_"
      for @states;
    nok $ss1.contains-state(ATK_STATE_VERTICAL),                         'State set does NOT contain ATK_STATE_VERTICAL';

    $ss1.remove-state(ATK_STATE_BUSY);
    nok $ss1.contains-state(ATK_STATE_BUSY),                             'State set no longer contains ATK_STATE_BUSY';
    ok  $ss1.contains-state(ATK_STATE_VISIBLE),                          'State set still contains ATK_STATE_VISIBLE';

    nok $ss1.contains-states(@states),                                   'Full state check on @states fails';
    ok  $ss1.contains-states( @states.head(2) ),                         'Constrained state check succeeds';

    @states = (ATK_STATE_SINGLE_LINE, ATK_STATE_VISIBLE, ATK_STATE_VERTICAL);
    (my $ss2 = ATK::StateSet.new).add-states(@states);
    my $ss3 = $ss1.and-sets($ss2);
    ok  $ss3.contains-state(ATK_STATE_VISIBLE),                          'State Set 3 contains ATK_STATE_VISIBLE';
    nok $ss3.contains-state(ATK_STATE_BUSY),                             'State Set 3 does NOT contain ATK_STATE_BUSY';

    $ss3.unref;
    $ss1.remove-state(ATK_STATE_VISIBLE);
    $ss3 = $ss1.and-sets($ss2);
    nok $ss3,                                                            'State Set 3 should now be Nil';

    $ss3 = $ss1.or-sets($ss2);
    ok  $ss3.contains-state(ATK_STATE_VISIBLE),                          'State Set 3 contains ATK_STATE_VISIBLE after OR';
    nok $ss3.contains-state(ATK_STATE_INVALID),                          'State Set 3 does NOT contain ATK_STATE_INVALID';
    $ss3.unref;

    $ss1.add-state(ATK_STATE_VISIBLE);
    $ss3 = $ss1.xor-sets($ss2);
    nok $ss3.contains-state(ATK_STATE_VISIBLE),                          'State Set 3 does NOT contain ATK_STATE_VISIBLE after XOR';
    ok  $ss3.contains-state(ATK_STATE_ACTIVE),                           'State Set 3 contains ATK_STATE_ACTIVE';

    $ss1.clear-states;
    nok $ss1.contains-state(ATK_STATE_ACTIVE),                           'State Set 1 does NOT contain ATK_STATE_ACTIVE after clear';
  }

}

sub test-state {
  subtest 'State', {
    is  ATK::State.get-name(ATK_STATE_VISIBLE), 'visible',               'Name returned for ATK_STATE_VISIBLE is "visible"';
    is  ATK::State.get-name(ATK_STATE_MODAL),   'modal',                 'Name returned for ATK_STATE_MODAL is "modal"';
    is  ATK::State.for-name('focused'),         ATK_STATE_FOCUSED,       'Value returned for "focused" is ATK_STATE_FOCUSED';

    my $type1         = ATK::State.register('test-state');
    my $invalid-state = AtkStateTypeEnum.enums.values.max + 2;
    is  ATK::State.get-name($type1),            'test-state',            'Registered value matches given name';
    is  ATK::State.for-name('test-state'),      $type1,                  'Retrieved value for new name matches registered value';
    is  ATK::State.for-name('TEST_STATE'),      ATK_STATE_INVALID,       'Received ATK_STATE_INVALID for unregistered name';
    nok ATK::State.get-name($invalid-state),                             'No name retrieved for invalid state value';
  }
}

test-state-set;
test-state;
