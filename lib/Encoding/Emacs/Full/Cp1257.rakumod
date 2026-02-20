use v6.d;
use Encoding::Emacs::Windows_1257;

# Alias: cp1257 -> windows-1257
class Encoding::Emacs::Cp1257 is Encoding::Emacs::Windows_1257 {
    method name(--> Str) {
        'cp1257'
    }
}
