import 'package:flutter/material.dart';

/// All colors come from the "Foundations" board of the TasteTogether design.
/// If you already have an AppColors file, merge these values into it.
class AppColors {
  AppColors._(); // private constructor: this class is never instantiated

  static const Color background = Color(0xFFF8F7F4); // screen background
  static const Color textPrimary = Color(0xFF292929);
  static const Color textSecondary = Color(0xFF6B6560); // subtitles, hints, icons
  static const Color primary = Color(0xFFB65C45); // buttons, focus border
  static const Color primaryDark = Color(0xFF9E4B36); // text links
  static const Color border = Color(0xFFD2B7A3); // input border
  static const Color tint = Color(0xFFE8D8CA); // icon circles, info banner
  static const Color white = Color(0xFFFFFFFF);

  // The design has no error color, so validation errors reuse primaryDark.
  // Change this one line if your designer gives you a dedicated error color.
  static const Color error = Color(0xFF9E4B36);

  // Placeholder photo tiles on the Welcome screen
  static const Color tile1 = Color(0xFFE2CDBD);
  static const Color tile2 = Color(0xFFC9A892);
  static const Color tile3 = Color(0xFFD2B7A3);
  static const Color tile4 = Color(0xFFDCC5B3);



  /// White – cards, bottom nav bar, text on primary buttons #FFFFFF
  static const Color surface = Color(0xFFFFFFFF);

  /// Links, small labels, restaurant name, active nav label ("Home"), location pin icon (text on off-white, 5.6:1).
  static const Color primaryDeep = Color(0xFF9E4B36);

  /// Muted Text – timestamps, captions, hints, inactive tabs/nav #6B6560 (5.4:1)
  static const Color textMuted = Color(0xFF6B6560);

  /// Field Border – input fields, outlined chips #D2B7A3
  /// (Login, SignUp, EditProfile, CreateReview inputs; also used as a photo placeholder shade)
  static const Color fieldBorder = Color(0xFFD2B7A3);

  // ───────── Photo placeholders (food photo tiles) ─────────
  static const Color photoPlaceholder1 = Color(0xFFE2CDBD);
  static const Color photoPlaceholder2 = Color(0xFFDCC5B3);
  static const Color photoPlaceholder3 = Color(0xFFC9A892);

}