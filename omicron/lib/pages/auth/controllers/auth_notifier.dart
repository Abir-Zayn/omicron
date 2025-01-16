import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:omicron/pages/auth/models/auth_token_model.dart';
import 'package:omicron/pages/auth/models/profile_model.dart';
import 'package:omicron/pages/auth/models/signup_model.dart';
import 'package:omicron/pages/entrypoint/views/controllers/bottom_tab_notifier.dart';
import 'package:omicron/src/common/services/storage.dart';
import 'package:omicron/src/common/utils/environment.dart';
import 'package:omicron/src/widgets/flash_message.dart';
import 'package:provider/provider.dart';

class AuthNotifier with ChangeNotifier {
  bool _isLoading = false;
  ProfileModel? _userData;
  bool get isLoading => _isLoading;

  void setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  ProfileModel? getUserData() {
    if (_userData != null) {
      return _userData;
    }
    String? accessToken = Storage().getString('accessToken');
    if (accessToken == null) return null;

    try {
      var data = Storage().getString('accessToken');
      if (data != null) {
        _userData = ProfileModel.fromJson(jsonDecode(data));
        return _userData;
      }
    } catch (e) {
      Storage().removeKey(accessToken);
      Storage().removeKey('accessToken');
    }
    return null;

    // if (accessToken != null) {
    //   var data = Storage().getString(accessToken);
    //   if (data != null) {
    //     return ProfileModel.fromJson(jsonDecode(data));
    //   }
    // }
    // return null;
  }

  Future<void> getUser(String accessToken, BuildContext context) async {
    // print("Entered Get User Function");
    try {
      var url = Uri.parse("${Environment.baseUrl}/auth/users/me/");
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Token $accessToken",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        //Storing the token and user data
        Storage().setString('accessToken', accessToken);
        Storage().setString(accessToken, response.body);
        //  print('User data stored: ${response.body}');

        // Parse and cache the user data
        _userData = ProfileModel.fromJson(jsonDecode(response.body));
        notifyListeners();

        context.read<TabIndexNotifier>().setIndex(0);
        context.go('/home');
      } else {
        throw Exception('Failed to get user: ${response.statusCode}');
      }
    } catch (e) {
      print("Error getting user: $e");
      // Clear any invalid data
      Storage().removeKey(accessToken);
      Storage().removeKey('accessToken');
      _userData = null;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: FlashMessageScreen(
            text: "Failed to get user data. Please check your connection.",
            messgaeType: MessageType.error,
            onClose: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    }
  }

  Future<void> loginFun(String data, BuildContext context) async {
    setLoading();

    try {
      var url = Uri.parse("${Environment.baseUrl}/auth/token/login");

      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: data);

      if (response.statusCode == 200) {
        String accessToken = accessTokenModelFromJson(response.body).authToken;
        //Get User Info
        await getUser(accessToken, context);
      } else {
        setLoading();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: FlashMessageScreen(
              text: "Invalid credentials. Please try again.",
              messgaeType: MessageType.error,
              onClose: () =>
                  ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        );
      }
    } catch (e) {
      setLoading();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: FlashMessageScreen(
            text: "Login failed. Please check your connection.",
            messgaeType: MessageType.error,
            onClose: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    }
  }

  void signUpFun(String data, BuildContext context) async {
    setLoading();

    try {
      var url = Uri.parse("${Environment.baseUrl}/auth/users/");
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: data);

      if (response.statusCode == 201) {
        //Successfully created user, now login
        SignUpModel signUpData = signUpModelFromJson(data);

        //Create login Data
        Map<String, String> loginData = {
          "username": signUpData.username,
          "password": signUpData.password
        };

        //Login the user
        await loginFun(jsonEncode(loginData), context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: FlashMessageScreen(
              text: "Account Created Successfully",
              messgaeType: MessageType.success,
              onClose: () =>
                  ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        );
      }
    } catch (e) {
      setLoading();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: FlashMessageScreen(
            text: "Network error. Please check your connection.",
            messgaeType: MessageType.error,
            onClose: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    }
  }

  // Add a logout method to properly clear data
  void logout(BuildContext context) {
    Storage().removeKey('user_data');
    Storage().removeKey('accessToken');
    _userData = null;
    notifyListeners();

    context.read<TabIndexNotifier>().setIndex(0);
    context.go('/home');
  }
}
