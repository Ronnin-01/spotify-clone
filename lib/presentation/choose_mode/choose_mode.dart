import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:our_spotify/common/widgets/basic_app_button.dart';
import 'package:our_spotify/core/configs/assets/app_images.dart';
import 'package:our_spotify/core/configs/assets/app_vectors.dart';
import 'package:our_spotify/core/configs/theme/app_colors.dart';
import 'package:our_spotify/presentation/auth/pages/signup_or_signin.dart';
import 'package:our_spotify/presentation/choose_mode/bloc/theme_cubit.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImages.chooseModeBG),
              ),
            ),
          ),
          Container(
            color: Colors.black.withAlpha(180),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(AppVectors.logo)),
                Spacer(),
                Text(
                  'Choose Mode',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
                SizedBox(height: 21),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ThemeCubit>()
                                .updateTheme(ThemeMode.light);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff30393c).withAlpha(100),
                                ),
                                child: SvgPicture.asset(
                                  AppVectors.lightTheme,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Light Mode',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ThemeCubit>()
                                .updateTheme(ThemeMode.dark);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff30393c).withAlpha(100),
                                ),
                                child: SvgPicture.asset(
                                  AppVectors.darkTheme,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Dark Mode',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SignupOrSignin(),
                        ),
                      );
                    },
                    title: 'Continue')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
