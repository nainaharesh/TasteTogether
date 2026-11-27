// ignore_for_file: deprecated_member_use


import 'package:tastetogether/models/main_application/dish_model.dart';
import 'package:tastetogether/models/main_application/resturant_model.dart';

/// GET /api/search?q=&type=&sort=
/// Response: { restaurants: [...], dishes: [...] }
/// `type` ke hisaab se koi ek key khali ya gayab ho sakti hai, is liye dono
/// ka default khali list hai.
class SearchResultModel {
  const SearchResultModel({required this.restaurants, required this.dishes});

  final List<Restaurant> restaurants;
  final List<Dish> dishes;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    final restaurants = json['restaurants'] as List? ?? const [];
    final dishes = json['dishes'] as List? ?? const [];
    return SearchResultModel(
      restaurants: restaurants
          .map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
          .toList(),
      dishes: dishes
          .map((e) => Dish.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}