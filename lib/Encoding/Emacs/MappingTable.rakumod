use v6.d;

unit module Encoding::Emacs::MappingTable;

class MappingTable is export {
    has %.decode-map; # byte -> Unicode codepoint
    has %.encode-map; # Unicode codepoint -> byte
    
    method load-from-file(Str $filename) {
        my $content = $filename.IO.slurp;
        self.parse-mapping($content);
    }
    
    method parse-mapping(Str $content) {
        my %decode;
        my %encode;
        
        for $content.lines -> $line {
            next if $line ~~ /^\s*'#'/;  # Skip comments
            next if $line ~~ /^\s*$/;     # Skip empty lines
            
            # Format: 0xXX-0xYY 0xUUUU  or  0xXX 0xUUUU
            if $line ~~ /^ \s* '0x' $<start>=(<[0..9 A..F a..f]>+) 
                          [\s* '-' \s* '0x' $<end>=(<[0..9 A..F a..f]>+)]?
                          \s+ '0x' $<unicode>=(<[0..9 A..F a..f]>+) / {
                
                my $start = :16($<start>.Str);
                my $end = $<end> ?? :16($<end>.Str) !! $start;
                my $unicode-base = :16($<unicode>.Str);
                
                for $start .. $end -> $byte {
                    my $unicode = $unicode-base + ($byte - $start);
                    %decode{$byte} = $unicode;
                    %encode{$unicode} = $byte;
                }
            }
        }
        
        MappingTable.new(decode-map => %decode, encode-map => %encode);
    }
    
    method decode-byte(Int $byte) {
        %!decode-map{$byte} // $byte;  # Fallback to identity
    }
    
    method encode-codepoint(Int $codepoint) {
        %!encode-map{$codepoint};
    }
    
    method can-encode(Int $codepoint) {
        %!encode-map{$codepoint}:exists;
    }
    
    method decode-bytes(Blob $bytes) {
        my @codepoints = $bytes.list.map: { self.decode-byte($_) };
        @codepoints.map({ .chr }).join;
    }
    
    method encode-string(Str $string, Str :$replacement = '?') {
        my @bytes;
        for $string.ords -> $codepoint {
            if self.can-encode($codepoint) {
                @bytes.push: self.encode-codepoint($codepoint);
            } else {
                # Use replacement character
                @bytes.push: $replacement.ord;
            }
        }
        Blob.new(@bytes);
    }
}

# Cache for loaded mapping tables
my %mapping-cache;

sub load-mapping-table(Str $map-file, Str $charsets-dir = 'emacs-src/charsets') is export {
    my $key = $map-file;
    return %mapping-cache{$key} if %mapping-cache{$key}:exists;
    
    my $filename = "$charsets-dir/$map-file.map";
    unless $filename.IO.e {
        die "Mapping file not found: $filename";
    }
    
    my $table = MappingTable.new.load-from-file($filename);
    %mapping-cache{$key} = $table;
    return $table;
}

sub get-mapping-table(Str $map-file, Str $charsets-dir = 'emacs-src/charsets') is export {
    load-mapping-table($map-file, $charsets-dir);
}
