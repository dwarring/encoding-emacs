use v6.d;
use Encoding::Emacs::Windows_1254;

# Alias: cp1254 -> windows-1254
class Encoding::Emacs::Cp1254 is Encoding::Emacs::Windows_1254 {
    method name(--> Str) {
        'cp1254'
    }
}
