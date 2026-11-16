

// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

/// TasteTogether – saare colors jo poori application (13 screens + design system) mein use hue hain.
/// Source: Design System canvas (DesignSystem.dc.html, Components.dc.html) aur har screen ki file.
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
  static const Color photoPlaceholder2 = Color(0xFFDCC5B3); // Home: 1st post photo
  static const Color photoPlaceholder3 = Color(0xFFC9A892);
  // Home: 2nd post photo uses fieldBorder (#D2B7A3)

  // ───────── Overlay ─────────
  /// rgba(41,41,41,0.5) – sirf Components board mein (overlay/scrim), kisi phone screen mein nahi.
  static const Color scrim = Color.fromRGBO(41, 41, 41, 0.5);

  // ═════════════════════════════════════════════════════════
  //  HOME FEED (screen 4) mein use hone wale colors
  // ═════════════════════════════════════════════════════════
  static const Color homeScreenBg = background;          // #F8F7F4
  static const Color homeLogoBg = primary;               // logo box #B65C45
  static const Color homeLogoIcon = surface;             // logo icon stroke #FFFFFF
  static const Color homeTitle = textPrimary;            // "TasteTogether" #292929
  static const Color homeHeaderIcons = textPrimary;      // search + bell #292929
  static const Color homeNotificationDot = primary;      // dot #B65C45, border = background
  static const Color homeTabActiveText = textPrimary;    // "Following" #292929
  static const Color homeTabActiveLine = primary;        // underline #B65C45
  static const Color homeTabInactiveText = textMuted;    // "Community" #6B6560
  static const Color homeTabsBorder = border;            // #E8D8CA
  static const Color homeCardBg = surface;               // post card #FFFFFF
  static const Color homeCardBorder = border;            // #E8D8CA
  static const Color homeAvatar1Bg = primary;            // "AR" avatar #B65C45 (text white)
  static const Color homeAvatar2Bg = textPrimary;        // "DO" avatar #292929 (text white)
  static const Color homeUsername = textPrimary;         // #292929
  static const Color homeMeta = textMuted;               // "· 2h ago" #6B6560
  static const Color homeRestaurantLink = primaryDeep;   // restaurant name + pin #9E4B36
  static const Color homePhoto1 = photoPlaceholder2;     // #DCC5B3
  static const Color homePhoto2 = fieldBorder;           // #D2B7A3
  static const Color homePhotoLabel = textPrimary;       // "Photo · ..." #292929
  static const Color homeStars = primary;                // rating stars #B65C45
  static const Color homeReviewText = textPrimary;       // #292929
  static const Color homeMoreLink = primaryDeep;         // "more" #9E4B36
  static const Color homeLikeActive = primary;           // heart #B65C45 (count = textPrimary)
  static const Color homeActionIcons = textPrimary;      // comment, save, "..." #292929
  static const Color homeNavBg = surface;                // bottom nav #FFFFFF
  static const Color homeNavBorder = border;             // #E8D8CA
  static const Color homeNavActiveIcon = primary;        // Home icon #B65C45
  static const Color homeNavActiveLabel = primaryDeep;   // "Home" label #9E4B36
  static const Color homeNavInactive = textMuted;        // Explore / Saved / Profile #6B6560
  static const Color homeFabBg = primary;                // + button #B65C45
  static const Color homeFabIcon = surface;              // #FFFFFF

  // ═════════════════════════════════════════════════════════
  //  Har screen mein kaun se colors use hue (reference)
  // ═════════════════════════════════════════════════════════
  // 1  Welcome (Main)   : textPrimary, surface, primary, textMuted, background, primaryDeep, photo1/2/3, fieldBorder
  // 2  Login            : textMuted, surface, textPrimary, fieldBorder, primary, primaryDeep, background
  // 3  Sign Up          : textMuted, textPrimary, surface, fieldBorder, background, primary, primaryDeep
  // 4  Home Feed        : primary, textPrimary, surface, primaryDeep, textMuted, border, background, photo2, fieldBorder
  // 5  Explore          : sab 9 core colors + photo1/2/3
  // 6  Restaurant       : primary, surface, textMuted, textPrimary, border, photo3, background, photo2, fieldBorder, primaryDeep
  // 7  Create Review    : textPrimary, surface, primary, fieldBorder, textMuted, background, primaryDeep, photo2, photo3
  // 8  Notifications    : sab 9 core colors + photo1/2/3
  // 9  Profile          : sab 9 core colors + photo1/2/3
  // 10 Edit Profile     : surface, textPrimary, fieldBorder, textMuted, background, primary, primaryDeep
  // 11 Saved Places     : sab 9 core colors + photo1/2/3
  // 12 Settings         : border, textMuted, textPrimary, surface, primary, background, primaryDeep
  // (Design System + Components boards: sab colors + scrim)
}