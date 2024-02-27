import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/forgot_password_response.dart';
import 'package:flutter_kundol/api/responses/login_response.dart';
import 'package:flutter_kundol/api/responses/logout_response.dart';
// import 'package:flutter_kundol/api/responses/register_response.dart';
// import 'package:flutter_kundol/api/wooResponses/woo_login_response.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user.dart';

abstract class AuthRepo {
  Future<WooUser> loginUser(String userName, String password);
  Future<WooUser> loginWithFacebook(String accessToken);
  Future<LoginResponse> loginWithGoogle(String accessToken);
  Future<WooUser> registerUser(String firstName, String lastName,
      String userName, String email, String password);
  Future<LogoutResponse> logoutUser();
  Future<ForgotPasswordResponse> forgotPassword(String email);
}

class RealAuthRepo implements AuthRepo {
  ApiProvider apiProvider = ApiProvider();
  @override
  Future<WooUser> loginUser(String userName, String password) {
    return apiProvider.loginUser(userName, password);
  }

  @override
  Future<WooUser> registerUser(String firstName, String lastName,
      String userName, String email, String password) {
    return apiProvider.registerUser(
        firstName, lastName, userName, email, password);
  }

  @override
  Future<LogoutResponse> logoutUser() {
    return ApiProvider().doLogout();
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) {
    return ApiProvider().forgotPassword(email);
  }

  @override
  Future<WooUser> loginWithFacebook(String accessToken) {
    return ApiProvider().loginWithFacebook(accessToken);
  }

  @override
  Future<LoginResponse> loginWithGoogle(String accessToken) {
    return ApiProvider().loginWithGoogle(accessToken);
  }
}

class FakeAuthRepo implements AuthRepo {
  @override
  Future<WooUser> loginUser(String userName, String password) {
    throw UnimplementedError();
  }

  @override
  Future<WooUser> registerUser(String firstName, String lastName,
      String userName, String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<LogoutResponse> logoutUser() {
    throw UnimplementedError();
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) {
    throw UnimplementedError();
  }

  @override
  Future<WooUser> loginWithFacebook(String accessToken) {
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> loginWithGoogle(String accessToken) {
    throw UnimplementedError();
  }
}
