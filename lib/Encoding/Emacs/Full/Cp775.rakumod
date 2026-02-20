use v6.d;
use Encoding::Emacs::MappingTable;

# CP775 (PC Baltic)
# Source: Emacs charset definition
# Map file: CP775

class Encoding::Emacs::Cp775 {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('CP775', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'cp775'
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
        'CP775 (PC Baltic)'
    }
}
