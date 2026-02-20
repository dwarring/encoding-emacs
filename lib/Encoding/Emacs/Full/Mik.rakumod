use v6.d;
use Encoding::Emacs::MappingTable;

# Bulgarian DOS codepage
# Source: Emacs charset definition
# Map file: MIK

class Encoding::Emacs::Mik {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('MIK', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'mik'
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
        'Bulgarian DOS codepage'
    }
}
