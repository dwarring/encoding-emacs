use v6.d;
use Encoding::Emacs::Cp1125;

# Alias: cp866u -> cp1125
class Encoding::Emacs::Cp866u is Encoding::Emacs::Cp1125 {
    method name(--> Str) {
        'cp866u'
    }
}
