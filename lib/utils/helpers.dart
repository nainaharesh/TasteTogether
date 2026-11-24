/// Turns "Layla Hassan" into "LH" (used for the avatar circle).
/// Returns an empty string when the name is empty.
String getInitials(String name) {
  final words = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .toList();

  if (words.isEmpty) return '';
  if (words.length == 1) return words.first[0].toUpperCase();
  return (words.first[0] + words[1][0]).toUpperCase();
}
