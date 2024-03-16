import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:repositories_searcher/bloc/cubit/searcher_cubit.dart';
import 'package:repositories_searcher/resource/app_fonts.dart';
import 'package:repositories_searcher/screens/search_screen.dart';
import 'package:repositories_searcher/theme/colors/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearcherCubit>(create: (context) => SearcherCubit()),
        BlocProvider<FavoriteCubit>(create: (context) => FavoriteCubit()),
      ],
      child: MaterialApp(
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
                fontWeight: AppFonts.regular,
                color: AppColors.accentPrimary,
                letterSpacing: 0.0,
              ),
            ),
            scaffoldBackgroundColor: AppColors.backgroundMain,
          ),
          home: SearchScreen()),
    )
        //   ,
        // )
        ;
  }
}
