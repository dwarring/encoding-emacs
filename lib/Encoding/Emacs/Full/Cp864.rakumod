use v6.d;
use Encoding::Emacs::MappingTable;

# CP864 (PC Arabic)
# Source: Emacs charset definition
# Map file: IBM864

class Encoding::Emacs::Cp864 {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('IBM864', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'cp864'
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
        'CP864 (PC Arabic)'
    }
}
