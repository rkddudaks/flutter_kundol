// import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_kundol/api/wooResponses/woo_user.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/tweaks/app_localization.dart';
// import 'package:flutter_kundol/tweaks/shared_pref_service.dart';
import 'package:flutter_kundol/ui/forgot_screen.dart';
import 'package:flutter_kundol/ui/widgets/dialog_utils.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _signInEmailController = new TextEditingController();
    TextEditingController _signInPasswordController =
        new TextEditingController();
    TextEditingController _signUpFirstNameController =
        new TextEditingController();
    TextEditingController _signUpLastNameController =
        new TextEditingController();
    TextEditingController _signUpUserNameController =
        new TextEditingController();
    TextEditingController _signUpEmailController = new TextEditingController();
    TextEditingController _signUpPasswordController =
        new TextEditingController();
    TextEditingController _signUpConfirmPasswordController =
        new TextEditingController();

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) => DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 160.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                iconTheme: Theme.of(context).iconTheme,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                        AppLocalizations.of(context)!
                            .translate('welcome_back')!,
                        style: Theme.of(context).textTheme.bodyLarge)),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                        width: 1.0, color: Theme.of(context).primaryColor),
                    insets: EdgeInsets.symmetric(horizontal: 65.0),
                  ),
                  labelStyle: TextStyle(),
                  unselectedLabelColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? AppStyles.COLOR_GREY_DARK
                          : AppStyles.COLOR_GREY_LIGHT,
                  labelColor: Theme.of(context).primaryColor,
                  tabs: [
                    Tab(
                      text: AppLocalizations.of(context)!.translate('sign_in'),
                    ),
                    Tab(
                      text: AppLocalizations.of(context)!.translate('sign_up'),
                    ),
                  ],
                )),
                pinned: true,
              ),
            ],
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                        horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                    child: Column(
                      children: [
                        Container(
                          height: 45,
                          child: TextField(
                            autofocus: false,
                            controller: _signInEmailController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                                filled: true,
                                // border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!
                                    .translate('email_hint'),
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Container(
                          height: 45,
                          child: TextField(
                            obscureText: true,
                            autofocus: false,
                            controller: _signInPasswordController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                                filled: true,
                                // border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!
                                    .translate('password_hint'),
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgotScreen(),
                                      ));
                                },
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .translate('forgot_password')!,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Container(
                          height: 40.0,
                          width: double.maxFinite,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ))),
                              onPressed: () {
                                DialogUtils.showLoaderDialog(context);
                                BlocProvider.of<AuthBloc>(context).add(
                                    PerformLogin(_signInEmailController.text,
                                        _signInPasswordController.text));
                              },
                              child: Text(AppLocalizations.of(context)!
                                  .translate('sign_in')!)),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Container(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT,
                                width: 50.0,
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate('or_sign_in_with')!,
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppStyles.COLOR_GREY_DARK
                                      : AppStyles.COLOR_GREY_LIGHT,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT,
                                width: 50.0,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                DialogUtils.showLoaderDialog(context);
                                signInFB(context);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_facebook.svg"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('facebook')!,
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_GREY_DARK
                                          : AppStyles.COLOR_GREY_LIGHT,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                doGoogleLogin(context);
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/ic_google.svg"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('google')!,
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_GREY_DARK
                                          : AppStyles.COLOR_GREY_LIGHT,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .translate('login_message')!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                        horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                    child: Column(
                      children: [
                        Container(
                          height: 45,
                          child: TextField(
                            autofocus: false,
                            controller: _signUpFirstNameController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                                filled: true,
                                // border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!
                                    .translate('first_name'),
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Container(
                          height: 45,
                          child: TextField(
                            autofocus: false,
                            controller: _signUpLastNameController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                                filled: true,
                                // border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!
                                    .translate('last_name'),
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Container(
                          height: 45,
                          child: TextField(
                            autofocus: false,
                            controller: _signUpUserNameController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                                filled: true,
                                // border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!
                                    .translate('user_name'),
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Container(
                          height: 45,
                          child: TextField(
                            autofocus: false,
                            controller: _signUpEmailController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                                filled: true,
                                // border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!
                                    .translate('email'),
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Container(
                          height: 45,
                          child: TextField(
                            obscureText: true,
                            autofocus: false,
                            controller: _signUpPasswordController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                                filled: true,
                                // border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!
                                    .translate('password'),
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Container(
                          height: 45,
                          child: TextField(
                            obscureText: true,
                            autofocus: false,
                            controller: _signUpConfirmPasswordController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                fillColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                                filled: true,
                                // border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!
                                    .translate('confirm_password'),
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          height: 40.0,
                          width: double.maxFinite,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ))),
                              onPressed: () {
                                if (_signUpPasswordController.text ==
                                    _signUpConfirmPasswordController.text) {
                                  DialogUtils.showLoaderDialog(context);
                                  BlocProvider.of<AuthBloc>(context).add(
                                      PerformRegister(
                                          _signUpFirstNameController.text,
                                          _signUpLastNameController.text,
                                          _signUpUserNameController.text,
                                          _signUpEmailController.text,
                                          _signUpPasswordController.text));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Password doesn't match!")));
                                }
                              },
                              child: Text(AppLocalizations.of(context)!
                                  .translate('sign_up')!)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        listener: (context, state) async {
          if (state is Authenticated) {
            Navigator.pop(context); // for dialog
            AppData.wooUser = state.user;
            var box = await Hive.openBox<WooUser>(AppConstants.TBL_USER);
            if (box.values.toList().isEmpty) {
              box.add(state.user!);
            } else {
              box.putAt(0, state.user!);
            }
            //AppData.user = state.user;
            //AppData.accessToken = state.user.token;
            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Welcome " + state.user.firstName)));

            //final sharedPrefService = await SharedPreferencesService.instance;
            //await sharedPrefService.setUserID(state.user.id);
            //await sharedPrefService.setUserFirstName(state.user.firstName);
            //await sharedPrefService.setUserLastName(state.user.lastName);
            //await sharedPrefService.setUserEmail(state.user.email);
            //await sharedPrefService.setUserToken(state.user.token);

            Navigator.pop(context);
          } else if (state is UnAuthenticated) {
            AppData.wooUser = null;
            AppData.accessToken = null;
            Navigator.pop(context);
          } else if (state is EmailSent) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          } else if (state is AuthFailed) {
            Navigator.pop(context); // for dialog
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
      ),
    );
  }

  void doGoogleLogin(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      DialogUtils.showLoaderDialog(context);
      signInWithGoogle(context, _googleSignIn, _auth);
    } on Exception catch (error) {
      print(error);
    }
  }

  void signInWithGoogle(BuildContext context, GoogleSignIn _googleSignIn,
      FirebaseAuth _auth) async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    String accessToken = googleSignInAuthentication.accessToken!;

    print("Google AccessToken :  " + accessToken);

    BlocProvider.of<AuthBloc>(context).add(PerformGoogleLogin(accessToken));

    /*final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential authResult = await _auth.signInWithCredential(credential);

    var _user = authResult.user;
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);
    User currentUser = _auth.currentUser;
    assert(_user.uid == currentUser.uid);
    //model.state =ViewState.Idle;
    print("User Name: ${_user.displayName}");
    print("User Email ${_user.email}");

    return await FirebaseAuth.instance.signInWithCredential(credential);*/
  }

  void signInFB(BuildContext context) async {
    final fb = FacebookLogin();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken accessToken = res.accessToken!;
        print('Access token: ${accessToken.token}');
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');
        final email = await fb.getUserEmail();
        if (email != null) print('And your email is $email');

        BlocProvider.of<AuthBloc>(context)
            .add(PerformFacebookLogin(accessToken.token));

        print("ACCESS TOKEN = " + accessToken.token);

        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        print('Error while log in: ${res.error}');
        break;
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => 35.0;

  @override
  double get maxExtent => 35.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
