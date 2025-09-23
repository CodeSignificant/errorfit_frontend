import 'dart:convert';

import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/core/network/api/secure_call.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

import '../../../resources/actions.dart';
import '../../../resources/data_response.dart';
import '../../api/api_sheet.dart';

class AuthRepo {


  static Future<DataResponse> signInWithGoogle() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      // if (kIsWeb) {
      // For web, use Firebase Auth's signInWithPopup
      final GoogleAuthProvider authProvider = GoogleAuthProvider();
      authProvider.addScope('email');
      UserCredential? userCredential;
      if (kIsWeb) {
        userCredential = await auth.signInWithPopup(authProvider);
      } else {
        userCredential = await auth.signInWithProvider(authProvider);
      }
      final User? user = userCredential.user;
      if (user == null) {
        return DataFailed('Sign-in did not return a valid user.');
      }
      final idToken = await user.getIdToken();
      if (idToken == null) {
        return DataFailed('Sign-in did not return a valid user.');
      }
      return await verifyGoogleLogin(idToken: idToken);
      // } else {
      //
      //   try{
      //     final googleProvider = GoogleAuthProvider();
      //     // Request extra scopes if you need
      //     googleProvider.addScope('email');
      //     googleProvider.addScope('profile');
      //     // This works on Android/iOS/Web with FirebaseAuth
      //     final userCredential =
      //     await FirebaseAuth.instance.signInWithProvider(googleProvider);
      //     final User? user = userCredential.user;
      //     if (user == null) {
      //       return DataFailed('Sign-in did not return a valid user.');
      //     }
      //     final idToken = await user.getIdToken();
      //     if(idToken == null){
      //       return DataFailed('Sign-in did not return a valid user.');
      //     }
      //     return await verifyGoogleLogin(idToken: idToken);
    } catch (e) {
      return DataFailed("Something went wrong $e");
    }
  }

  static Future<DataResponse> verifyGoogleLogin(
      {required String idToken}) async {
    try {
      final response = await http.post(
        Uri.parse(ApiSheet.auth.verifyGoogleLogin),
        body: jsonEncode(
            {"device": await getUniqueDeviceName(), "id_token": idToken}),
      );
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      Auth.setToken(res['token'] ?? "");
      return DataSuccess(res['message'] ?? "Created successfully");
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  static Future<DataResponse> mailOTPLogin({required String mail}) async {
    try {
      final response = await http.post(
        Uri.parse(ApiSheet.auth.mailOTP),
        body: jsonEncode({"mail": mail}),
      );
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      final data = res['token'];
      return DataSuccess(data);
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  static Future<DataResponse> phoneOTPLogin({required String phone}) async {
    try {
      final response = await http.post(
        Uri.parse(ApiSheet.auth.phoneOTP),
        body: jsonEncode({"phone": phone, "country_code": "+91"}),
      );
      final res = jsonDecode(response.body);
      trace(response.body.toString());
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      final data = res['token'];
      return DataSuccess(data);
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  static Future<DataResponse> verifyOTP({
    required String otp,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiSheet.auth.verifyOTP),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"otp": otp, "device": await getUniqueDeviceName()}),
      );
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      Auth.setToken(res['token'] ?? "");
      return DataSuccess(res['message'] ?? "");
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  static Future<DataResponse> info() async {
    try {
      final response = await SecureCall.get(
          Uri.parse(ApiSheet.auth.info));
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      Auth.setUser(name: res['name'] ?? "",
          mail: res['mail'] ?? "",
          countryCode: res['country_code'] ?? "",
          phone: res['phone'] ?? "",
          gender: res['gender'] ?? "");
      return DataSuccess(res['message'] ?? "Fetch");
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  static Future<DataResponse> logout() async {
    try {
      final response = await SecureCall.get(
          Uri.parse(ApiSheet.auth.logout));
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      return DataSuccess(res['message'] ?? "Logged Out");
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }
  static Future<DataResponse> logoutAll() async {
    try {
      final response = await SecureCall.get(
          Uri.parse(ApiSheet.auth.logoutAll));
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      return DataSuccess(res['message'] ?? "LoggedOut All");
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  // static Future<DataResponse> getUserDetails() async {
  //   try {
  //     final response = await SecureCall.get(
  //       Uri.parse(ApiSheet.common.userDetails),
  //     );
  //     final res = jsonDecode(response.body);
  //     if (res['status'] != "success") {
  //       return DataFailed(res['message'] ?? "No response");
  //     }
  //     final data = res['data'];
  //     Auth.setUser(
  //       fName: data['firstName'] ?? "name",
  //       lName: data['lastName'] ?? "",
  //       mail: data['email'] ?? "",
  //       name: data['username'] ?? "",
  //       phone: data['phoneNumber'] ?? "",
  //       referral: data['referralCode'] ?? "",
  //       roleName: data['roleName'] ?? "",
  //       rollId: data['roleId'] ?? 0,
  //     );
  //     return DataSuccess(res['message']);
  //   } catch (e) {
  //     trace(e.toString());
  //     return const DataFailed("Something went wrong");
  //   }
  // }
}
