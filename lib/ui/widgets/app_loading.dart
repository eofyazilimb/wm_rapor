import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: Image.asset(
          package: 'wm_rapor',
          "assets/wm_loading.gif",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
