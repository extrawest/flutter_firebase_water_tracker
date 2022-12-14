import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/common/constants.dart';
import 'package:water_tracker_app/common/routes.dart';
import 'package:water_tracker_app/features/feature_login/widgets/social_button.dart';

import '../../widgets/auth_button.dart';
import '../../widgets/form_input.dart';
import 'signin_cubit.dart';
import 'signin_state.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<SignInCubit>(
      create: (context) => SignInCubit(),
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) {
          return Scaffold(
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
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
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.horizontalPadding),
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
                            FormInput(
                              label: 'Password',
                              hint: 'Enter your password',
                              icon: Icons.lock,
                              isPassword: true,
                              onHidePassword: context.read<SignInCubit>().togglePasswordObscure,
                              isPasswordObscured: state.isPasswordObscured,
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
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: theme.textTheme.subtitle1,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed(signUpScreenRoute);
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: theme.textTheme.subtitle1?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
