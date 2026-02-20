use v6.d;
use Encoding::Emacs::MappingTable;

# VSCII-2 (TCVN-5712 VN2)
# Source: Emacs charset definition
# Map file: VSCII-2

class Encoding::Emacs::Vscii_2 {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('VSCII-2', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'vscii-2'
    }
    
    method alternative-names(--> List) {
        my @alt-names = 'vscii_2';
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
        'VSCII-2 (TCVN-5712 VN2)'
    }
}
