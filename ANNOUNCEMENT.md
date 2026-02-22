# Encoding::Emacs v0.1.0 - Announcement

## Reddit Post (r/rakulang)

**Title:** [ANN] Encoding::Emacs v0.1.0 - 80+ legacy character encodings for Raku

**Body:**

I'm excited to announce the release of **Encoding::Emacs**, a new module that brings 80+ legacy character encodings to Raku!

## What is it?

Encoding::Emacs auto-generates Raku encoding classes from Emacs' MULE (Multilingual Environment) charset definitions. It provides comprehensive support for legacy encodings that many developers still need when working with older files and systems.

## Supported Encodings

- **ISO-8859 series** (2-9, 14, 15) - Latin, Cyrillic, Greek, Hebrew, Arabic, Turkish, etc.
- **Windows codepages** (CP1250-1258) - All major Windows encodings
- **DOS codepages** (CP437, CP850-866) - Classic DOS encodings with box-drawing
- **KOI8 variants** (KOI8-R, KOI8-U, KOI8-T) - Russian, Ukrainian, Tajik
- **IBM EBCDIC** - Mainframe encodings
- **Mac Roman, HP Roman8, VISCII** - And 50+ more!

## Features

✅ **Full encode/decode support** - Convert between bytes and Unicode  
✅ **O(1) performance** - Hash-based lookups for fast conversion  
✅ **Lazy loading** - Encodings load on-demand, minimal memory footprint  
✅ **Production ready** - 52 passing tests, validated on real-world data  
✅ **Easy to use** - Simple, idiomatic Raku API

## Installation

```bash
zef install Encoding::Emacs
```

## Quick Example

```raku
use Encoding::Emacs::Full::Cp850;

# Decode DOS CP850 bytes
my $bytes = Buf.new(0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x20, 0x9D);
my $decoder = Encoding::Emacs::Full::Cp850.decoder;
say $decoder.consume($bytes);  # Output: Hello Ø

# Encode Unicode to CP850
my $encoder = Encoding::Emacs::Full::Cp850.encoder;
my $encoded = $encoder.encode-chars("Grüß Gott");
say $encoded;  # Buf with proper CP850 bytes
```

## Why This Matters

Legacy encoding support is crucial for:
- Working with old database dumps
- Processing files from legacy systems
- Converting historical documents
- Interfacing with mainframes and industrial systems
- Migrating data to Unicode

Instead of maintaining encoding tables manually, Encoding::Emacs generates them automatically from Emacs' battle-tested MULE definitions.

## Links

- **Install:** `zef install Encoding::Emacs`
- **GitHub:** https://github.com/winfredraj/encoding-emacs
- **Documentation:** Full README with examples
- **Author:** zef:winfredraj

## Technical Highlights

The module uses:
- **Raku Grammar** for parsing Emacs Lisp charset definitions
- **Template-based code generation** for creating 80+ encoding classes
- **Runtime mapping loader** with caching for performance
- **Anonymous inner classes** implementing Raku's Encoding roles

All encoder/decoder classes are auto-generated, ensuring consistency and making it easy to add new encodings.

## Future Plans

- Multi-byte encoding support (CJK)
- Integration with Raku's Encoding::Registry
- Performance optimizations for large files
- Additional encoding families

## Feedback Welcome!

This is v0.1.0 - I'd love to hear your feedback, bug reports, and feature requests!

Enjoy! 🚀

---

## Twitter/X Post

🎉 Just released Encoding::Emacs v0.1.0 for #RakuLang!

80+ legacy character encodings (ISO-8859, Windows CP, DOS CP, KOI8, EBCDIC) auto-generated from Emacs MULE definitions.

✅ Full encode/decode
✅ O(1) hash lookups
✅ 52 passing tests

zef install Encoding::Emacs

https://github.com/winfredraj/encoding-emacs

#Raku #Unicode #Programming

---

## IRC/Discord Announcement

Hey everyone! 👋

Just published Encoding::Emacs v0.1.0 to the ecosystem!

It provides 80+ legacy character encodings (ISO-8859, Windows/DOS codepages, KOI8, EBCDIC, etc.) auto-generated from Emacs MULE definitions.

Perfect for working with legacy files and systems.

Install: `zef install Encoding::Emacs`
GitHub: https://github.com/winfredraj/encoding-emacs

Feedback welcome! 🎉

---

## Mailing List Post (raku-users)

**Subject:** [ANN] Encoding::Emacs v0.1.0 - Legacy character encodings for Raku

Hi everyone,

I'm pleased to announce the release of Encoding::Emacs v0.1.0, now available on the Raku ecosystem.

**What it does:**

Encoding::Emacs provides comprehensive support for 80+ legacy character encodings by auto-generating Raku encoding classes from Emacs' MULE (Multilingual Environment) charset definitions.

**Supported encoding families:**

- ISO-8859 series (Latin-1 through Latin-10)
- Windows codepages (CP1250-1258)
- DOS codepages (CP437, CP850-866, etc.)
- KOI8 variants (KOI8-R, KOI8-U, KOI8-T)
- IBM EBCDIC encodings
- Mac Roman, HP Roman8, VISCII, and more

**Key features:**

- Full bidirectional encode/decode support
- O(1) hash-based lookups for performance
- Lazy loading with caching
- 52 comprehensive tests
- Validated on real-world legacy files

**Installation:**

    zef install Encoding::Emacs

**Example usage:**

    use Encoding::Emacs::Full::Iso_8859_5;  # Cyrillic

    my $bytes = slurp("old-file.txt", :bin);
    my $decoder = Encoding::Emacs::Full::Iso_8859_5.decoder;
    my $text = $decoder.consume($bytes);
    say $text;  # Properly decoded Russian text

**Links:**

- GitHub: https://github.com/winfredraj/encoding-emacs
- zef: zef install Encoding::Emacs
- Documentation: README with comprehensive examples

**Why Emacs MULE?**

Emacs' MULE system has decades of battle-testing and comprehensive coverage of legacy encodings. By auto-generating from these definitions, we get reliable, well-tested encoding tables without manual maintenance.

Feedback, bug reports, and contributions are very welcome!

Best regards,
Winfred Raj

