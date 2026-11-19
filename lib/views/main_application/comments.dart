// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/post_models.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/main_application_models/comments_viewmodel/comments_view_model.dart';
import 'package:tastetogether/widgets/comments/comment_tile.dart';
import 'package:tastetogether/widgets/comments/post_summary_card.dart';
import 'package:tastetogether/widgets/common/user_avatar.dart';

class Comments extends StatelessWidget {
  Comments({super.key, required this.post});

  final Post post;

  late final CommentsViewModel controller = Get.put(
    CommentsViewModel(initialCount: post.comments),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(Icons.arrow_back_rounded, size: 24.r),
        ),
        title: Row(
          spacing: 4.w,
          children: [
            Text(
              'Comments',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
            Obx(
              () => Text(
                '${controller.totalCount.value}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ],
        ),
        shape: const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      body: Column(
        children: [
          PostSummaryCard(post: post),

          // comments list
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                itemCount: controller.comments.length,
                itemBuilder: (_, i) {
                  final c = controller.comments[i];
                  return CommentTile(
                    comment: c,
                    onLike: () => controller.toggleLike(c.id),
                    // TODO: reply feature
                    onReply: () {},
                  );
                },
              ),
            ),
          ),

          // add comment bar
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                spacing: 10.w,
                children: [
                  // TODO: logged in user ke initials
                  const UserAvatar(initials: 'LH', style: 1, fontSize: 13),
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: TextField(
                        controller: controller.textController,
                        onSubmitted: (_) => controller.addComment(),
                        textInputAction: TextInputAction.send,
                        cursorColor: AppColors.primary,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Add a comment',
                          hintStyle: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.textMuted,
                          ),
                          filled: true,
                          fillColor: AppColors.background,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(999.r),
                            borderSide: const BorderSide(
                              color: AppColors.fieldBorder,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(999.r),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: AppColors.primary,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: controller.addComment,
                      child: SizedBox(
                        width: 44.r,
                        height: 44.r,
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          size: 20.r,
                          color: AppColors.surface,
                        ),
                      ),
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
