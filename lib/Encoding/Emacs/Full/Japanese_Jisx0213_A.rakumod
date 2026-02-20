use v6.d;
use Encoding::Emacs::MappingTable;

# JISX0213.2004 adds these characters to JISX0213.2000.
# Source: Emacs charset definition
# Map file: JISX213A

class Encoding::Emacs::Japanese_Jisx0213_A {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('JISX213A', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'japanese-jisx0213-a'
    }
    
    method alternative-names(--> List) {
        my @alt-names = 'japanese_jisx0213_a';
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
        'JISX0213.2004 adds these characters to JISX0213.2000.'
    }
}
