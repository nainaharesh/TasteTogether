
import 'package:get/get.dart';
import '../models/follower_model.dart';

class FollowersViewModel extends GetxController {
  final RxList<FollowerModel> followers = <FollowerModel>[
    const FollowerModel(
      name: 'Sofia Marchetti',
      username: 'sofia.bites',
      initials: 'SM',
      isFollowing: true,
    ),
    const FollowerModel(
      name: 'Lucas Meyer',
      username: 'lucas.m',
      initials: 'LM',
    ),
    const FollowerModel(
      name: 'Hira Khan',
      username: 'hira.cooks',
      initials: 'HK',
      isFollowing: true,
    ),
    const FollowerModel(
      name: 'Priya Nair',
      username: 'priya.n',
      initials: 'PN',
    ),
    const FollowerModel(
      name: 'Omar Siddiqui',
      username: 'omar.s',
      initials: 'OS',
      isFollowing: true,
    ),
    const FollowerModel(
      name: 'Mei Tanaka',
      username: 'mei.tanaka',
      initials: 'MT',
    ),
    const FollowerModel(
      name: 'Amina Raza',
      username: 'amina.eats',
      initials: 'AR',
      isFollowing: true,
    ),
    const FollowerModel(
      name: 'Noah Reyes',
      username: 'noah.r',
      initials: 'NR',
    ),
  ].obs;

  final RxString searchQuery = ''.obs;

  List<FollowerModel> get filteredFollowers {
    final query = searchQuery.value.toLowerCase().trim();

    if (query.isEmpty) return followers.toList();

    return followers.where((follower) {
      return follower.name.toLowerCase().contains(query) ||
          follower.username.toLowerCase().contains(query);
    }).toList();
  }

  void searchFollowers(String value) {
    searchQuery.value = value;
  }

  void toggleFollow(int index) {
    final follower = followers[index];

    followers[index] = FollowerModel(
      name: follower.name,
      username: follower.username,
      initials: follower.initials,
      profileImage: follower.profileImage,
      isFollowing: !follower.isFollowing,
    );
  }
}
