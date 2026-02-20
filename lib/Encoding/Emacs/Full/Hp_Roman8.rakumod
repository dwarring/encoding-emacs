use v6.d;
use Encoding::Emacs::MappingTable;

# Encoding used by Hewlet-Packard printer software
# Source: Emacs charset definition
# Map file: HP-ROMAN8

class Encoding::Emacs::Hp_Roman8 {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('HP-ROMAN8', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'hp-roman8'
    }
    
    method alternative-names(--> List) {
        my @alt-names = 'hp_roman8';
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
        'Encoding used by Hewlet-Packard printer software'
    }
}
