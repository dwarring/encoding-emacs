use v6.d;
use Encoding::Emacs::Chinese_Gbk;

# Alias: windows-936 -> chinese-gbk
class Encoding::Emacs::Windows_936 is Encoding::Emacs::Chinese_Gbk {
    method name(--> Str) {
        'windows-936'
    }
}
