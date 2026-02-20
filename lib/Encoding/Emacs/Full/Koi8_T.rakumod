use v6.d;
use Encoding::Emacs::MappingTable;

# KOI8-T
# Source: Emacs charset definition
# Map file: KOI8-T

class Encoding::Emacs::Koi8_T {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('KOI8-T', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'koi8-t'
    }
    
    method alternative-names(--> List) {
        my @alt-names = 'koi8_t';
        return @alt-names;
    }
    
    method is-ascii-compatible(--> Bool) {
        True
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
        'KOI8-T'
    }
}
