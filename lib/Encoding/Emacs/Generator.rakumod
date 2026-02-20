use v6.d;

unit module Encoding::Emacs::Generator;

use Encoding::Emacs::Parser;

sub normalize-name(Str $name --> Str) is export {
    # Convert emacs naming to Raku class naming
    # iso-8859-1 -> ISO_8859_1
    # windows-1252 -> Windows_1252
    $name.split('-').map(*.tc).join('_');
}

sub kebab-to-underscore(Str $name --> Str) is export {
    $name.subst('-', '_', :g);
}

sub generate-encoding-class(CharsetDef $def --> Str) is export {
    my $class-name = normalize-name($def.name);
    my $charset-name = $def.name;
    my $description = $def.description || "Character encoding: $charset-name";
    
    # Extract properties
    my $map = $def.properties<map> // '';
    my $short-name = $def.properties<short-name> // $charset-name;
    my $ascii-compatible = $def.properties<ascii-compatible-p> ?? 'True' !! 'False';
    
    # Build alternative names list
    my @alt-names;
    @alt-names.push($def.alias) if $def.alias;
    @alt-names.push(kebab-to-underscore($charset-name)) if $charset-name.contains('-');
    
    my $alt-names-str = @alt-names ?? 'my @alt-names = ' ~ @alt-names.map({"'$_'"}).join(', ') ~ ';' !! 'my @alt-names;';
    
    # Determine if we have a mapping file
    my $has-mapping = $map ne '';
    my $decoder-impl = $has-mapping ?? generate-decoder-with-mapping($map) !! generate-stub-decoder($charset-name);
    my $encoder-impl = $has-mapping ?? generate-encoder-with-mapping($map) !! generate-stub-encoder($charset-name);
    
    my $code = q:to/END/;
use v6.d;
USESTATEMENT

# DESCRIPTION
# Source: Emacs TYPE definition
# Map file: MAP

class Encoding::Emacs::CLASSNAME {
MAPPINGFIELD
    
    method name(--> Str) {
        'CHARSETNAME'
    }
    
    method alternative-names(--> List) {
        ALTNAMES
        return @alt-names;
    }
    
    method is-ascii-compatible(--> Bool) {
        ASCIICOMPAT
    }
    
DECODERIMPL
    
ENCODERIMPL
    
    method description(--> Str) {
        'DESCRIPTION'
    }
}
END

    my $use-statement = $has-mapping ?? 'use Encoding::Emacs::MappingTable;' !! '';
    my $mapping-field = $has-mapping ?? 
        '    my $mapping-table;' ~ "\n" ~
        '    method !get-mapping() {' ~ "\n" ~
        '        $mapping-table //= load-mapping-table(\'' ~ $map ~ '\', \'emacs-src/charsets\');' ~ "\n" ~
        '        return $mapping-table;' ~ "\n" ~
        '    }' 
        !! '';
    
    $code .= subst('USESTATEMENT', $use-statement, :g);
    $code .= subst('MAPPINGFIELD', $mapping-field, :g);
    $code .= subst('DECODERIMPL', $decoder-impl, :g);
    $code .= subst('ENCODERIMPL', $encoder-impl, :g);
    $code .= subst('CLASSNAME', $class-name, :g);
    $code .= subst('CHARSETNAME', $charset-name, :g);
    $code .= subst('DESCRIPTION', $description, :g);
    $code .= subst('TYPE', $def.type, :g);
    $code .= subst('MAP', $map, :g);
    $code .= subst('ALTNAMES', $alt-names-str, :g);
    $code .= subst('ASCIICOMPAT', $ascii-compatible, :g);
    
    return $code;
}

sub generate-decoder-with-mapping(Str $map) {
    return q:to/END/;
    method decoder(*%opts) {
        my $mapping-table = self!get-mapping();
        class {
            has $.mapping;
            
            method decode(Blob $bytes) {
                $!mapping.decode-bytes($bytes);
            }
        }.new(mapping => $mapping-table);
    }
    END
}

sub generate-stub-decoder(Str $charset-name) {
    return qq:to/END/;
    method decoder(*%opts) \{
        die "Decoder not yet implemented for $charset-name (no mapping file)";
    \}
    END
}

sub generate-encoder-with-mapping(Str $map) {
    return q:to/END/;
    method encoder(*%opts) {
        my $mapping-table = self!get-mapping();
        class {
            has $.mapping;
            
            method encode(Str $string, :$replacement = '?') {
                $!mapping.encode-string($string, :$replacement);
            }
        }.new(mapping => $mapping-table);
    }
    END
}

sub generate-stub-encoder(Str $charset-name) {
    return qq:to/END/;
    method encoder(*%opts) \{
        die "Encoder not yet implemented for $charset-name (no mapping file)";
    \}
    END
}

sub generate-alias-class(AliasDef $def --> Str) is export {
    my $alias-class = normalize-name($def.name);
    my $target-class = normalize-name($def.target);
    my $alias-name = $def.name;
    my $target-name = $def.target;
    
    my $code = q:to/END/;
use v6.d;
use Encoding::Emacs::TARGETCLASS;

# Alias: ALIASNAME -> TARGETNAME
class Encoding::Emacs::ALIASCLASS is Encoding::Emacs::TARGETCLASS {
    method name(--> Str) {
        'ALIASNAME'
    }
}
END

    $code .= subst('ALIASCLASS', $alias-class, :g);
    $code .= subst('TARGETCLASS', $target-class, :g);
    $code .= subst('ALIASNAME', $alias-name, :g);
    $code .= subst('TARGETNAME', $target-name, :g);
    
    return $code;
}

sub generate-registry(@charsets, @aliases --> Str) is export {
    my @class-names = @charsets.map({ normalize-name(.name) });
    my @alias-names = @aliases.map({ normalize-name(.name) });
    my @all-names = |@class-names, |@alias-names;
    
    my $uses = @all-names.map({ "use Encoding::Emacs::$_;" }).join("\n");
    my $registrations = @all-names.map({ 
        "    Encoding::Registry.register(Encoding::Emacs::$_.new);" 
    }).join("\n");
    
    my $count = +@all-names;
    
    return q:to/END/ ~ "\n";
use v6.d;

# Auto-generated Emacs encoding registry
# Generated from Emacs mule-conf.el definitions

USES

# Register all encodings with Raku's Encoding::Registry
# (This happens at compile time)
# BEGIN {
# REGISTRATIONS
# }

# Export count for verification
our sub encoding-count() is export {
    COUNT
}
END
    .subst('USES', $uses, :g)
    .subst('REGISTRATIONS', $registrations, :g)
    .subst('COUNT', $count, :g);
}

sub write-generated-files(
    @charsets, 
    @aliases,
    Str $output-dir = 'lib/Encoding/Emacs'
) is export {
    # Create output directory
    mkdir($output-dir) unless $output-dir.IO.e;
    
    my @generated-files;
    
    # Generate charset classes
    for @charsets -> $charset {
        my $class-name = normalize-name($charset.name);
        my $filename = "$output-dir/$class-name.rakumod";
        my $code = generate-encoding-class($charset);
        
        $filename.IO.spurt($code);
        @generated-files.push: $filename;
        say "✓ Generated: $filename";
    }
    
    # Generate alias classes
    for @aliases -> $alias {
        my $class-name = normalize-name($alias.name);
        my $filename = "$output-dir/$class-name.rakumod";
        my $code = generate-alias-class($alias);
        
        $filename.IO.spurt($code);
        @generated-files.push: $filename;
        say "✓ Generated: $filename";
    }
    
    # Generate registry
    my $registry-file = "$output-dir/Registry.rakumod";
    my $registry-code = generate-registry(@charsets, @aliases);
    $registry-file.IO.spurt($registry-code);
    @generated-files.push: $registry-file;
    say "✓ Generated: $registry-file";
    
    return @generated-files;
}
