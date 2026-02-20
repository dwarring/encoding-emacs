use v6.d;


# 8-bit control code (0x80..0x9F)
# Source: Emacs charset definition
# Map file: 

class Encoding::Emacs::Control_1 {

    
    method name(--> Str) {
        'control-1'
    }
    
    method alternative-names(--> List) {
        my @alt-names = 'control_1';
        return @alt-names;
    }
    
    method is-ascii-compatible(--> Bool) {
        False
    }
    
method decoder(*%opts) {
    die "Decoder not yet implemented for control-1 (no mapping file)";
}

    
method encoder(*%opts) {
    die "Encoder not yet implemented for control-1 (no mapping file)";
}

    
    method description(--> Str) {
        '8-bit control code (0x80..0x9F)'
    }
}
