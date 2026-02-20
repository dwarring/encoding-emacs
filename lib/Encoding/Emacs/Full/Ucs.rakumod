use v6.d;
use Encoding::Emacs::Unicode;

# Alias: ucs -> unicode
class Encoding::Emacs::Ucs is Encoding::Emacs::Unicode {
    method name(--> Str) {
        'ucs'
    }
}
