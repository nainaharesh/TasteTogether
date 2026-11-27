// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/user_activity/support_models.dart';



// BACKEND INTEGRATION: uncomment together with the API code below.
// //
/// ViewModel of the Help and support screen.
class SupportController extends GetxController {
  final searchController = TextEditingController();

  /// What the user typed in "Search help articles".
  final searchQuery = ''.obs;

  /// id of the FAQ that is open (-1 = all closed). The design opens the first.
  final openFaqId = 1.obs;

  // The texts below are copied from the design.
  // TODO(backend): if FAQs are managed by the backend, load them from an API.
  final List<FaqModel> faqs = const [
    FaqModel(
      id: 1,
      question: 'How do I write a review?',
      answer: 'Tap the + button in the bottom bar, choose the restaurant, name the dish, give it a star rating and add a few words. Photos are optional.',
    ),
    FaqModel(
      id: 2,
      question: 'How are ratings calculated?',
      answer: 'A restaurant or dish rating is the average of all star ratings from reviewers. It updates whenever a new review is published.',
    ),
    FaqModel(
      id: 3,
      question: 'Can I edit or delete my review?',
      answer: 'Yes. Open your review from your profile, tap the menu and choose Edit or Delete.',
    ),
    FaqModel(
      id: 4,
      question: 'How do I report a review?',
      answer: 'Tap the menu on any review and choose Report. We look at every report and remove content that breaks the community rules.',
    ),
    FaqModel(
      id: 5,
      question: 'How do I delete my account?',
      answer: 'Go to Settings, then Privacy settings, then Delete account. This removes your profile and reviews for good.',
    ),
  ];

  /// The FAQs that match the search text (all of them when the box is empty).
  /// Called inside an Obx, so the list rebuilds when searchQuery changes.
  List<FaqModel> get filteredFaqs {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return faqs;
    return faqs
        .where(
          (faq) =>
              faq.question.toLowerCase().contains(query) ||
              faq.answer.toLowerCase().contains(query),
        )
        .toList();
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  /// Tap on a question: open it, or close it if it is already open.
  void toggleFaq(int id) {
    openFaqId.value = openFaqId.value == id ? -1 : id;
  }

  // ---------------------------------------------------------------------------
  // "Contact us" and "Report a problem" buttons
  // ---------------------------------------------------------------------------
  Future<void> contactUs() async {
    // PLACEHOLDER: the design only shows the button. What it should do is not
    // decided yet. Options:
    //  A) open a small form (message field + Send) and call the API below
    //  B) open the user's email app (needs a support email + url_launcher)
    //
    // BACKEND INTEGRATION (Submit support request)
    // Needed from backend: URL, request keys, success/error format.
    //
    // final request = SupportRequestModel(message: ...);
    // final response = await ApiServices.post(
    //   ApiEndpoints.supportRequestUrl,
    //   request.toJson(),
    // );
  }

  Future<void> reportProblem() async {
    // PLACEHOLDER: same situation as contactUs().
    //
    // BACKEND INTEGRATION (Report a problem)
    // Needed from backend: URL, request keys, whether it is the same endpoint
    // as contactUs() with a different "type".
    //
    // final response = await ApiServices.post(
    //   ApiEndpoints.reportProblemUrl,
    //   requestBody,
    // );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
