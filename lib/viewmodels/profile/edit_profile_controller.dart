import 'dart:io';
// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


// BACKEND INTEGRATION: uncomment together with the API code below.
// import '../../models/profile/profile_model.dart';
// import '../../services/api_services.dart';
// import '../../utils/api_endpoints.dart';

/// ViewModel of the Edit Profile screen.
class EditProfileController extends GetxController {
  static const int bioMaxLength = 160; // "66 / 160" counter in the design

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();

  /// true while loading / saving -> the button shows a spinner.
  final isLoading = false.obs;

  /// The photo the user just picked (null = none picked, show initials).
  /// Rxn = a reactive variable that is allowed to be null.
  final pickedImage = Rxn<File>();

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  // ---------------------------------------------------------------------------
  // Load the current profile and fill the fields
  // ---------------------------------------------------------------------------
  Future<void> loadProfile() async {
    // BACKEND INTEGRATION (Get profile)
    // Needed from backend: URL, response format (name, username, bio, avatar).
    // Until then the fields stay empty: no fake profile is shown.
    //
    // isLoading.value = true;
    // try {
    //   // final response = await ApiServices.get(ApiEndpoints.profileUrl);
    //   // final profile = ProfileModel.fromJson(response.body);
    //   // nameController.text = profile.fullName;
    //   // usernameController.text = profile.username;
    //   // bioController.text = profile.bio;
    // } catch (e) {
    //   // TODO: show an error message
    // } finally {
    //   isLoading.value = false;
    // }
  }

  // ---------------------------------------------------------------------------
  // Profile photo (works locally, upload is commented out)
  // ---------------------------------------------------------------------------
  Future<void> pickPhoto() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery, // use ImageSource.camera for the camera
      maxWidth: 1024, // shrink big photos before they are shown / uploaded
      imageQuality: 80,
    );
    if (file == null) return; // user closed the picker
    pickedImage.value = File(file.path);
  }

  // ---------------------------------------------------------------------------
  // Validators
  // ---------------------------------------------------------------------------
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Full name is required';
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return 'Username is required';
    if (value.contains(' ')) return 'Username cannot contain spaces';
    return null;
  }

  // ---------------------------------------------------------------------------
  // Save changes
  // ---------------------------------------------------------------------------
  Future<void> saveProfile() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    // BACKEND INTEGRATION (Update profile + photo)
    // Needed from backend: update URL, request keys, whether the photo is sent
    // together with the text or in a separate upload request, success/error
    // format (e.g. "username already taken").
    //
    // isLoading.value = true;
    // try {
    //   // 1) text fields
    //   // final body = ProfileModel(...).toJson();
    //   // final response = await ApiServices.put(ApiEndpoints.updateProfileUrl, body);
    //
    //   // 2) photo (only if the user picked a new one)
    //   // if (pickedImage.value != null) {
    //   //   await ApiServices.uploadFile(
    //   //     ApiEndpoints.uploadProfilePhotoUrl,
    //   //     pickedImage.value!,
    //   //   );
    //   // }
    //
    //   // TODO: on success -> Get.back();
    // } catch (e) {
    //   // TODO: show an error message
    // } finally {
    //   isLoading.value = false;
    // }
  }

  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
    bioController.dispose();
    super.onClose();
  }
}