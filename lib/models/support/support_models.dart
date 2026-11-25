// ignore_for_file: deprecated_member_use
/// One question + answer in the "Frequently asked" list.
/// The texts currently come from the design (see SupportController).
class FaqModel {
  final int id;
  final String question;
  final String answer;

  const FaqModel({
    required this.id,
    required this.question,
    required this.answer,
  });
}

/// What the user sends from "Contact us" / "Report a problem".
///
/// BACKEND INTEGRATION: the design has no form yet, so the real fields
/// (subject? category? screenshot?) are unknown. Only a message is assumed.
class SupportRequestModel {
  final String message;

  const SupportRequestModel({required this.message});

  // Map<String, dynamic> toJson() {
  //   // TODO(backend): map the real keys here
  // }
}
