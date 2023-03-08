import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreen;
  final Widget desktopScreen;

  ResponsiveLayout({required this.mobileScreen, required this.desktopScreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        if (constrains.maxWidth < 700) {
          return mobileScreen;
        } else {
          return desktopScreen;
        }
      },
    );
  }
}