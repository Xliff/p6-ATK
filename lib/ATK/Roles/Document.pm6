use v6.c;

use ATK::Raw::Types;
use ATK::Raw::Document;

use ATK::Object;

use GLib::Roles::Signals::Generic;

role ATK::Roles::Document {
  also does GLib::Roles::Signals::Generic;

  has AtkDocument $!d;

  method ATK::Raw::Definitions::AtkDocument
  { $!d }

  method roleInit-AtkDocument {
    return if $!d;

    my \i = findProperImplementor(self.^attributes);
    $!d   = cast( AtkDocument, i.get_value(self) );
  }

  # Is originally:
  # AtkDocument, gpointer --> void
  method load-complete {
    self.connect($!d, 'load-complete');
  }

  # Is originally:
  # AtkDocument, gpointer --> void
  method load-stopped {
    self.connect($!d, 'load-stopped');
  }

  # Is originally:
  # AtkDocument, gint, gpointer --> void
  method page-changed {
    self.connect-int($!d, 'page-changed');
  }

  # Is originally:
  # AtkDocument, gpointer --> void
  method reload {
    self.connect($!d, 'reload');
  }

  method get_attribute_value (Str() $attribute_name) {
    atk_document_get_attribute_value($!d, $attribute_name);
  }

  method get_attributes (:$glist = False, :$raw = False) {
    my $as = atk_document_get_attributes($!d);

    return Nil unless $as;
    return $as if $glist && $raw;

    $as = GLib::GList.new($as) but GLib::Roles::ListData[AtkAttribute];
    return $as if $glist;

    $as.Array;
  }

  method get_current_page_number {
    atk_document_get_current_page_number($!d);
  }

  method get_document {
    atk_document_get_document($!d);
  }

  method get_document_type {
    atk_document_get_document_type($!d);
  }

  method get_locale {
    atk_document_get_locale($!d);
  }

  method get_page_count {
    atk_document_get_page_count($!d);
  }

  method document_get_type (::?CLASS:U: ) {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &atk_document_get_type, $n, $t );
  }

  method set_attribute_value (Str() $attribute_name, Str() $attribute_value) {
    so atk_document_set_attribute_value(
      $!d,
      $attribute_name,
      $attribute_value
    );
  }

}

our subset AtkDocumentAncestry is export of Mu
  where AtkDocument | AtkObjectAncestry;

class ATK::Document is ATK::Object {
  also does ATK::Roles::Document;

  submethod BUILD (:$document) {
    self.setAtkDocument($document) if $document;
  }

  method setAtkDocument (AtkDocumentAncestry $_) {
    my $to-parent;

    $!d = do {
      when AtkDocument {
        $to-parent = cast(AtkObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(AtkDocument, $_);
      }
    }
    self.setAtkObject($to-parent);
  }

  method new (AtkDocumentAncestry $document, :$ref = True) {
    return Nil unless $document;

    my $o = self.bless(:$document);
    $o.ref if $ref;
    $o;
  }

  method get_type {
    ATK::Document.document_get_type;
  }

}
