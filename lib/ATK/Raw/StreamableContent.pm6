use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use ATK::Raw::Definitions;

unit package ATK::Raw::StreamableContent;

### /usr/include/atk-1.0/atk/atkstreamablecontent.h

sub atk_streamable_content_get_mime_type (
  AtkStreamableContent $streamable,
  gint                 $i
)
  returns Str
  is native(atk)
  is export
{ * }

sub atk_streamable_content_get_n_mime_types (AtkStreamableContent $streamable)
  returns gint
  is native(atk)
  is export
{ * }

sub atk_streamable_content_get_stream (
  AtkStreamableContent $streamable,
  Str                  $mime_type
)
  returns GIOChannel
  is native(atk)
  is export
{ * }

sub atk_streamable_content_get_type ()
  returns GType
  is native(atk)
  is export
{ * }

sub atk_streamable_content_get_uri (
  AtkStreamableContent $streamable,
  Str                  $mime_type
)
  returns Str
  is native(atk)
  is export
{ * }
