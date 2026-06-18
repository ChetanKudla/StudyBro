import 'package:flutter/material.dart';
import '../domain/user_profile.dart';

class AuthState extends ChangeNotifier {
  UserProfile _profile = UserProfile.empty();
  bool _isOnboardingCompleted = false;
  bool _isLoggedIn = false;

  // Getters
  UserProfile get profile => _profile;
  String get studentName => _profile.name;
  String get universityName => _profile.university;
  String get collegeName => _profile.college;
  bool get isOnboardingCompleted => _isOnboardingCompleted;
  bool get isLoggedIn => _isLoggedIn;

  // Set onboarding data
  void setOnboarding({required String name, required String university}) {
    _profile = UserProfile(
      name: name,
      university: university,
      college: 'Default College',
    );
    _isOnboardingCompleted = true;
    notifyListeners();
  }

  // Update profile data
  void updateProfile({required String name, required String university, required String college}) {
    _profile = UserProfile(
      name: name,
      university: university,
      college: college,
    );
    notifyListeners();
  }

  // Set login status
  void setLogin(bool loggedIn) {
    _isLoggedIn = loggedIn;
    notifyListeners();
  }

  // Reset state (Logout)
  void logout() {
    _profile = UserProfile.empty();
    _isOnboardingCompleted = false;
    _isLoggedIn = false;
    notifyListeners();
  }
}
