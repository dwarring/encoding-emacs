use v6.d;
use Encoding::Emacs::MappingTable;

# VSCII1.1 (TCVN-5712 VN1)
# Source: Emacs charset definition
# Map file: VSCII

class Encoding::Emacs::Vscii {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('VSCII', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'vscii'
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
        'VSCII1.1 (TCVN-5712 VN1)'
    }
}
