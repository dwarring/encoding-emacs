use v6.d;
use Encoding::Emacs::MappingTable;

# ISO/IEC 8859/15
# Source: Emacs iso-charset definition
# Map file: 8859-15

class Encoding::Emacs::Iso_8859_15 {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('8859-15', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'iso-8859-15'
    }
    
    method alternative-names(--> List) {
        my @alt-names = 'latin-iso8859-15', 'iso_8859_15';
        return @alt-names;
    }
    
    method is-ascii-compatible(--> Bool) {
        False
    }
    
method decoder(*%opts) {
    my $mapping-table = self!get-mapping();
    class {
        has $.mapping;
        
        method decode(Blob $bytes) {
            $!mapping.decode-bytes($bytes);
        }
    }.new(mapping => $mapping-table);
}

    
method encoder(*%opts) {
    my $mapping-table = self!get-mapping();
    class {
        has $.mapping;
        
        method encode(Str $string, :$replacement = '?') {
            $!mapping.encode-string($string, :$replacement);
        }
    }.new(mapping => $mapping-table);
}

    
    method description(--> Str) {
        'ISO/IEC 8859/15'
    }
}
