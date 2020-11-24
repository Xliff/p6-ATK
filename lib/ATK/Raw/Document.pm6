use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use ATK::Raw::Definitions;
use ATK::Raw::Structs;

unit package ATK::Raw::Documents;

### /usr/include/atk-1.0/atk/atkdocument.h

sub atk_document_get_attribute_value (
  AtkDocument $document,
  Str         $attribute_name
)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_document_get_attributes (AtkDocument $document)
  returns AtkAttributeSet
  is native(atk)
  is export
{ * }

sub atk_document_get_current_page_number (AtkDocument $document)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_document_get_document (AtkDocument $document)
  returns Pointer
  is native(atk)
  is export
{ * }

sub atk_document_get_document_type (AtkDocument $document)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_document_get_locale (AtkDocument $document)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_document_get_page_count (AtkDocument $document)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_document_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_document_set_attribute_value (
  AtkDocument $document,
  Str         $attribute_name,
  Str         $attribute_value
)
  returns uint32
  is native(atk)
  is export
{ * }
