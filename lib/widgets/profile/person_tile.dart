// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/models/person_model.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/common/user_avatar.dart';
import 'package:tastetogether/widgets/profile/follow_button.dart';

/// Followers / Following list ki row: avatar + naam/username + Follow button
class PersonTile extends StatelessWidget {
  const PersonTile({
    super.key,
    required this.person,
    required this.onTap,
    required this.onToggleFollow,
  });

  final Person person;
  final VoidCallback onTap;
  final VoidCallback onToggleFollow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        spacing: 12.w,
        children: [
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Row(
                spacing: 12.w,
                children: [
                  UserAvatar(
                    initials: person.initials,
                    size: 48,
                    fontSize: 16,
                    style: person.avatarStyle,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          person.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          person.username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          FollowButton(
            compact: true,
            isFollowing: person.isFollowing,
            onPressed: onToggleFollow,
          ),
        ],
      ),
    );
  }
}
