use v6.d;

unit module Encoding::Emacs::Parser;

grammar EmacsEncodingGrammar is export {
    regex TOP { <item>* }
    
    proto regex item {*}
    regex item:sym<charset>     { <charset-def> }
    regex item:sym<iso-charset> { <iso-charset-def> }
    regex item:sym<alias>       { <alias-def> }
    regex item:sym<skip>        { . }
    
    regex charset-def {
        '(' \s* 'define-charset' \s+ 
        "'" $<name>=<identifier> 
        [ \s+ "'" $<alias>=<identifier> ]?
        [ \s+ $<description>=<string> ]?
        <property>*
        \s* ')'
    }
    
    regex iso-charset-def {
        '(' \s* 'define-iso-single-byte-charset' \s+ 
        "'" $<name>=<identifier> \s+
        "'" $<alias>=<identifier> \s+
        $<description>=<string> \s+
        $<nickname>=<string> \s+
        $<iso-ir>=<number> \s+
        $<iso-final>=<char-literal> \s+
        $<emacs-mule-id>=<number> \s+
        $<map>=<string>
        \s* ')'
    }
    
    regex alias-def {
        '(' \s* 'define-charset-alias' \s+ 
        "'" $<name>=<identifier> \s+
        "'" $<target>=<identifier> \s*
        ')'
    }
    
    regex property {
        \s* ':' $<key>=<prop-name> \s+ $<value>=<prop-value>
    }
    
    token prop-name {
        <[a..z A..Z]> <[a..z A..Z 0..9 -]>*
    }
    
    proto regex prop-value {*}
    regex prop-value:sym<string>  { <string> }
    regex prop-value:sym<number>  { <number> }
    regex prop-value:sym<char>    { <char-literal> }
    regex prop-value:sym<vector>  { <vector> }
    regex prop-value:sym<bool>    { <[t]> }
    regex prop-value:sym<nil>     { 'nil' }
    
    token string {
        '"' <-["]>* '"'
    }
    
    token number {
        '-'? \d+
    }
    
    token char-literal {
        '?' <[A..Z a..z _ -]>
    }
    
    regex vector {
        '[' \s* <number>+ % \s+ \s* ']'
    }
    
    token identifier {
        <[a..z A..Z 0..9 _ -]>+
    }
}

class CharsetDef is export {
    has Str $.name;
    has Str $.alias;
    has Str $.description;
    has %.properties;
    has Str $.type = 'charset'; # 'charset' or 'iso-charset'
}

class AliasDef is export {
    has Str $.name;
    has Str $.target;
}

sub parse-emacs-encodings(Str $source) is export {
    my $match = EmacsEncodingGrammar.parse($source);
    return Nil unless $match;
    
    my @charsets;
    my @aliases;
    
    for $match<item>.list -> $item {
        if $item<charset-def> {
            my $cs = $item<charset-def>;
            my %props;
            
            for $cs<property>.list -> $prop {
                my $key = $prop<key>.Str;
                my $value = $prop<value>.Str;
                # Remove quotes from string values
                $value = $value.substr(1, *-1) if $value ~~ /^'"'/;
                %props{$key} = $value;
            }
            
            @charsets.push: CharsetDef.new(
                name => $cs<name>.Str,
                alias => $cs<alias> ?? $cs<alias>.Str !! '',
                description => $cs<description> ?? $cs<description>.Str.substr(1, *-1) !! '',
                properties => %props,
                type => 'charset'
            );
        }
        elsif $item<iso-charset-def> {
            my $iso = $item<iso-charset-def>;
            
            # Remove quotes from strings
            my $map-value = $iso<map>.Str;
            $map-value = $map-value.substr(1, *-1) if $map-value ~~ /^'"'/;
            
            my %props = 
                'iso-ir' => $iso<iso-ir>.Str,
                'iso-final-char' => $iso<iso-final>.Str,
                'emacs-mule-id' => $iso<emacs-mule-id>.Str,
                'map' => $map-value;
            
            @charsets.push: CharsetDef.new(
                name => $iso<name>.Str,
                alias => $iso<alias>.Str,
                description => $iso<description>.Str.substr(1, *-1),
                properties => %props,
                type => 'iso-charset'
            );
        }
        elsif $item<alias-def> {
            my $al = $item<alias-def>;
            @aliases.push: AliasDef.new(
                name => $al<name>.Str,
                target => $al<target>.Str
            );
        }
    }
    
    return {:@charsets, :@aliases};
}
