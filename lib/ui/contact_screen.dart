// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_kundol/blocs/address/address_bloc.dart';
// import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/contact_us/contact_us_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
// import 'package:flutter_kundol/repos/address_repo.dart';
// import 'package:flutter_kundol/ui/shipping_screen.dart';
// import 'package:flutter_kundol/ui/widgets/app_bar.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController _messageController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
              Text("Contact Us", style: Theme.of(context).textTheme.titleLarge),
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
              horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
          child: BlocConsumer<ContactUsBloc, ContactUsState>(
            builder: (BuildContext context, state) {
              return Column(
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
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? AppStyles.COLOR_LITE_GREY_DARK
                                  : AppStyles.COLOR_LITE_GREY_LIGHT,
                          filled: true,
                          // border: InputBorder.none,
                          hintText: "First Name",
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
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? AppStyles.COLOR_LITE_GREY_DARK
                                  : AppStyles.COLOR_LITE_GREY_LIGHT,
                          filled: true,
                          // border: InputBorder.none,
                          hintText: "Last Name",
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
                      controller: _emailController,
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
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? AppStyles.COLOR_LITE_GREY_DARK
                                  : AppStyles.COLOR_LITE_GREY_LIGHT,
                          filled: true,
                          // border: InputBorder.none,
                          hintText: "Enter your email",
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
                  TextField(
                    minLines: 5,
                    maxLines: null,
                    controller: _messageController,
                    keyboardType: TextInputType.multiline,
                    autofocus: false,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppStyles.COLOR_LITE_GREY_DARK
                                : AppStyles.COLOR_LITE_GREY_LIGHT,
                        filled: true,
                        // border: InputBorder.none,
                        hintText: "Your comment",
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT,
                            fontSize: 14)),
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
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ))),
                        onPressed: () {
                          BlocProvider.of<ContactUsBloc>(context).add(
                              SubmitContactUs(
                                  _firstNameController.text,
                                  _lastNameController.text,
                                  _emailController.text,
                                  _messageController.text));
                        },
                        child: Text("Submit")),
                  ),
                ],
              );
            },
            listener: (BuildContext context, state) {
              if (state is ContactUsLoaded) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message!)));
              } else if (state is ContactUsError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error!)));
              }
            },
          ),
        ));
  }
}
