use v6.d;
use Encoding::Emacs::Windows_1255;

# Alias: cp1255 -> windows-1255
class Encoding::Emacs::Cp1255 is Encoding::Emacs::Windows_1255 {
    method name(--> Str) {
        'cp1255'
    }
}
