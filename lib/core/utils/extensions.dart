import 'dart:ui';

extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but callback have index as second argument
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${(a * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}'
      '${(r * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}'
      '${(g * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}'
      '${(b * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}';
}
