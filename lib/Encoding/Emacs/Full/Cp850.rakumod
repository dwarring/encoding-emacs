use v6.d;
use Encoding::Emacs::Ibm850;

# Alias: cp850 -> ibm850
class Encoding::Emacs::Cp850 is Encoding::Emacs::Ibm850 {
    method name(--> Str) {
        'cp850'
    }
}
