use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Subs;
use GLib::Raw::Object;
use ATK::Raw::Definitions;
use ATK::Raw::Enums;

use GLib::Roles::Pointers;

unit package ATK::Raw::Structs;

class AtkAttribute      is repr<CStruct> is export does GLib::Roles::Pointers {
  has Str             $!name;
  has Str             $!value;

  method name is rw {
    Proxy.new:
      FETCH => -> $           { $!name      },
      STORE => -> $, Str() \s { $!name := s }
  }

  method value is rw {
    Proxy.new:
      FETCH => -> $           { $!value      },
      STORE => -> $, Str() \s { $!value := s }
  }
}

class AtkHyperlink      is repr<CStruct> is export does GLib::Roles::Pointers {
  HAS GObject         $.parent;
}

class AtkRelation       is repr<CStruct> is export does GLib::Roles::Pointers {
  HAS GObject         $.parent;

  has GPtrArray       $!target;
  has AtkRelationType $.relationship is rw;

  method target is rw {
    Proxy.new:
      FETCH => -> $                 { $!target      },
      STORE => -> $, GPtrArray() \t { $!target := t }
  }
}

class AtkRelationSet    is repr<CStruct> is export does GLib::Roles::Pointers {
  HAS GObject   $.parent;
  has GPtrArray $!relations;

  method relations is rw {
    Proxy.new:
      FETCH => -> $                 { $!relations      },
      STORE => -> $, GPtrArray() \r { $!relations := r }
  }
}

class AtkStateSet       is repr<CStruct> is export does GLib::Roles::Pointers {
  HAS GObject $.parent;
}

class AtkPropertyValue  is repr<CStruct> is export does GLib::Roles::Pointers {
  has Str    $.property-name is rw;
  HAS GValue $.old-value     is rw;
  HAS GValue $.new-value     is rw;

  # Compatibility
  method property_name is rw { $!property-name }
  method old_value     is rw { $!old-value     }
  method new_value     is rw { $!new-value     }
}

class AtkObject         is repr<CStruct> is export does GLib::Roles::Pointers {
  HAS GObject        $.parent;
  has Str            $!description;
  has Str            $!name;
  has AtkObject      $!accessible-parent;
  has AtkRole        $.role               is rw;
  has AtkRelationSet $!relation-set;
  has AtkLayer       $.layer              is rw;

  method description is rw {
    Proxy.new:
      FETCH => -> $           { $!description      },
      STORE => -> $, Str() \s { $!description := s };
  }

  method name is rw {
    Proxy.new:
      FETCH => -> $           { $!name      },
      STORE => -> $, Str() \s { $!name := s };
  }

  method accessible-parent is also<accessible_parent> is rw {
    Proxy.new:
      FETCH => -> $                 { $!accessible-parent      },
      STORE => -> $, AtkObject() \a { $!accessible-parent := a };
  }

  method relation-set is also<relation_set> is rw {
    Proxy.new:
      FETCH => -> $                      { $!relation-set      },
      STORE => -> $, AtkRelationSet() \r { $!relation-set := r };
  }
}

# Not a struct, but has method definitions, so...
class AtkImplementor    is repr<CPointer> does GLib::Roles::Pointers is export {
  method get_type {
    state ($n, $t);

    unstable_get_type(self.^name, &atk_implementor_get_type, $n, $t );
  }

  method ref_accessible {
    atk_implementor_ref_accessible(self);
  }

  sub atk_implementor_get_type ()
    returns GType
    is native(atk)
    is export
  { * }

  sub atk_implementor_ref_accessible (AtkImplementor $implementor)
    returns AtkObject
    is native(atk)
    is export
  { * }
}

# Opaque
class AtkRange          is repr<CStruct> does GLib::Roles::Pointers is export {
  # Stripped from atkrange.c
  has gdouble $!lower;
  has gdouble $!upper;
  has Str     $!description;
}
