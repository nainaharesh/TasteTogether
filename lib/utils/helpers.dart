import 'dart:ui' show Color;

/// "2026-11-20T05:21:26.950Z" -> "2h ago", "3d ago" (feed card par time).
/// Parse na ho sake to khali string.
String formatTimeAgo(String? isoDate) {
  final date = DateTime.tryParse(isoDate ?? '');
  if (date == null) return '';

  final diff = DateTime.now().difference(date.toLocal());
  if (diff.inMinutes < 1) return 'now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  if (diff.inDays < 30) return '${diff.inDays ~/ 7}w ago';
  if (diff.inDays < 365) return '${diff.inDays ~/ 30}mo ago';
  return '${diff.inDays ~/ 365}y ago';
}

/// "#C96E5E" -> Color. Hex galat ya null ho to fallback.
Color colorFromHex(String? hex, {required Color fallback}) {
  if (hex == null) return fallback;
  final clean = hex.replaceFirst('#', '');
  if (clean.length != 6) return fallback;
  final value = int.tryParse(clean, radix: 16);
  return value == null ? fallback : Color(0xFF000000 | value);
}

/// "2026-11-20T05:21:26.950Z" -> "20 Nov 2026" (review card par date).
String formatDate(String? isoDate) {
  final date = DateTime.tryParse(isoDate ?? '')?.toLocal();
  if (date == null) return '';
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}
