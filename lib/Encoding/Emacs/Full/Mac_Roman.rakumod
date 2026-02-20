use v6.d;
use Encoding::Emacs::MappingTable;

# Mac Roman charset
# Source: Emacs charset definition
# Map file: MACINTOSH

class Encoding::Emacs::Mac_Roman {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('MACINTOSH', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'mac-roman'
    }
    
    method alternative-names(--> List) {
        my @alt-names = 'mac_roman';
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
        'Mac Roman charset'
    }
}
