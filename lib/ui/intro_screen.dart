import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class Intro_Screen extends StatefulWidget {
  const Intro_Screen({Key? key}) : super(key: key);

  @override
  _Intro_ScreenState createState() => _Intro_ScreenState();
}

class _Intro_ScreenState extends State<Intro_Screen> {
  PageController pageController = new PageController(initialPage: 0);
  int pageChanged = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
          children: [
            Expanded(
              child:PageView(
                controller: pageController,
                onPageChanged: (index){
                  setState(() {
                    pageChanged = index;
                  });
                  // print(pageChanged);
                },
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text("Online Shopping",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),)),
                          alignment: Alignment.topLeft,
                        ),
                        Align(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text("Online Shopping",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Color(0xff0478ED)),)),
                          alignment: Alignment.topRight,
                        ),
                        SizedBox(height: 30,),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: SvgPicture.asset("assets/images/intro_1.svg",height: 250,width: double.maxFinite,)),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: SvgPicture.asset("assets/images/intro_bar_1.svg",height: 55,width: double.maxFinite)),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text("Cook Instantly",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),)),
                          alignment: Alignment.topLeft,
                        ),
                        Align(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text("Without Any Worries",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Color(0xff0478ED)),)),
                          alignment: Alignment.topRight,
                        ),
                        SizedBox(height: 30,),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: SvgPicture.asset("assets/images/intro_2.svg",height: 250,width: double.maxFinite,)),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: SvgPicture.asset("assets/images/intro_bar_2.svg",height: 55,width: double.maxFinite)),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text("Ship at your home",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),)),
                          alignment: Alignment.topLeft,
                        ),
                        Align(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text("In no time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Color(0xff0478ED)),)),
                          alignment: Alignment.topRight,
                        ),
                        SizedBox(height: 30,),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: SvgPicture.asset("assets/images/intro_3.svg",height: 250,width: double.maxFinite,)),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: SvgPicture.asset("assets/images/intro_bar_3.svg",height: 55,width: double.maxFinite)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: double.maxFinite,
                height: 100,
                child: Column(
                  children: [
                    SizedBox(
                      width: 220,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),

                                  )
                              )
                          ),
                          onPressed: () {
                            if(pageChanged <= 2){
                              pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 1), curve: Curves.easeIn);
                            }
                            print(pageChanged);
                          },
                          child: pageChanged == 2 ? Text("Sign In") : Text("Next")
                      ),
                    ),
                    pageChanged == 2 ? Text("Home") : Text("Skip")
                  ],
                )
            ),
          ],
        )
    );
  }
}
