use v6.c;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;

use GLib::Roles::Pointers;

unit package ATK::Raw::Definitions;

# Forced compile count
constant forced = 2;

# Libs
constant atk is export = 'atk-1.0';

# Aliases
constant AtkAttributeSet is export = GSList;
constant AtkState        is export = uint64;

# Pointers
class AtkAction        is repr<CPointer> does GLib::Roles::Pointers is export { }
class AtkComponent     is repr<CPointer> does GLib::Roles::Pointers is export { }
class AtkDocument      is repr<CPointer> does GLib::Roles::Pointers is export { }
class AtkImage         is repr<CPointer> does GLib::Roles::Pointers is export { }
class AtkEditableText  is repr<CPointer> does GLib::Roles::Pointers is export { }
class AtkHyperlinkImpl is repr<CPointer> does GLib::Roles::Pointers is export { }
class AtkSelection     is repr<CPointer> does GLib::Roles::Pointers is export { }
class AtkTable         is repr<CPointer> does GLib::Roles::Pointers is export { }
class AtkTableCell     is repr<CPointer> does GLib::Roles::Pointers is export { }
class AtkText          is repr<CPointer> does GLib::Roles::Pointers is export { }
class AtkValue         is repr<CPointer> does GLib::Roles::Pointers is export { }
class AtkWindow        is repr<CPointer> does GLib::Roles::Pointers is export { }
