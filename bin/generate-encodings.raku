#!/usr/bin/env raku

use v6.d;
use lib 'lib';
use Encoding::Emacs::Parser;
use Encoding::Emacs::Generator;

sub MAIN(Str $input-file = 'emacs-src/mule-conf.el', Str $output-dir = 'lib/Encoding/Emacs') {
    say "=" x 70;
    say "Encoding::Emacs - Code Generator";
    say "=" x 70;
    say "";
    
    # Parse Emacs source
    say "📖 Reading: $input-file";
    my $source = $input-file.IO.slurp;
    
    say "🔍 Parsing Emacs charset definitions...";
    my %parsed = parse-emacs-encodings($source);
    
    unless %parsed {
        die "❌ Failed to parse $input-file";
    }
    
    my @charsets = %parsed<charsets>.list;
    my @aliases = %parsed<aliases>.list;
    
    say "✓ Found {+@charsets} charsets";
    say "✓ Found {+@aliases} aliases";
    say "";
    
    # Show sample
    if @charsets {
        say "Sample charset: {%parsed<charsets>[0].name}";
        say "  Description: {%parsed<charsets>[0].description}";
        say "";
    }
    
    # Generate code
    say "🔨 Generating Raku encoding classes...";
    say "   Output directory: $output-dir";
    say "";
    
    my @files = write-generated-files(@charsets, @aliases, $output-dir);
    
    say "";
    say "=" x 70;
    say "✅ Code Generation Complete!";
    say "=" x 70;
    say "";
    say "Generated {+@files} files:";
    say "  - {+@charsets} charset classes";
    say "  - {+@aliases} alias classes";
    say "  - 1 registry module";
    say "";
    say "Next steps:";
    say "  1. Implement mapping table integration";
    say "  2. Add decoder/encoder logic";
    say "  3. Create tests";
    say "  4. Benchmark performance";
}
