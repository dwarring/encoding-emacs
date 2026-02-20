use v6.d;
use Encoding::Emacs::Ptcp154;

# Alias: pt154 -> ptcp154
class Encoding::Emacs::Pt154 is Encoding::Emacs::Ptcp154 {
    method name(--> Str) {
        'pt154'
    }
}
