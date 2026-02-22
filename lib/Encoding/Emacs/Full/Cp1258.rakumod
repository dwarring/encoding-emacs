use v6.d;
use Encoding::Emacs::Full::Windows_1258;

# Alias: cp1258 -> windows-1258
class Encoding::Emacs::Cp1258 is Encoding::Emacs::Windows_1258 {
    method name(--> Str) {
        'cp1258'
    }
}
