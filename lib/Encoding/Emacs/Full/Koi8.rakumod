use v6.d;
use Encoding::Emacs::Full::Koi8_R;

# Alias: koi8 -> koi8-r
class Encoding::Emacs::Koi8 is Encoding::Emacs::Koi8_R {
    method name(--> Str) {
        'koi8'
    }
}
