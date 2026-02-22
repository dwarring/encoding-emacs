use v6.d;
use Encoding::Emacs::Full::Vscii;

# Alias: tcvn-5712 -> vscii
class Encoding::Emacs::Tcvn_5712 is Encoding::Emacs::Vscii {
    method name(--> Str) {
        'tcvn-5712'
    }
}
