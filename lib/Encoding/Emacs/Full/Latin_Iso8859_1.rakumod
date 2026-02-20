use v6.d;


# Right-Hand Part of ISO/IEC 8859/1 (Latin-1): ISO-IR-100
# Source: Emacs charset definition
# Map file: 

class Encoding::Emacs::Latin_Iso8859_1 {

    
    method name(--> Str) {
        'latin-iso8859-1'
    }
    
    method alternative-names(--> List) {
        my @alt-names = 'latin_iso8859_1';
        return @alt-names;
    }
    
    method is-ascii-compatible(--> Bool) {
        False
    }
    
method decoder(*%opts) {
    die "Decoder not yet implemented for latin-iso8859-1 (no mapping file)";
}

    
method encoder(*%opts) {
    die "Encoder not yet implemented for latin-iso8859-1 (no mapping file)";
}

    
    method description(--> Str) {
        'Right-Hand Part of ISO/IEC 8859/1 (Latin-1): ISO-IR-100'
    }
}
