use v6.d;
use Encoding::Emacs::MappingTable;

# GEORGIAN-PS
# Source: Emacs charset definition
# Map file: KA-PS

class Encoding::Emacs::Georgian_Ps {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('KA-PS', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'georgian-ps'
    }
    
    method alternative-names(--> List) {
        my @alt-names = 'georgian_ps';
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
        'GEORGIAN-PS'
    }
}
