final admonitionPattern = RegExp(r'(:{3})(.*?):*$');
final referencePattern = RegExp(r'(&{3})(.*?)&*$');
final codeSelectorPattern = RegExp(r'(%{3})(.*?)%*$');

/// Character `:`.
const int $colon = 0x3A;

/// Character `&`.
const int $ampersand = 0x26;

/// Character `%`.
const int $percent = 0x25;
