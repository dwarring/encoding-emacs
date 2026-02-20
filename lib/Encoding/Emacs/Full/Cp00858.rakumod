use v6.d;
use Encoding::Emacs::Cp858;

# Alias: cp00858 -> cp858
class Encoding::Emacs::Cp00858 is Encoding::Emacs::Cp858 {
    method name(--> Str) {
        'cp00858'
    }
}
