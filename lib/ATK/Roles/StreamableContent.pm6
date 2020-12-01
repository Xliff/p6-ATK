use v6.c;

use ATK::Raw::Types;
use ATK::Raw::StreamableContent;

use GLib::IOChannel;
use ATK::Object;

role ATK::Roles::StreamableContent {
  has AtkStreamableContent $!sc;

  method roleInit-AtkStreamableContent {
    return if $!sc;

    my \i = findProperImplementor( self.^attributes );
    $!sc  = cast( AtkStreamableContent, i.get_value(self) );
  }

  method ATK::Raw::Definitions::AtkStreamableContent
  { $!sc }

  method get_mime_type (Int() $i) {
    my gint $ii = $i;

    atk_streamable_content_get_mime_type($!sc, $ii);
  }

  method get_n_mime_types {
    atk_streamable_content_get_n_mime_types($!sc);
  }

  method get_stream (Str() $mime_type, :$raw = False) {
    my $ioc = atk_streamable_content_get_stream($!sc, $mime_type);

    $ioc ??
      ( $raw ?? $ioc !! GLib::IOChannel.new($ioc) )
      !!
      Nil;
  }

  method streamablecontent_get_type (::?CLASS:U: ) {
    state ($n, $t);

    unstable_get_type(
      ::?CLASS.^name,
      &atk_streamable_content_get_type,
      $n,
      $t
    );
  }

  method get_uri (Str() $mime_type) {
    atk_streamable_content_get_uri($!sc, $mime_type);
  }
}

our subset AtkStreamableContentAncestry is export of Mu
  where AtkStreamableContent | AtkObject;

class ATK::StreamableContent is ATK::Object {
  also does ATK::Roles::StreamableContent;

  submethod BUILD (:$streamable-content) {
    self.setAtkStreamableContent($streamable-content) if $streamable-content;
  }

  method setAtkStreamableContent (AtkStreamableContentAncestry $_) {
    my $to-parent;

    $!sc = do {
      when AtkStreamableContent {
        $to-parent = cast(AtkObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkStreamableContent, $_);
      }
    }
    self.setAtkObject($to-parent);
  }

  method new (AtkStreamableContentAncestry $streamable-content, :$ref = True) {
    return Nil unless $streamable-content;

    my $o = self.bless( :$streamable-content );
    $o.ref if $ref;
    $o;
  }

}
