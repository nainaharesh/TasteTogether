// To parse this JSON data, do
//
//     final homeFeed = homeFeedFromJson(jsonString);

import 'dart:convert';

HomeFeed homeFeedFromJson(String str) => HomeFeed.fromJson(json.decode(str));

String homeFeedToJson(HomeFeed data) => json.encode(data.toJson());

class HomeFeed {
    final List<Review>? reviews;
    final int? page;
    final int? limit;
    final String? tab;

    HomeFeed({
        this.reviews,
        this.page,
        this.limit,
        this.tab,
    });

    factory HomeFeed.fromJson(Map<String, dynamic> json) => HomeFeed(
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        tab: json["tab"],
    );

    Map<String, dynamic> toJson() => {
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "page": page,
        "limit": limit,
        "tab": tab,
    };
}

class Review {
    final String? id;
    final String? userId;
    final String? restaurantId;
    final String? dishId;
    final int? rating;
    final String? text;
    final dynamic photoUrl;
    final int? likeCount;
    final int? commentCount;
    final bool? isLiked;
    final DateTime? createdAt;
    final Author? author;
    final Restaurant? restaurant;
    final Dish? dish;

    Review({
        this.id,
        this.userId,
        this.restaurantId,
        this.dishId,
        this.rating,
        this.text,
        this.photoUrl,
        this.likeCount,
        this.commentCount,
        this.isLiked,
        this.createdAt,
        this.author,
        this.restaurant,
        this.dish,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["userId"],
        restaurantId: json["restaurantId"],
        dishId: json["dishId"],
        rating: json["rating"],
        text: json["text"],
        photoUrl: json["photoUrl"],
        likeCount: json["likeCount"],
        commentCount: json["commentCount"],
        isLiked: json["isLiked"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        restaurant: json["restaurant"] == null ? null : Restaurant.fromJson(json["restaurant"]),
        dish: json["dish"] == null ? null : Dish.fromJson(json["dish"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "restaurantId": restaurantId,
        "dishId": dishId,
        "rating": rating,
        "text": text,
        "photoUrl": photoUrl,
        "likeCount": likeCount,
        "commentCount": commentCount,
        "isLiked": isLiked,
        "createdAt": createdAt?.toIso8601String(),
        "author": author?.toJson(),
        "restaurant": restaurant?.toJson(),
        "dish": dish?.toJson(),
    };
}

class Author {
    final String? id;
    final String? fullName;
    final String? username;
    final dynamic avatarUrl;
    final String? avatarColor;

    Author({
        this.id,
        this.fullName,
        this.username,
        this.avatarUrl,
        this.avatarColor,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        fullName: json["fullName"],
        username: json["username"],
        avatarUrl: json["avatarUrl"],
        avatarColor: json["avatarColor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "username": username,
        "avatarUrl": avatarUrl,
        "avatarColor": avatarColor,
    };
}

class Dish {
    final String? id;
    final String? name;

    Dish({
        this.id,
        this.name,
    });

    factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Restaurant {
    final String? id;
    final String? name;
    final dynamic photoUrl;

    Restaurant({
        this.id,
        this.name,
        this.photoUrl,
    });

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        photoUrl: json["photoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photoUrl": photoUrl,
    };
}
