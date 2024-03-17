import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repositories_searcher/theme/colors/app_colors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
    return Scaffold(
      backgroundColor: AppColors.accentPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Search App',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: AppColors.layer1),
            ),
            const SizedBox(height: 18),
            const CupertinoActivityIndicator(color: AppColors.layer1),
          ],
        ),
      ),
    );
  }
}
