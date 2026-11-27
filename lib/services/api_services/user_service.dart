
import 'package:tastetogether/models/auth/auth_models.dart';
import 'package:tastetogether/models/user_activity/user_follow_model.dart';
import 'package:tastetogether/models/user_activity/user_follower_model.dart';
import 'package:tastetogether/models/user_activity/user_following_model.dart';
import 'package:tastetogether/models/user_activity/user_reviews_model.dart';

import 'package:tastetogether/services/api/api_client.dart';
import 'package:tastetogether/services/api/api_endpoints.dart';
import 'package:tastetogether/services/api/api_exception.dart';

class UserService {
  // Convert API response into Map
  Map<String, dynamic> asMap(dynamic response) {
    if (response is Map<String, dynamic>) {
      return response;
    }

    throw ApiException('Invalid server response.');
  }

  // Get the logged-in user's profile
  Future<UserModel> getMyProfile() async {
    final response = await ApiClient.get(ApiEndpoints.myProfile);

    final data = asMap(response);

    return UserModel.fromJson(data);
  }

  // Update the logged-in user's profile
  Future<UserModel> updateMyProfile({
    required Map<String, dynamic> body,
  }) async {
    final response = await ApiClient.patch(
      ApiEndpoints.myProfile,
      body: body,
    );

    final data = asMap(response);

    return UserModel.fromJson(data);
  }

  // Get another user's profile by ID
  Future<UserModel> getUserById(String otherUserId) async {
    final response = await ApiClient.get(
      ApiEndpoints.user(otherUserId),
    );

    final data = asMap(response);

    return UserModel.fromJson(data);
  }

  // Get another user's reviews
  Future<UserReviewsResponse> getUserReviews({
    required String otherUserId,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await ApiClient.get(
      '${ApiEndpoints.userReviews(otherUserId)}'
      '?page=$page&limit=$limit',
    );

    final data = asMap(response);

    return UserReviewsResponse.fromJson(data);
  }

  // Get another user's followers
  Future<UserFollowersResponse> getUserFollowers({
    required String otherUserId,
    String q = '',
    int page = 1,
    int limit = 20,
  }) async {
    final queryParameters = <String, String>{
      'q': q,
      'page': page.toString(),
      'limit': limit.toString(),
    };

    final query = Uri(queryParameters: queryParameters).query;

    final response = await ApiClient.get(
      '${ApiEndpoints.userFollowers(otherUserId)}?$query',
    );

    final data = asMap(response);

    return UserFollowersResponse.fromJson(data);
  }

  // Get another user's following
  Future<UserFollowingResponse> getUserFollowing({
    required String otherUserId,
    String q = '',
    int page = 1,
    int limit = 20,
  }) async {
    final queryParameters = <String, String>{
      'q': q,
      'page': page.toString(),
      'limit': limit.toString(),
    };

    final query = Uri(queryParameters: queryParameters).query;

    final response = await ApiClient.get(
      '${ApiEndpoints.userFollowing(otherUserId)}?$query',
    );

    final data = asMap(response);

    return UserFollowingResponse.fromJson(data);
  }

  // Follow another user
  Future<UserFollowModel> postUserFollow({
    required String otherUserId,
  }) async {
    final response = await ApiClient.post(
      ApiEndpoints.followUser(otherUserId),
    );

    final data = asMap(response);

    return UserFollowModel.fromJson(data);
  }
// Unfollow another user
Future<UserFollowModel> deleteUserFollow({
  required String otherUserId,
}) async {
  final response = await ApiClient.delete(
    ApiEndpoints.unfollowUser(otherUserId),
  );

  final data = asMap(response);

  return UserFollowModel.fromJson(data);
}
}
