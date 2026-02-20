# Distribution Guide for Encoding::Emacs

## Steps to Publish to Raku Ecosystem

### 1. Prepare the Package ✅

- [x] META6.json created with metadata
- [x] LICENSE file (Artistic 2.0)
- [x] README.md with usage examples
- [x] Tests passing (52 tests)
- [x] Clean git repository

### 2. Create GitHub Repository

```bash
# Initialize git if not already done
cd ~/code/raku/kaitai/encoding
git init
git add .
git commit -m "Initial release v0.1.0"

# Create GitHub repo (via web or gh CLI)
gh repo create encoding-emacs --public --source=. --remote=origin

# Push to GitHub
git push -u origin master
```

### 3. Install fez (Raku Ecosystem Uploader)

```bash
# Install fez
zef install fez

# Register with fez (one-time setup)
fez register

# This will:
# - Ask for your email
# - Send you a verification link
# - Set up your authentication
```

### 4. Upload to Ecosystem

```bash
# From the encoding directory
cd ~/code/raku/kaitai/encoding

# Check the package
fez checkbuild

# Upload to ecosystem (this makes it available via zef)
fez upload

# Or specify version explicitly
fez upload --ver=0.1.0
```

### 5. Verify Installation

```bash
# Test installation from ecosystem
zef install Encoding::Emacs

# Test it works
raku -e 'use Encoding::Emacs::Full::Cp850; say "✓ Installed!"'
```

## Alternative: GitHub-only Distribution

If you prefer to start with GitHub-only (before publishing to zef ecosystem):

```bash
# Users can install directly from GitHub
zef install git://github.com/winfred-raj/encoding-emacs.git

# Or specify a tag/version
zef install "git://github.com/winfred-raj/encoding-emacs.git#v0.1.0"
```

## Checklist Before Publishing

- [ ] All tests pass: `raku -I lib t/*.rakutest`
- [ ] META6.json is valid
- [ ] README has clear usage examples
- [ ] LICENSE file exists
- [ ] GitHub repo is public
- [ ] Git tags for versions: `git tag v0.1.0 && git push --tags`
- [ ] CHANGELOG.md lists changes (optional but recommended)

## Post-Publishing

### Announce to Community

1. **Raku Blog** - https://raku.org/community/
2. **Raku Reddit** - https://www.reddit.com/r/rakulang/
3. **IRC/Discord** - #raku channels
4. **Mailing List** - raku-users@perl.org

### Sample Announcement

```
Subject: [ANN] Encoding::Emacs v0.1.0 - 80+ legacy character encodings

I'm pleased to announce Encoding::Emacs, a module that provides 80+
legacy character encodings for Raku, auto-generated from Emacs MULE
definitions.

Supported encodings include:
- ISO-8859-2 through 8859-9, plus 14 and 15
- Windows codepages (CP1250-1258)
- DOS codepages (CP437, CP850-866, etc.)
- KOI8 variants (KOI8-R, KOI8-U, KOI8-T)
- IBM EBCDIC encodings
- And many more!

Installation:
    zef install Encoding::Emacs

Usage:
    use Encoding::Emacs::Full::Cp850;
    my $decoder = Encoding::Emacs::Full::Cp850.decoder;
    my $text = $decoder.consume($bytes);

GitHub: https://github.com/winfred-raj/encoding-emacs
Docs: https://github.com/winfred-raj/encoding-emacs#readme

Feedback welcome!
```

## Version Updates

When releasing new versions:

```bash
# 1. Update version in META6.json
# 2. Update CHANGELOG.md
# 3. Commit changes
git add META6.json CHANGELOG.md
git commit -m "Bump version to 0.2.0"

# 4. Create git tag
git tag v0.2.0
git push && git push --tags

# 5. Upload to ecosystem
fez upload --ver=0.2.0
```

## Resources

- **fez docs**: https://github.com/tony-o/raku-fez
- **zef**: https://github.com/ugexe/zef
- **META6 spec**: https://design.raku.org/S22.html
- **Raku modules**: https://raku.land/
