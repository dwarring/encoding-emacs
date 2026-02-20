use v6.d;
use Encoding::Emacs::MappingTable;

# CP852 (MS-DOS Latin-2)
# Source: Emacs charset definition
# Map file: IBM852

class Encoding::Emacs::Cp852 {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('IBM852', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'cp852'
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
        'CP852 (MS-DOS Latin-2)'
    }
}
