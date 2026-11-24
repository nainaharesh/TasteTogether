
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/views/authentication/welcomescreen.dart';

import 'package:tastetogether/viewmodels/notification_viewmodel.dart';
import 'package:tastetogether/viewmodels/followers_viewmodel.dart';
import 'package:tastetogether/viewmodels/notification_preferences_viewmodel.dart';

import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Notification-related controllers
  Get.put(NotificationsViewModel());
  Get.put(FollowersViewModel());
  Get.put(NotificationPreferencesViewModel());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'TasteTogether',
          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.background,

            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
              onPrimary: AppColors.surface,
              secondary: AppColors.primaryDeep,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
              onSurfaceVariant: AppColors.textMuted,
              outline: AppColors.fieldBorder,
              outlineVariant: AppColors.border,
              surfaceTint: Colors.transparent,
            ),

            textTheme: GoogleFonts.dmSansTextTheme(
              ThemeData.light().textTheme,
            ).apply(
              bodyColor: AppColors.textPrimary,
              displayColor: AppColors.textPrimary,
            ),

            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.background,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              surfaceTintColor: Colors.transparent,
              titleTextStyle: GoogleFonts.dmSans(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            dividerTheme: const DividerThemeData(
              color: AppColors.border,
              thickness: 1,
            ),

            inputDecorationTheme: InputDecorationTheme(
              hintStyle: const TextStyle(
                color: AppColors.textMuted,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: AppColors.fieldBorder,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),

            filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.surface,
                minimumSize: Size.fromHeight(52.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryDeep,
              ),
            ),
          ),

          // Initial Screen
          home: const WelcomeScreen(),

          // GetX Named Routes
          getPages: AppPages.pages,

          // Keyboard Dismiss + Responsive Width
          builder: (context, child) {
            const maxWidth = 480.0;

            final mq = MediaQuery.of(context);

            final width = mq.size.width > maxWidth
                ? maxWidth
                : mq.size.width;

            final data = mq.copyWith(
              size: Size(width, mq.size.height),
              textScaler: mq.textScaler.clamp(
                minScaleFactor: 0.9,
                maxScaleFactor: 1.2,
              ),
            );

            ScreenUtil.configure(data: data);

            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: ColoredBox(
                color: AppColors.background,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: maxWidth,
                    ),
                    child: MediaQuery(
                      data: data,
                      child: child!,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
