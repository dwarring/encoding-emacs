use v6.d;


# Unicode Basic Multilingual Plane (U+0000..U+FFFF)
# Source: Emacs charset definition
# Map file: 

class Encoding::Emacs::Unicode_Bmp {

    
    method name(--> Str) {
        'unicode-bmp'
    }
    
    method alternative-names(--> List) {
        my @alt-names = 'unicode_bmp';
        return @alt-names;
    }
    
    method is-ascii-compatible(--> Bool) {
        False
    }
    
method decoder(*%opts) {
    die "Decoder not yet implemented for unicode-bmp (no mapping file)";
}

    
method encoder(*%opts) {
    die "Encoder not yet implemented for unicode-bmp (no mapping file)";
}

    
    method description(--> Str) {
        'Unicode Basic Multilingual Plane (U+0000..U+FFFF)'
    }
}
