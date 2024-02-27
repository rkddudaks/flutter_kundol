// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/blocs/address/address_bloc.dart';
// import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/profile/update_profile_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:flutter_kundol/tweaks/shared_pref_service.dart';
// import 'package:flutter_kundol/ui/shipping_screen.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();

    _firstNameController.text = AppData.wooUser!.firstName!;
    _lastNameController.text = AppData.wooUser!.lastName!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).cardColor,
        title:
            Text("Edit Profile", style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
            horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
        child: Column(
          children: [
            Container(
              height: 45,
              child: TextField(
                autofocus: false,
                controller: _firstNameController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? AppStyles.COLOR_LITE_GREY_DARK
                        : AppStyles.COLOR_LITE_GREY_LIGHT,
                    filled: true,
                    // border: InputBorder.none,
                    hintText: "First Name",
                    hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
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
                controller: _lastNameController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? AppStyles.COLOR_LITE_GREY_DARK
                        : AppStyles.COLOR_LITE_GREY_LIGHT,
                    filled: true,
                    // border: InputBorder.none,
                    hintText: "Last Name",
                    hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
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
                controller: _passwordController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? AppStyles.COLOR_LITE_GREY_DARK
                        : AppStyles.COLOR_LITE_GREY_LIGHT,
                    filled: true,
                    // border: InputBorder.none,
                    hintText: "Password",
                    hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
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
                autofocus: false,
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? AppStyles.COLOR_LITE_GREY_DARK
                        : AppStyles.COLOR_LITE_GREY_LIGHT,
                    filled: true,
                    // border: InputBorder.none,
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
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
            BlocConsumer<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Container(
                    height: 40.0,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ))),
                        onPressed: () {
                          if (_firstNameController.text.isNotEmpty &&
                              _lastNameController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty &&
                              _confirmPasswordController.text.isNotEmpty)
                            BlocProvider.of<ProfileBloc>(context).add(
                                UpdateProfile(
                                    _firstNameController.text,
                                    _lastNameController.text,
                                    _passwordController.text,
                                    _confirmPasswordController.text));
                        },
                        child: Text("Update")),
                  );
                }
              },
              listener: (context, state) async {
                if (state is ProfileUpdated) {
                  setState(() {
                    AppData.wooUser!.firstName =
                        state.updateProfileResponse.data!.customerFirstName;
                    AppData.wooUser!.lastName =
                        state.updateProfileResponse.data!.customerLastName;
                  });

                  final sharedPrefService =
                      await SharedPreferencesService.instance;
                  await sharedPrefService!.setUserFirstName(
                      state.updateProfileResponse.data!.customerFirstName!);
                  await sharedPrefService.setUserLastName(
                      state.updateProfileResponse.data!.customerLastName!);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.updateProfileResponse.message!)));
                } else if (state is ProfileError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error!)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
