use v6.d;
use Encoding::Emacs::MappingTable;

# VISCII1.1
# Source: Emacs charset definition
# Map file: VISCII

class Encoding::Emacs::Viscii {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('VISCII', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'viscii'
    }
    
    method alternative-names(--> List) {
        my @alt-names;
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
        'VISCII1.1'
    }
}
