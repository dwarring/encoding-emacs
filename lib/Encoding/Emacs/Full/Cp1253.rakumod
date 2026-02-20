use v6.d;
use Encoding::Emacs::Windows_1253;

# Alias: cp1253 -> windows-1253
class Encoding::Emacs::Cp1253 is Encoding::Emacs::Windows_1253 {
    method name(--> Str) {
        'cp1253'
    }
}
