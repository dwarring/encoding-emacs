#!/usr/bin/env raku

# Demo: Show the power of Encoding::Emacs code generation

use v6.d;
use lib 'lib';
use Encoding::Emacs::Parser;
use Encoding::Emacs::Generator;

say "=" x 70;
say "Encoding::Emacs - Code Generation Demo";
say "=" x 70;
say "";

# Step 1: Parse Emacs definitions
say "📖 Step 1: Parsing Emacs charset definitions...";
my $source = 'emacs-src/mule-conf.el'.IO.slurp;
my %parsed = parse-emacs-encodings($source);

my @charsets = %parsed<charsets>.list;
my @aliases = %parsed<aliases>.list;

say "   ✓ Parsed {+@charsets} charsets";
say "   ✓ Parsed {+@aliases} aliases";
say "";

# Step 2: Show sample charset
say "📋 Step 2: Sample Charset Definition";
say "-" x 70;
my $sample = @charsets[4]; # ISO-8859-5
say "   Name: $sample.name()";
say "   Alias: $sample.alias()" if $sample.alias;
say "   Description: $sample.description()";
say "   Type: $sample.type()";
say "   Properties:";
for $sample.properties.kv -> $k, $v {
    say "      :$k => $v";
}
say "";

# Step 3: Generate code
say "🔨 Step 3: Generating Raku Code";
say "-" x 70;
my $generated = generate-encoding-class($sample);
say $generated.lines[0..20].join("\n");
say "   ... (truncated)";
say "";

# Step 4: Statistics
say "📊 Step 4: Generation Statistics";
say "-" x 70;

my %encoding-types;
for @charsets -> $cs {
    my $type = $cs.properties<map> ?? 'mapped' !! 'inline';
    %encoding-types{$type}++;
}

say "   Total encodings: {+@charsets + +@aliases}";
say "   Charsets: {+@charsets}";
say "   Aliases: {+@aliases}";
say "";
say "   By type:";
for %encoding-types.kv -> $type, $count {
    say "      $type: $count";
}
say "";

# Step 5: Show coverage
say "🌍 Step 5: Encoding Coverage";
say "-" x 70;

my %regions = 
    'ISO-8859 Latin/Cyrillic/etc.' => 0,
    'Windows code pages' => 0,
    'DOS code pages' => 0,
    'Cyrillic KOI8' => 0,
    'Vietnamese' => 0,
    'Georgian' => 0,
    'Other' => 0;

for @charsets -> $cs {
    my $name = $cs.name;
    given $name {
        when /iso\-8859/ { %regions{'ISO-8859 Latin/Cyrillic/etc.'}++ }
        when /windows/ { %regions{'Windows code pages'}++ }
        when /cp\d+/ { %regions{'DOS code pages'}++ }
        when /koi8/ { %regions{'Cyrillic KOI8'}++ }
        when /viscii|vscii/ { %regions{'Vietnamese'}++ }
        when /georgian/ { %regions{'Georgian'}++ }
        default { %regions{'Other'}++ }
    }
}

for %regions.sort(*.value).reverse -> (:$key, :$value) {
    say "   $key: $value";
}
say "";

# Step 6: Demo full generation
say "⚡ Step 6: Ready to Generate Full Library";
say "-" x 70;
say "   To generate all {+@charsets + +@aliases} encoding classes:";
say "";
say "   \$ raku bin/generate-encodings.raku \\";
say "          emacs-src/mule-conf.el \\";
say "          lib/Encoding/Emacs/Output";
say "";
say "   This will create:";
say "      • {+@charsets} charset class files (.rakumod)";
say "      • {+@aliases} alias class files (.rakumod)";
say "      • 1 registry module (Registry.rakumod)";
say "      • ~390 lines of generator code";
say "      • Parsing 1,756 lines of Emacs Lisp";
say "";

say "=" x 70;
say "✅ Demo Complete!";
say "=" x 70;
say "";
say "Next: Implement mapping tables for actual encode/decode";
