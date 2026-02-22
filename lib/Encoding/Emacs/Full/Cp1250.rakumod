use v6.d;
use Encoding::Emacs::Full::Windows_1250;

# Alias: cp1250 -> windows-1250
class Encoding::Emacs::Cp1250 is Encoding::Emacs::Windows_1250 {
    method name(--> Str) {
        'cp1250'
    }
}
