// ignore_for_file: deprecated_member_use

/// assets/icons/ ke saare PNG ek jagah. Naam yahan se hi use karo (typo na ho).
/// Sizes @2x export hain: 48px file = 24 logical, 44px = 22, 104px = 52.
class AppAssets {
  

  static const String _dir = 'assets/icons/';

  // Brand
  static const String logo = '${_dir}logo.png'; // terracotta tile + rings (30 logical)

  // Bottom navbar (48px = 24 logical, sirf icon -> ImageIcon + color)
  static const String home = '${_dir}home.png';
  static const String explore = '${_dir}explore.png';
  static const String saved = '${_dir}saved.png';
  static const String profile = '${_dir}profile.png';
  static const String add = '${_dir}add.png'; // 52x52 apna box hai -> bina color

  // Header
  static const String search = '${_dir}search.png'; // 44 logical box
  static const String bell = '${_dir}bell.png'; // bina notification (24 logical)
  // TODO(asset): bell1.png abhi bell.png ki hubahu copy hai (dot nahi).
  // Dot wala asli icon aane par sirf is file ko replace karo, code nahi badlega.
  static const String bellUnread = '${_dir}bell1.png';

  // Post card (44px = 22 logical)
  static const String likes = '${_dir}likes.png'; // filled heart (liked)
  static const String comments = '${_dir}comments.png';
  static const String bookmark = '${_dir}flag.png'; // outline bookmark (not saved)

  // Explore
  static const String searchBar = '${_dir}searchbar.png';
  static const String filter = '${_dir}filter.png'; // apna box hai -> bina color

  // Auth
  static const String eye = '${_dir}onEyeTapped.png';
}
