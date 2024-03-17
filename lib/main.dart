import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/searcher_cubit.dart';
import 'package:repositories_searcher/resource/app_fonts.dart';
import 'package:repositories_searcher/screens/favorite_screen.dart';
import 'package:repositories_searcher/screens/search_screen.dart';
import 'package:repositories_searcher/screens/splash_screen.dart';
import 'package:repositories_searcher/theme/colors/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearcherCubit(),
      child: MaterialApp(
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => SplashScreen(),
            '/home': (context) => SearchScreen(),
            '/favorites': (context) => const FavoriteScreen(),
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 16.0,
                fontWeight: AppFonts.bold,
                color: AppColors.textPrimary,
                letterSpacing: 0.0,
              ),
              bodyMedium: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 14.0,
                fontWeight: AppFonts.regular,
                color: AppColors.textPlaceholder,
                letterSpacing: 0.0,
              ),
              displayMedium: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 14.0,
                fontWeight: AppFonts.regular,
                color: AppColors.textPrimary,
                letterSpacing: 0.0,
              ),
              labelLarge: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 16.0,
                fontWeight: AppFonts.bold,
                color: AppColors.accentPrimary,
                letterSpacing: 0.0,
              ),
            ),
            scaffoldBackgroundColor: AppColors.backgroundMain,
          )
          // home: SearchScreen()
          ),
    );
  }
}
