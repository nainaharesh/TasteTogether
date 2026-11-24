// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/models/comment_model.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/common/user_avatar.dart';

/// Aik comment (replies samet). Reply par sirf username + text dikhta hai.
class CommentTile extends StatelessWidget {
  const CommentTile({
    super.key,
    required this.comment,
    required this.onLike,
    this.onReply,
  });

  final Comment comment;
  final VoidCallback onLike;
  final VoidCallback? onReply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.w,
        children: [
          UserAvatar(
            initials: comment.initials,
            size: 36,
            fontSize: 13,
            style: comment.avatarStyle,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NameLine(comment: comment),
                _Body(text: comment.text),
                SizedBox(
                  height: 44.h,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onReply,
                      child: Text(
                        'Reply',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                ),
                for (final reply in comment.replies) _ReplyTile(reply: reply),
              ],
            ),
          ),
          // like button 44 x 44
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onLike,
            child: SizedBox(
              width: 44.r,
              height: 44.r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    comment.isLiked ? Icons.favorite : Icons.favorite_border,
                    size: 18.r,
                    color: comment.isLiked
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                  Text(
                    '${comment.likes}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NameLine extends StatelessWidget {
  const _NameLine({required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6.w,
      children: [
        Flexible(
          child: Text(
            comment.username,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        if (comment.isAuthor)
          Container(
            height: 18.h,
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: Text(
              'Author',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        Text(
          '· ${comment.timeAgo}',
          maxLines: 1,
          style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          height: 21 / 14,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _ReplyTile extends StatelessWidget {
  const _ReplyTile({required this.reply});

  final Comment reply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.w,
        children: [
          UserAvatar(
            initials: reply.initials,
            size: 28,
            fontSize: 11,
            style: reply.avatarStyle,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NameLine(comment: reply),
                _Body(text: reply.text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
