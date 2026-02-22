use v6.d;
use Encoding::Emacs::Full::Windows_1256;

# Alias: cp1256 -> windows-1256
class Encoding::Emacs::Cp1256 is Encoding::Emacs::Windows_1256 {
    method name(--> Str) {
        'cp1256'
    }
}
