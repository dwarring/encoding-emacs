use v6.d;
use Encoding::Emacs::Windows_1252;

# Alias: cp1252 -> windows-1252
class Encoding::Emacs::Cp1252 is Encoding::Emacs::Windows_1252 {
    method name(--> Str) {
        'cp1252'
    }
}
