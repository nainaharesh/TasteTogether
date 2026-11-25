// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/viewmodels/followers_viewmodel.dart';

class FollowersScreen extends GetView<FollowersViewModel> {
  const FollowersScreen({super.key});

  static const Color background = Color(0xFFFAF8F4);
  static const Color dark = Color(0xFF292929);
  static const Color terracotta = Color(0xFFB65C45);
  static const Color muted = Color(0xFF77716C);
  static const Color border = Color(0xFFE8D8CA);

  final List<Color> avatarColors = const [
    Color(0xFFEBD8C7),
    Color(0xFFB65C45),
    Color(0xFF292929),
    Color(0xFFEBD8C7),
    Color(0xFFB65C45),
    Color(0xFF292929),
    Color(0xFFB65C45),
    Color(0xFFEBD8C7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        titleSpacing: 16,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: dark, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'danny_dines',
          style: TextStyle(
            color: dark,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      '3.4k Followers',
                      style: TextStyle(
                        color: dark,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(height: 2, color: terracotta),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      '210 Following',
                      style: TextStyle(
                        color: dark,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(height: 2, color: border),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(9, 7, 9, 7),
            child: SizedBox(
              height: 34,
              child: TextField(
                onChanged: (value) {
                  controller.searchFollowers(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search followers',
                  hintStyle: const TextStyle(
                    fontSize: 11,
                    color: muted,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 15,
                    color: muted,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 32,
                  ),
                  contentPadding: EdgeInsets.zero,
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: terracotta),
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 1,
                ),
                itemCount: controller.filteredFollowers.length,
                itemBuilder: (context, index) {
                  final follower = controller.filteredFollowers[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: avatarColors[index],
                          child: Text(
                            follower.initials,
                            style: TextStyle(
                              color: index == 0 ||
                                      index == 3 ||
                                      index == 7
                                  ? dark
                                  : Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 9),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                follower.name,
                                style: const TextStyle(
                                  color: dark,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                follower.username,
                                style: const TextStyle(
                                  color: muted,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 26,
                          child: OutlinedButton(
                            onPressed: () {
                              controller.toggleFollow(
                                controller.followers.indexOf(follower),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              foregroundColor: follower.isFollowing
                                  ? terracotta
                                  : Colors.white,
                              backgroundColor: follower.isFollowing
                                  ? Colors.white
                                  : terracotta,
                              side: const BorderSide(
                                color: terracotta,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            child: Text(
                              follower.isFollowing
                                  ? 'Following'
                                  : 'Follow',
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
