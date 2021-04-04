use v6;

use GLib::Raw::Exports;
use ATK::Raw::Exports;

unit package ATK::Raw::Types;

need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Exceptions;
need GLib::Raw::Object;
need GLib::Raw::Structs;
need GLib::Raw::Subs;
need GLib::Raw::Struct_Subs;
need GLib::Roles::Pointers;
need ATK::Raw::Enums;
need ATK::Raw::Definitions;
need ATK::Raw::Structs;

BEGIN {
  glib-re-export($_) for |@glib-exports,
                         |@atk-exports;
}
