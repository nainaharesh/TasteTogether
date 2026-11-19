// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/theme/appcolors.dart';

import 'package:tastetogether/viewmodels/main_application_models/explore_viewmodel/explore_view_model.dart' hide ExploreController;
import 'package:tastetogether/views/main_application/resturant_details.dart';
import 'package:tastetogether/widgets/explore/custom_serachfield.dart' hide SearchTextField;

import 'package:tastetogether/views/main_application/resturant_details.dart';

import 'package:tastetogether/widgets/explore/food_category_chip.dart';
import 'package:tastetogether/widgets/explore/nearby_tile.dart';
import 'package:tastetogether/widgets/explore/resturant_card.dart';
import 'package:tastetogether/widgets/explore/section_textlabels.dart';
import 'package:tastetogether/widgets/explore/dish_card.dart';



import '../../viewmodels/explore_viewmodel/explore_view_model.dart';
import '../../widgets/explore/custom_searchfield.dart';


class Explore extends StatelessWidget {
  Explore({super.key});

  final ExploreController controller = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.sizeOf(context).width * 0.59;
    final listHeight = cardWidth * 108 / 232 + 92;


    final tileWidth = MediaQuery.sizeOf(context).width * 0.315; 


    final tileListHeight = tileWidth * 104 / 124 + 64;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 4, right: 4, top: 24),
          child: Column(
            spacing: 8,
            children: [
              // Search bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SearchTextField(
                  hintText: 'Search restaurants or dishes',
                  onChanged: (value) {},
                  prefixIcon: const ImageIcon(
                    AssetImage('assets/icons/searchbar.png'),
                    size: 20,
                    color: AppColors.textMuted,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/filter.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ),

              // Category chips
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(height: 44),
                child: Obx(() {
                  final selected = controller.selectedCategory.value;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, i) => Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FoodCategoryChip(
                          label: controller.categories[i],
                          isSelected: i == selected,
                          onTap: () => controller.selectCategory(i),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              // Popular restaurants
              Column(
                spacing: 4,
                children: [
                  SectionTextlabels(
                    title: 'Popular restaurants',
                    onSeeAllPressed: () =>
                        Get.to(() => const ResturantDetails()),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(height: listHeight),
                    child: Obx(


                          () => ListView.builder(

                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: controller.restaurants.length,
                        itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                              width: cardWidth,
                            ),
                            child: RestaurantCard(
                              restaurant: controller.restaurants[i],
                              placeholderColor: AppColors.photoPlaceholder2,
                              onTap: () =>
                                  Get.to(() => const ResturantDetails()),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //////// Trending dishes//////
              Column(
                spacing: 4,
                children: [
                  SectionTextlabels(
                    title: 'Trending dishes',
                    onSeeAllPressed: () {},
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      height: tileListHeight,
                    ),
                    child: Obx(


                          () => ListView.builder(

                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: controller.dishes.length,
                        itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                              width: tileWidth,
                            ),
                            child: DishCard(
                              dish: controller.dishes[i],
                              placeholderColor: AppColors.photoPlaceholder2,
                              onTap: () =>
                                  Get.to(() => const ResturantDetails()),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              ///////Nearby ///////
              Column(
                spacing: 4,
                children: [
                  SectionTextlabels(title: 'Nearby', onSeeAllPressed: () {}),
                  Obx(

                        () => ListView.builder(

                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: controller.nearby.length,
                      itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: NearbyTile(
                          restaurant: controller.nearby[i],
                          onTap: () => Get.to(() => const ResturantDetails()),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

