use v6.d;
use Encoding::Emacs::MappingTable;

# CP860 (MS-DOS Portuguese)
# Source: Emacs charset definition
# Map file: IBM860

class Encoding::Emacs::Cp860 {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('IBM860', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'cp860'
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
        'CP860 (MS-DOS Portuguese)'
    }
}
