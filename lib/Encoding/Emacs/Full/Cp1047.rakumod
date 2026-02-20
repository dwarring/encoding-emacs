use v6.d;
use Encoding::Emacs::Ibm1047;

# Alias: cp1047 -> ibm1047
class Encoding::Emacs::Cp1047 is Encoding::Emacs::Ibm1047 {
    method name(--> Str) {
        'cp1047'
    }
}
