// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

/// Saare colors design ki "Foundations" board se.
/// Pehle do alag AppColors classes thi (merge se); ab ek hi hai.
class AppColors {
  // ───────── Brand ─────────
  /// Terracotta – primary accent #B65C45
  /// Buttons, FAB (+), active tab underline, stars, liked heart, notification dot, avatar bg.
  static const Color primary = Color(0xFFB65C45);

  /// Terracotta Deep – #9E4B36
  /// Links, small labels, restaurant name, active nav label ("Home"), location pin icon (text on off-white, 5.6:1).
  static const Color primaryDeep = Color(0xFF9E4B36);

  // ───────── Backgrounds / surfaces ─────────
  /// Off-white screen background #F8F7F4
  static const Color background = Color(0xFFF8F7F4);

  /// White – cards, bottom nav bar, text on primary buttons #FFFFFF
  static const Color surface = Color(0xFFFFFFFF);

  // ───────── Text ─────────
  /// Charcoal – main text, headings, icons #292929
  static const Color textPrimary = Color(0xFF292929);

  /// Muted Text – timestamps, captions, hints, inactive tabs/nav #6B6560 (5.4:1)
  static const Color textMuted = Color(0xFF6B6560);

  // ───────── Borders ─────────
  /// Sand border – card borders, dividers, nav top border #E8D8CA
  static const Color border = Color(0xFFE8D8CA);

  /// Field Border – input fields, outlined chips #D2B7A3
  /// (Login, SignUp, EditProfile, CreateReview inputs; also used as a photo placeholder shade)
  static const Color fieldBorder = Color(0xFFD2B7A3);

  // ───────── Photo placeholders (food photo tiles) ─────────
  static const Color photoPlaceholder1 = Color(0xFFE2CDBD);
  static const Color photoPlaceholder2 = Color(0xFFDCC5B3);
  static const Color photoPlaceholder3 = Color(0xFFC9A892);

  // ───────── Authentication screens ke naam (purane naam, wohi colors) ─────────
  static const Color white = surface;
  static const Color textSecondary = textMuted; // subtitles, hints, icons
  static const Color primaryDark = primaryDeep; // text links
  static const Color tint = border; // icon circles, info banner

  // Design mein error color nahi, is liye validation errors primaryDeep use karte hain.
  // Designer dedicated error color de to sirf ye ek line badlo.
  static const Color error = primaryDeep;

  // Welcome screen ke placeholder photo tiles
  static const Color tile1 = photoPlaceholder1; // #E2CDBD
  static const Color tile2 = photoPlaceholder3; // #C9A892
  static const Color tile3 = fieldBorder; // #D2B7A3
  static const Color tile4 = photoPlaceholder2; // #DCC5B3

  // ───────── Overlay ─────────
  //static const Color scrim = Color.fromRGBO(41, 41, 41, 0.5);
}
