use v6.d;
use Encoding::Emacs::Full::Windows_1251;

# Alias: cp1251 -> windows-1251
class Encoding::Emacs::Cp1251 is Encoding::Emacs::Windows_1251 {
    method name(--> Str) {
        'cp1251'
    }
}
