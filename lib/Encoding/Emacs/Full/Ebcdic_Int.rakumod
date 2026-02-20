use v6.d;
use Encoding::Emacs::Ibm038;

# Alias: ebcdic-int -> ibm038
class Encoding::Emacs::Ebcdic_Int is Encoding::Emacs::Ibm038 {
    method name(--> Str) {
        'ebcdic-int'
    }
}
