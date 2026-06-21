import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/user_profile.dart';

class AuthState extends ChangeNotifier {
  static const String _keyOnboardingCompleted = 'onboarding_completed';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserName = 'user_name';
  static const String _keyUserUniversity = 'user_university';
  static const String _keySelectedTab = 'selected_tab';

  UserProfile _profile = UserProfile.empty();
  bool _isOnboardingCompleted = false;
  bool _isLoggedIn = false;
  bool _isInitialized = false;
  int _selectedTab = 0;

  // Getters
  UserProfile get profile => _profile;
  String get studentName => _profile.name;
  String get universityName => _profile.university;
  String get collegeName => _profile.college;
  bool get isOnboardingCompleted => _isOnboardingCompleted;
  bool get isLoggedIn => _isLoggedIn;
  bool get isInitialized => _isInitialized;
  int get selectedTab => _selectedTab;

  AuthState() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isOnboardingCompleted = prefs.getBool(_keyOnboardingCompleted) ?? false;
    _isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;
    _selectedTab = prefs.getInt(_keySelectedTab) ?? 0;
    
    final name = prefs.getString(_keyUserName) ?? '';
    final university = prefs.getString(_keyUserUniversity) ?? '';
    
    if (name.isNotEmpty || university.isNotEmpty) {
      _profile = UserProfile(
        name: name,
        university: university,
        college: 'Default College',
      );
    }
    
    _isInitialized = true;
    notifyListeners();
  }

  // Set onboarding data
  Future<void> setOnboarding({required String name, required String university}) async {
    _profile = UserProfile(
      name: name,
      university: university,
      college: 'Default College',
    );
    _isOnboardingCompleted = true;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingCompleted, true);
    await prefs.setString(_keyUserName, name);
    await prefs.setString(_keyUserUniversity, university);
    
    notifyListeners();
  }

  // Update profile data
  Future<void> updateProfile({required String name, required String university, required String college}) async {
    _profile = UserProfile(
      name: name,
      university: university,
      college: college,
    );
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
    await prefs.setString(_keyUserUniversity, university);
    
    notifyListeners();
  }

  // Set login status
  Future<void> setLogin(bool loggedIn) async {
    _isLoggedIn = loggedIn;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, loggedIn);
    
    notifyListeners();
  }

  // Set selected tab
  Future<void> setSelectedTab(int index) async {
    _selectedTab = index;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keySelectedTab, index);
    
    notifyListeners();
  }

  // Reset state (Logout)
  Future<void> logout() async {
    _profile = UserProfile.empty();
    _isOnboardingCompleted = false;
    _isLoggedIn = false;
    _selectedTab = 0;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
  }
}
