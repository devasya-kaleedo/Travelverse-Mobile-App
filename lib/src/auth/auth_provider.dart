import 'package:flutter/material.dart';
import 'package:travelverse_mobile_app/src/auth/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthProvider extends ChangeNotifier {
  /// state  of user information
  UserApp _user = const UserApp();
  UserApp get userInfo => _user;
  void setUser(UserApp user) {
    _user = user;
    notifyListeners();
  }

  void logout() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove('user');
    _user = const UserApp(); // api token is empty
    notifyListeners();
  }

  bool get isAuthorized {
    return _user.apiToken.isNotEmpty;
  }

  bool displayedOnboard = false;

  Future<bool> tryLogin() async {
    // fetch user info
    final user = await fetchUser();
    if (user != null) {
      _user = user;
      return true; // has a login record.
    }
    return false;
  }

  Future<UserApp?> fetchUser() async {
    final preferences = await SharedPreferences.getInstance();
    final userString = preferences.getString('user') ?? '';
    if (userString != '') {
      final userMap = jsonDecode(userString);

      UserApp userApp = UserApp.fromJson(userMap);
      return userApp;
    } else {
      return null;
    }
  }
}
