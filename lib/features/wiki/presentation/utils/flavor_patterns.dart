final admonitionPattern = RegExp(r'(:{3})(.*?):*$');
final referencePattern = RegExp(r'(&{3})(.*?)&*$');
final codeSelectorPattern = RegExp(r'(%{3})(.*?)%*$');
final hexColorPattern = RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$');

/// A line of hyphens separated by at least one pipe.
final tablePattern = RegExp(
    r'^[ ]{0,3}\|?([ \t]*:?\-+:?[ \t]*\|)+([ \t]|[ \t]*:?\-+:?[ \t]*)?$');

/// A pattern which should never be used. It just satisfies non-nullability of
/// pattern fields.
final dummyPattern = RegExp('');

/// Character `:`.
const int $colon = 0x3A;

/// Character `&`.
const int $ampersand = 0x26;

/// Character `%`.
const int $percent = 0x25;

/// Character `|`.
const int $pipe = 0x7C;

/// Space character.
const int $space = 0x20;

/// "Horizontal Tab" control character, common name.
const int $tab = 0x09;

/// Character `\`.
const int $backslash = 0x5C;