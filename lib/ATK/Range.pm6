use v6.c;

use ATK::Raw::Types;
use ATK::Raw::Range;

class ATK::Range {
  has AtkRange $!r;

  submethod BUILD (:$range) {
    $!r = $range;
  }

  method ATK::Raw::Structs::AtkRange
  { $!r }

  multi method new (AtkRange $range) {
    $range ?? self.bless( :$range ) !! Nil;
  }
  multi method new (
    Num() $lower_limit,
    Num() $upper_limit,
    Str() $description
  ) {
    my gdouble ($ll, $ul) = ($lower_limit, $upper_limit);
    my          $range    = atk_range_new($ll, $ul, $description);

    $range ?? self.bless( :$range ) !! Nil;
  }

  method copy (:$raw = False) {
    my $r = atk_range_copy($!r);

    $r ??
      ( $raw ?? $r !! ATK::Range.new($r) )
      !!
      Nil;
  }

  method free {
    atk_range_free($!r);
  }

  method get_description {
    atk_range_get_description($!r);
  }

  method get_lower_limit {
    atk_range_get_lower_limit($!r);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &atk_range_get_type, $n, $t );
  }

  method get_upper_limit {
    atk_range_get_upper_limit($!r);
  }

}
