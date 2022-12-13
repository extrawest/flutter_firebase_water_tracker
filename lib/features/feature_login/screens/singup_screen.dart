import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/common/routes.dart';

import '../../../common/constants.dart';
import '../cubit/login_cubit.dart';
import '../widgets/auth_button.dart';
import '../widgets/form_input.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: Scaffold(
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
                          'Sign Up',
                          style: theme.textTheme.headline2,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        const FormInput(
                          label: 'Name',
                          hint: 'Enter your Name',
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 16),
                        const FormInput(
                          label: 'Confirm Password',
                          hint: 'Confirm your password',
                          icon: Icons.lock,
                          isPassword: true,
                        ),
                        const SizedBox(height: 32),
                        AuthButton(
                          text: 'REGISTER',
                          onPressed: () {
                            //TODO: implement login
                          },
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Have an account?',
                              style: theme.textTheme.subtitle1,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(signInScreenRoute);
                              },
                              child: Text(
                                'Sign In',
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
      ),
    );
  }
}
