import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class Empty_Screen extends StatelessWidget {
  const Empty_Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Color(0xffF6F6F6),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          child: AspectRatio(
              aspectRatio: 1/1,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/empty_img.svg"),
                  SizedBox(height: 30,),
                  Text("Currently there are no rewards available")
                ],
              )
          ),
        ),
      ),
    );
  }
}
