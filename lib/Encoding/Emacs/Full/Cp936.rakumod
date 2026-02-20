use v6.d;
use Encoding::Emacs::Chinese_Gbk;

# Alias: cp936 -> chinese-gbk
class Encoding::Emacs::Cp936 is Encoding::Emacs::Chinese_Gbk {
    method name(--> Str) {
        'cp936'
    }
}
