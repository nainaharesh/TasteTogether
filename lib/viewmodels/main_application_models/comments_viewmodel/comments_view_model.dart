import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/comment_model.dart';

class CommentsViewModel extends GetxController {
  CommentsViewModel({required int initialCount})
    : totalCount = initialCount.obs;

  final RxList<Comment> comments = <Comment>[].obs;
  final RxInt totalCount;

  final textController = TextEditingController();
  final scrollController = ScrollController();
  final focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    loadComments();
  }

  void loadComments() {
    // TODO: Get data from api// (postId se comments aayenge)
    // dumy data///
    comments.assignAll(dummyComments);
  }

  void addComment() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    // TODO: API - comment post karna
    comments.add(
      Comment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: 'you', // TODO: logged in user se aayega
        initials: 'LH',
        text: text,
        timeAgo: 'now',
        avatarStyle: 1,
      ),
    );
    totalCount.value++;
    textController.clear();

    // naya comment dikhane ke liye neeche scroll
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// "Reply" dabane par input mein @username aa jata hai aur keyboard khulta hai
  void startReply(String username) {
    // TODO: API - parent comment id bhi bhejni hogi (threaded reply)
    textController.text = '@$username ';
    textController.selection = TextSelection.collapsed(
      offset: textController.text.length,
    );
    focusNode.requestFocus();
  }

  void toggleLike(String id) {
    final i = comments.indexWhere((c) => c.id == id);
    if (i == -1) return;
    final c = comments[i];
    // TODO: API - like/unlike comment
    comments[i] = c.copyWith(
      isLiked: !c.isLiked,
      likes: c.isLiked ? c.likes - 1 : c.likes + 1,
    );
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
