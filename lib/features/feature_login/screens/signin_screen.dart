import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/common/constants.dart';
import 'package:water_tracker_app/features/feature_login/cubit/login_cubit.dart';
import 'package:water_tracker_app/features/feature_login/widgets/social_button.dart';

import '../widgets/auth_button.dart';
import '../widgets/form_input.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.horizontalPadding),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Sign In',
                    style: theme.textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  const FormInput(
                    label: 'Email',
                    hint: 'Enter your email',
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 16),
                  const FormInput(
                    label: 'Password',
                    hint: 'Enter your password',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(height: 32),
                  AuthButton(
                    text: 'LOGIN',
                    onPressed: () {
                      //TODO: implement login
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Or sign in with:',
                    style: theme.textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(
                        asset: Assets.googleLogo,
                        onPressed: () {
                          //TODO: Implement Google Sign In
                        },
                      ),
                      const SizedBox(width: 16),
                      SocialButton(
                        asset: Assets.facebookLogo,
                        onPressed: () {
                          //TODO: Implement Facebook Sign In
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
