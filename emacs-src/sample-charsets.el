;;; Sample from Emacs mule-conf.el for testing

(define-charset 'latin-iso8859-1
  "Right-Hand Part of ISO/IEC 8859/1 (Latin-1): ISO-IR-100"
  :short-name "RHP of Latin-1"
  :long-name "RHP of ISO/IEC 8859/1 (Latin-1): ISO-IR-100"
  :iso-final-char ?A
  :emacs-mule-id 129
  :code-space [32 127]
  :code-offset 160)

(define-charset 'iso-8859-2
  "ISO/IEC 8859/2 (Latin-2)"
  :short-name "Latin-2"
  :ascii-compatible-p t
  :code-space [0 255]
  :map "8859-2")

(define-charset 'iso-8859-5 'cyrillic-iso8859-5
  "ISO/IEC 8859/5"
  :short-name "Latin/Cyrillic"
  :iso-final-char ?L
  :emacs-mule-id 140
  :code-space [0 255]
  :map "8859-5")

(define-charset-alias 'ucs 'unicode)
(define-charset-alias 'cp936 'chinese-gbk)

(define-charset 'windows-1252
  "WINDOWS-1252 (Latin I)"
  :short-name "WINDOWS-1252"
  :ascii-compatible-p t
  :code-space [0 255]
  :map "CP1252")
(define-charset-alias 'cp1252 'windows-1252)
