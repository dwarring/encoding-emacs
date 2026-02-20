# Encoding::Emacs

Auto-generated character encodings from Emacs MULE definitions. Provides 80+ legacy character encodings for Raku, including ISO-8859, Windows codepages, DOS codepages, KOI8, EBCDIC, and more.

## Installation

```bash
zef install Encoding::Emacs
```

Or from source:

```bash
git clone https://github.com/winfred-raj/encoding-emacs.git
cd encoding-emacs
zef install .
```

## Quick Start

```raku
#!/usr/bin/env raku
use Encoding::Emacs::Full::Cp850;

# Decode CP850 bytes (DOS encoding with box-drawing chars)
my $bytes = Buf.new(0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x20, 0x9D);  # "Hello Ø"
my $decoder = Encoding::Emacs::Full::Cp850.decoder;
my $text = $decoder.consume($bytes);
say $text;  # Output: Hello Ø

# Encode Unicode string to CP850
my $encoder = Encoding::Emacs::Full::Cp850.encoder;
my $encoded = $encoder.encode-chars("Grüß Gott");
say $encoded;  # Output: Buf:0x<47 72 81 E1 20 47 6F 74 74>
```

## Supported Encodings

### ISO-8859 Series (Latin)
- ISO-8859-2 (Central European)
- ISO-8859-3 (South European)
- ISO-8859-4 (North European)
- ISO-8859-5 (Cyrillic)
- ISO-8859-6 (Arabic)
- ISO-8859-7 (Greek)
- ISO-8859-8 (Hebrew)
- ISO-8859-9 (Turkish)
- ISO-8859-14 (Celtic)
- ISO-8859-15 (Latin-9 with Euro sign)

### Windows Codepages
- CP1250 (Central European)
- CP1251 (Cyrillic)
- CP1252 (Western European)
- CP1253 (Greek)
- CP1254 (Turkish)
- CP1255 (Hebrew)
- CP1256 (Arabic)
- CP1257 (Baltic)
- CP1258 (Vietnamese)

### DOS Codepages
- CP437 (Original IBM PC)
- CP850 (Western European)
- CP852 (Central European)
- CP855, CP857, CP860-865 (Various regions)
- CP866 (Russian)

### KOI8 Variants
- KOI8-R (Russian)
- KOI8-U (Ukrainian)
- KOI8-T (Tajik)

### Other Legacy Encodings
- Mac Roman
- HP Roman8
- VISCII (Vietnamese)
- IBM EBCDIC variants
- And 50+ more!

## Usage Examples

### Decode Legacy Files

```raku
use Encoding::Emacs::Full::Iso_8859_5;  # Cyrillic

my $bytes = slurp("old-file.txt", :bin);
my $decoder = Encoding::Emacs::Full::Iso_8859_5.decoder;
my $text = $decoder.consume($bytes);
say $text;  # Readable Russian text
```

### Encode for Legacy Systems

```raku
use Encoding::Emacs::Full::Windows_1252;

my $unicode-text = "Café résumé";
my $encoder = Encoding::Emacs::Full::Windows_1252.encoder;
my $bytes = $encoder.encode-chars($unicode-text);
spurt("output.txt", $bytes);
```

### Round-Trip Conversion

```raku
use Encoding::Emacs::Full::Cp866;  # Russian DOS

my $original = "Привет мир!";
my $encoder = Encoding::Emacs::Full::Cp866.encoder;
my $decoder = Encoding::Emacs::Full::Cp866.decoder;

my $encoded = $encoder.encode-chars($original);
my $decoded = $decoder.consume($encoded);

say $decoded eq $original;  # True
```

## How It Works

This module parses Emacs' MULE (Multilingual Environment) charset definitions and mapping tables to automatically generate Raku encoding classes. Each encoding:

1. **Lazy loads** mapping tables on first use
2. **Caches** mappings for performance
3. **Uses hash-based** O(1) lookups for encode/decode
4. **Implements** Raku's Encoding::Encoder and Encoding::Decoder roles

## Performance

- **Mapping load:** O(n) - done once per encoding, then cached
- **Decode:** O(m) - where m = bytes in input
- **Encode:** O(k) - where k = characters in input
- **Memory:** ~1-2 KB per loaded encoding

## Architecture

```
Encoding::Emacs/
├── Parser.rakumod          # Parses Emacs Lisp charset definitions
├── Generator.rakumod       # Generates Raku encoding classes
├── MappingTable.rakumod    # Runtime mapping table loader
└── Full/                   # 81 generated encoding classes
    ├── Iso_8859_5.rakumod
    ├── Cp850.rakumod
    ├── Windows_1252.rakumod
    └── ...
```

## Development

### Generate Encodings

```bash
raku bin/generate-encodings.raku emacs-src/mule-conf.el lib/Encoding/Emacs/Full
```

### Run Tests

```bash
raku -I lib t/01-parser.rakutest          # Parser tests
raku -I lib t/02-generator.rakutest       # Generator tests
raku -I lib t/03-mapping-table.rakutest   # Mapping loader tests
raku -I lib t/04-encoding-decoding.rakutest  # Encode/decode tests
raku -I lib t/05-phase3-encode-decode.rakutest  # Round-trip tests
raku -I lib t/06-cp850-encoding.rakutest  # CP850 specific tests
```

All 52 tests should pass.

## Status

- ✅ **Phase 1:** Parser - Complete
- ✅ **Phase 2:** Code Generator - Complete
- ✅ **Phase 3:** Mapping Tables - Complete
- 🔲 **Phase 4:** Performance optimization & Encoding::Registry integration

## Limitations

- Currently supports **single-byte encodings** only
- Multi-byte encodings (UTF-16, Shift-JIS, EUC, Big5, etc.) are in the mapping files but require additional implementation
- Not yet integrated with Raku's built-in Encoding::Registry

## Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

Artistic License 2.0 (same as Raku)

## Author

Winfred Raj

## See Also

- [Raku Encoding Documentation](https://docs.raku.org/type/Encoding)
- [Emacs MULE](https://www.gnu.org/software/emacs/manual/html_node/elisp/Coding-Systems.html)
- [Character Encodings](https://en.wikipedia.org/wiki/Character_encoding)

## Acknowledgments

Built using Emacs' comprehensive MULE (Multilingual Environment) charset definitions and mapping tables, originally created by the GNU Emacs team.
