use v6.c;

unit package ATK::Raw::Exports;

our @atk-exports is export;

BEGIN {
  @atk-exports = <
    ATK::Raw::Definitions
    ATK::Raw::Enums
    ATK::Raw::Structs
  >;
}
