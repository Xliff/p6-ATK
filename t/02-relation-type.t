use v6.c;

use Test;

use ATK::Raw::Types;

use ATK::Object;
use ATK::Relation;

constant ART = ATK::Relation::Type;

sub test-relation {

  subtest 'Relation', {
    is  ART.get-name(ATK_RELATION_LABEL_FOR),     'label-for',                'Received proper name for ATK_RELATION_LABEL_FOR';
    is  ART.get-name(ATK_RELATION_NODE_CHILD_OF), 'node-child-of',            'Received proper name for ATK_RELATION_NODE_CHILD_OF';
    is  ART.get-name(ATK_RELATION_EMBEDS),        'embeds',                   'Received proper name for ATK_RELATION_EMBEDS';
    is  ART.for-name('embedded-by'),              ATK_RELATION_EMBEDDED_BY,   'Received proper AtkRelationType value for "embedded-by"';
    is  ART.for-name('controlled-by'),            ATK_RELATION_CONTROLLED_BY, 'Received proper AtkRelationType value for "controlled-by"';

    my $name1   = 'test-state';
    my $type1   = ATK::Relation::Type.register($name1);
    my $invalid = AtkRelationTypeEnum.enums.values.max + 2;
    is  ART.get-name($type1),                     $name1,                     "Received proper name for newly registered '{ $name1 }'";
    is  ART.for-name($name1),                     $type1,                     "Received proper AtkRelationType value for '{ $name1 }'";
    is  ART.for-name('TEST_STATE'),               ATK_RELATION_NULL,          'Received ATK_RELATION_NULL for name "TEST_STATE"';
    nok ART.get-name($invalid),                                               'Name for an invalid AtkRelationType returned a Nil';

    my $obj = ATK::Object.new;
    ok  $obj.add-relationship(ATK_RELATION_LABEL_FOR, $obj),                  'Can add a self-relationship on an ATK::Object';

    ok  (my $set = $obj.ref-relation-set),                                    'Can get a ref-count-inc\'d relation set from an ATK::Object';
    is  $set.elems,                               1,                          'Number of relationships in relation set is 1';
    ok  ( my $rel = $set.get-relation(0) ),                                   'First relationship in set is defined';
    is  $rel.relation-type,                       ATK_RELATION_LABEL_FOR,     'First relationship type is ATK_RELATION_LABEL_FOR';
    is  +$rel.get-target(:garray)[0],             +$obj,                      'Relationship target for object is itself';

    my $ret = $obj.remove-relationship(ATK_RELATION_LABEL_FOR, $obj);
    ok  $ret,                                                                 'Relationship removed successfully';
    ok  ($set = $obj.ref-relation-set),                                       'Can get a ref-count-inc\'d relation set from an ATK::Object';
    is  $set.elems,                               0,                          'Number of relationships in relation set is 0';
  }

}

test-relation;
