import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
// import 'package:flutter_kundol/models/user.dart';
import 'package:flutter_kundol/repos/auth_repo.dart';
// import 'package:flutter_kundol/tweaks/shared_pref_service.dart';
import 'package:hive/hive.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is PerformLogin) {
      try {
        final loginResponse =
            await authRepo.loginUser(event.email, event.password);
        if (loginResponse.id != null)
          yield Authenticated(loginResponse);
        else
          yield AuthFailed("Failed");
      } on Error {
        yield AuthFailed("Failed");
      }
    } else if (event is PerformRegister) {
      try {
        final registerResponse = await authRepo.registerUser(event.firstName,
            event.lastName, event.userName, event.email, event.password);
        if (registerResponse.id != null)
          yield Authenticated(registerResponse);
        else
          yield AuthFailed("Email already registered");
      } on Error {
        yield AuthFailed("Email already registered");
      }
    } else if (event is PerformLogout) {
      try {
        var box = await Hive.openBox<WooUser>(AppConstants.TBL_USER);
        box.deleteAt(0);
        AppData.wooUser = null;
        /*final sharedPrefService = await SharedPreferencesService.instance;
        sharedPrefService.logoutUser();*/
        yield UnAuthenticated();
      } on Error {
        yield AuthFailed("Some error");
      }
    } else if (event is PerformAutoLogin) {
      yield Authenticated(event.user);
    } else if (event is PerformForgotPassword) {
      try {
        final forgotPasswordResponse =
            await authRepo.forgotPassword(event.email);
        if (forgotPasswordResponse.status == AppConstants.STATUS_SUCCESS) {
          yield EmailSent(forgotPasswordResponse.message);
        } else
          yield AuthFailed(forgotPasswordResponse.message);
      } on Error {
        yield AuthFailed("Some error");
      }
    } else if (event is PerformFacebookLogin) {
      try {
        final facebookLoginResponse =
            await authRepo.loginWithFacebook(event.accessToken);
        if (facebookLoginResponse != null) {
          yield Authenticated(facebookLoginResponse);
        } else
          yield AuthFailed("Failed");
      } on Error {
        yield AuthFailed("Failed");
      }
    } else if (event is PerformGoogleLogin) {
      /*try {
        final googleLoginResponse = await authRepo.loginWithGoogle(event.accessToken);
        if (googleLoginResponse.status == AppConstants.STATUS_SUCCESS) {
          yield Authenticated(googleLoginResponse.data);
        }
        else
          yield AuthFailed(googleLoginResponse.message);
      } on Error {
        yield AuthFailed("Some error");
      }*/
    }
  }
}
