use v6.d;
use Encoding::Emacs::Cp866;

# Alias: ibm866 -> cp866
class Encoding::Emacs::Ibm866 is Encoding::Emacs::Cp866 {
    method name(--> Str) {
        'ibm866'
    }
}
