use v6.d;
use Encoding::Emacs::Ibm038;

# Alias: cp038 -> ibm038
class Encoding::Emacs::Cp038 is Encoding::Emacs::Ibm038 {
    method name(--> Str) {
        'cp038'
    }
}
