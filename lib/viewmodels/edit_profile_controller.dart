// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tastetogether/models/auth/auth_models.dart';
import 'package:tastetogether/viewmodels/auth_controller.dart';



/// ViewModel of the Edit Profile screen.
/// Fields AuthController.currentUser se bharte hain, Save par PATCH /users/me.
class EditProfileController extends GetxController {
  static const int bioMaxLength = 160; // "66 / 160" counter in the design

  final AuthController auth = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();

  /// true while loading / saving -> the button shows a spinner.
  final isLoading = false.obs;

  /// The photo the user just picked (null = none picked, show initials).
  /// NOTE: backend mein photo upload ka endpoint nahi, is liye ye abhi sirf
  /// screen par dikhti hai, server par nahi jati.
  final pickedImage = Rxn<File>();

  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  /// Fields ek baar bharte hain (save ke baad user ka likha hua na mitay).
  Future<void> loadProfile() async {
    if (auth.currentUser.value == null) {
      isLoading.value = true;
      await auth.loadProfile();
      isLoading.value = false;
    }
    fillFrom(auth.currentUser.value);
  }

  void fillFrom(UserModel? user) {
    if (user == null) return;
    nameController.text = user.fullName;
    usernameController.text = user.username;
    bioController.text = user.bio;
  }

  Future<void> pickPhoto() async {
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery, // use ImageSource.camera for the camera
      maxWidth: 1024, // shrink big photos before they are shown
      imageQuality: 80,
    );
    if (file == null) return; // user closed the picker
    pickedImage.value = File(file.path);
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Full name is required';
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return 'Username is required';
    if (value.contains(' ')) return 'Username cannot contain spaces';
    return null;
  }

  /// Sirf badle hue fields bhejte hain. "Username already taken" jaisa error
  /// server ke message ke saath snackbar mein aata hai.
  Future<void> saveProfile() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final user = auth.currentUser.value;
    final name = nameController.text.trim();
    final username = usernameController.text.trim();
    final bio = bioController.text.trim();

    final changes = <String, dynamic>{
      if (user == null || name != user.fullName) 'fullName': name,
      if (user == null || username != user.username) 'username': username,
      if (user == null || bio != user.bio) 'bio': bio,
    };

    if (changes.isEmpty) {
      Get.back(); // kuch badla hi nahi
      return;
    }

    isLoading.value = true;
    final ok = await auth.updateProfile(changes);
    isLoading.value = false;

    if (ok) {
      Get.back();
      auth.showSuccess('Profile update ho gayi.');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
    bioController.dispose();
    super.onClose();
  }
}