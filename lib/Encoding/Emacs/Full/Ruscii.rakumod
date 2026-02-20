use v6.d;
use Encoding::Emacs::Cp1125;

# Alias: ruscii -> cp1125
class Encoding::Emacs::Ruscii is Encoding::Emacs::Cp1125 {
    method name(--> Str) {
        'ruscii'
    }
}
