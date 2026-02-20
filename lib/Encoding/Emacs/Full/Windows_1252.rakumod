use v6.d;
use Encoding::Emacs::MappingTable;

# WINDOWS-1252 (Latin I)
# Source: Emacs charset definition
# Map file: CP1252

class Encoding::Emacs::Windows_1252 {
    my $mapping-table;
    method !get-mapping() {
        $mapping-table //= load-mapping-table('CP1252', 'emacs-src/charsets');
        return $mapping-table;
    }
    
    method name(--> Str) {
        'windows-1252'
    }
    
    method alternative-names(--> List) {
        my @alt-names = 'windows_1252';
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
        'WINDOWS-1252 (Latin I)'
    }
}
