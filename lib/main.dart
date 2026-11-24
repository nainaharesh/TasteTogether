// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastetogether/services/push_notification_service.dart';
import 'package:tastetogether/services/token_storage.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Secure storage se token ek baar memory mein (baad mein sync milta hai).
  await TokenStorage.init();

  // Firebase + push notifications (setup na ho to app phir bhi chalti hai).
  await PushNotificationService.init();

  // Enable when local storage is required.
  // await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852), // design ka size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TasteTogether',
        // Har device par safe layout:
        // 1) bari screen (Chrome/tablet) par app phone jaisi width (480) mein rahe
        // 2) system ka font size bohat bara ho to bhi text 1.2x se zyada na barhe
        // 3) keyboard ke bahar tap karne par keyboard band ho jaye
        builder: (context, child) {
          const maxWidth = 480.0;
          final mq = MediaQuery.of(context);
          final width = mq.size.width > maxWidth ? maxWidth : mq.size.width;
          final data = mq.copyWith(
            size: Size(width, mq.size.height),
            textScaler: mq.textScaler.clamp(
              minScaleFactor: 0.9,
              maxScaleFactor: 1.2,
            ),
          );
          // .w/.h/.sp bhi isi (phone jaisi) width se hisaab lagayen
          ScreenUtil.configure(data: data);
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: ColoredBox(
              color: AppColors.background,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxWidth),
                  child: MediaQuery(data: data, child: child!),
                ),
              ),
            ),
          );
        },
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.background, // #F8F7F4
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary, // #B65C45
            onPrimary: AppColors.surface, // #FFFFFF
            secondary: AppColors.primaryDeep, // #9E4B36
            surface: AppColors.surface, // #FFFFFF
            onSurface: AppColors.textPrimary, // #292929
            onSurfaceVariant: AppColors.textMuted, // #6B6560
            outline: AppColors.fieldBorder, // #D2B7A3
            outlineVariant: AppColors.border, // #E8D8CA
            surfaceTint: Colors.transparent,
          ),
          // DM Sans typography
          textTheme: GoogleFonts.dmSansTextTheme(ThemeData.light().textTheme)
              .apply(
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
            hintStyle: const TextStyle(color: AppColors.textMuted),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(color: AppColors.fieldBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
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
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: AppColors.primaryDeep),
          ),
        ),

        // Saari routes lib/routes/app_routes.dart mein hain
        initialBinding: AppPages.initialBinding,
        initialRoute: AppRoutes.splash,
        getPages: AppPages.pages,
      ),
    );
  }
}
