part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class PerformLogin extends AuthEvent {
  final String email;
  final String password;

  const PerformLogin(this.email, this.password);

  @override
  List<Object> get props => [this.email, this.password];
}

class PerformRegister extends AuthEvent {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;

  PerformRegister(
      this.firstName, this.lastName, this.userName, this.email, this.password);

  @override
  List<Object> get props =>
      [this.firstName, this.lastName, this.userName, this.email, this.password];
}

class PerformLogout extends AuthEvent {
  const PerformLogout();

  @override
  List<Object> get props => [];
}

class PerformAutoLogin extends AuthEvent {
  final WooUser? user;

  const PerformAutoLogin(this.user);

  @override
  List<Object?> get props => [this.user];
}

class PerformForgotPassword extends AuthEvent {
  final String email;

  const PerformForgotPassword(this.email);

  @override
  List<Object> get props => [email];
}

class PerformFacebookLogin extends AuthEvent {
  final String accessToken;

  const PerformFacebookLogin(this.accessToken);

  @override
  List<Object> get props => [accessToken];
}

class PerformGoogleLogin extends AuthEvent {
  final String accessToken;

  const PerformGoogleLogin(this.accessToken);

  @override
  List<Object> get props => [accessToken];
}
