use v6.d;
use Encoding::Emacs::MappingTable;

# CP855 (IBM Cyrillic)
# Source: Emacs charset definition
# Map file: IBM855

class Encoding::Emacs::Cp855 {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('IBM855', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'cp855'
    }
    
    method alternative-names(--> List) {
        my @alt-names;
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
        'CP855 (IBM Cyrillic)'
    }
}
