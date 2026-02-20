use v6.d;
use Encoding::Emacs::Ptcp154;

# Alias: cp154 -> ptcp154
class Encoding::Emacs::Cp154 is Encoding::Emacs::Ptcp154 {
    method name(--> Str) {
        'cp154'
    }
}
