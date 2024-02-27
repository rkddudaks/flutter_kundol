import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  final Widget? leadingWidget;
  final Widget? centerWidget;
  final Widget? trailingWidget;

  MyAppBar({this.leadingWidget, this.centerWidget, this.trailingWidget});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        height: kToolbarHeight,
        child: Row(
          children: [
            (widget.leadingWidget != null)
                ? widget.leadingWidget!
                : SizedBox(
                    width: 16.0,
                  ),
            Expanded(child: (widget.centerWidget != null) ? widget.centerWidget! : SizedBox()),
            (widget.trailingWidget != null)
                ? widget.trailingWidget!
                : SizedBox(
                    width: 16.0,
                  )
          ],
        ),
      ),
    );
  }
}
