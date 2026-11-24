// ignore_for_file: deprecated_member_use
// Chalane ka tareeqa:  flutter test test/responsive_test.dart
//
// Ye test har screen ko bohat saare device sizes aur bade font scales par
// kholta hai aur check karta hai ke koi RenderFlex overflow / layout error na aye.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastetogether/main.dart';
import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/models/post_models.dart';
import 'package:tastetogether/models/resturant_model.dart';
import 'package:tastetogether/views/main_application/comments.dart';
import 'package:tastetogether/views/main_application/create_review.dart';
import 'package:tastetogether/views/main_application/dish_details.dart';
import 'package:tastetogether/views/main_application/resturant_details.dart';
import 'package:tastetogether/views/main_application/search_results.dart';

// (width, height) logical px
const sizes = <(double, double)>[
  (320, 568), // chhota purana phone
  (360, 640),
  (360, 800), // common Android
  (393, 852), // design size
  (412, 915),
  (430, 932), // bara iPhone
  (600, 960), // chhota tablet
  (768, 1024), // tablet
  (1366, 768), // Chrome laptop
  (1920, 1080), // Chrome desktop
  (800, 360), // landscape phone
];

const textScales = <double>[1.0, 1.3, 2.0];

// lambe strings jaan bujh kar: overflow yahin pakda jata hai
const longRestaurant = Restaurant(
  name: 'The Extraordinarily Long Restaurant Name & Grill House',
  cuisine: 'Mediterranean Fusion',
  area: 'Clifton Block 5 Karachi',
  rating: 4.7,
  reviewCount: 12840,
  distanceKm: 1.2,
);
const longDish = Dish(
  name: 'Charred Lamb Kofta With Whipped Feta And Flatbread',
  restaurantName: 'The Extraordinarily Long Restaurant Name & Grill House',
  rating: 4.8,
  ratingCount: 1284,
);
const longPost = Post(
  id: 'x',
  username: 'a_really_long_username_for_testing.eats',
  initials: 'AR',
  restaurant: 'The Extraordinarily Long Restaurant Name & Grill House',
  timeAgo: '2h ago',
  dishName: 'Charred Lamb Kofta With Whipped Feta And Flatbread',
  rating: 5.0,
  review: 'Smoky off the grill, with whipped feta underneath. Order extra.',
  likes: 12900,
  comments: 1400,
);

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  for (final (w, h) in sizes) {
    for (final scale in textScales) {
      testWidgets('no overflow @ ${w.toInt()}x${h.toInt()} text x$scale', (
        tester,
      ) async {
        Get.reset();
        tester.view.physicalSize = Size(w, h);
        tester.view.devicePixelRatio = 1.0;
        tester.platformDispatcher.textScaleFactorTestValue = scale;
        addTearDown(() {
          tester.view.reset();
          tester.platformDispatcher.clearAllTestValues();
        });

        final errors = <FlutterErrorDetails>[];
        final oldHandler = FlutterError.onError;
        FlutterError.onError = (d) {
          final text = d.toString();
          // google_fonts test mein font download nahi kar sakta: isay ignore karo
          if (text.contains('GoogleFonts') ||
              text.contains('google_fonts') ||
              text.contains('allowRuntimeFetching')) {
            return;
          }
          errors.add(d);
        };
        addTearDown(() => FlutterError.onError = oldHandler);

        Future<void> settle() => tester.pump(const Duration(seconds: 1));

        await tester.pumpWidget(const MyApp());
        await settle();

        // 1) Home feed (dono tabs)
        await tester.tap(find.text('Community'));
        await settle();
        await tester.tap(find.text('Following'));
        await settle();

        // 2) Explore tab
        await tester.tap(find.text('Explore'));
        await settle();

        // 3) baaki screens
        final screens = <Widget Function()>[
          () => ResturantDetails(restaurant: longRestaurant),
          () => DishDetails(dish: longDish),
          () => SearchResults(query: 'a very long search query for testing'),
          () => Comments(post: longPost),
          () => CreateReview(),
        ];
        for (final build in screens) {
          Get.to(build);
          await settle();
          Get.back();
          await settle();
        }

        expect(
          errors.map((e) => e.exceptionAsString()).toList(),
          isEmpty,
          reason: 'layout error aya (${w.toInt()}x${h.toInt()}, text x$scale)',
        );
      });
    }
  }
}
