import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/common/routes.dart';
import 'package:water_tracker_app/features/feature_login/repositories/login_repository.dart';
import 'package:water_tracker_app/features/feature_login/screens/signup_screen/signup_cubit.dart';
import 'package:water_tracker_app/features/feature_login/screens/signup_screen/signup_state.dart';

import '../../../../common/constants.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/form_input.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<SignUpCubit>(
      create: (context) => SignUpCubit(
        loginRepository: RepositoryProvider.of<LoginRepositoryImpl>(context),
      ),
      child: Builder(
        builder: (context) {
          final cubit = context.read<SignUpCubit>();
          return Scaffold(
            body: BlocListener<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state.error.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      duration: const Duration(seconds: 5),
                    ),
                  );
                }
              },
              child: GestureDetector(
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
                              FormInput(
                                label: 'Name',
                                hint: 'Enter your Name',
                                icon: Icons.email,
                                onChanged: cubit.onNameChanged,
                              ),
                              const SizedBox(height: 16),
                              FormInput(
                                  label: 'Email',
                                  hint: 'Enter your email',
                                  icon: Icons.email,
                                  onChanged: cubit.onEmailChanged),
                              const SizedBox(height: 16),
                              FormInput(
                                  label: 'Password',
                                  hint: 'Enter your password',
                                  icon: Icons.lock,
                                  isPassword: true,
                                  onHidePassword: context
                                      .read<SignUpCubit>()
                                      .togglePasswordObscure,
                                  isPasswordObscured: context
                                      .watch<SignUpCubit>()
                                      .state
                                      .isPasswordObscured,
                                  onChanged: cubit.onPasswordChanged),
                              const SizedBox(height: 16),
                              FormInput(
                                  label: 'Confirm Password',
                                  hint: 'Confirm your password',
                                  icon: Icons.lock,
                                  isPassword: true,
                                  onHidePassword: cubit.togglePasswordObscure,
                                  isPasswordObscured: context
                                      .watch<SignUpCubit>()
                                      .state
                                      .isPasswordObscured,
                                  onChanged: cubit.onConfirmPasswordChanged),
                              const SizedBox(height: 32),
                              AuthButton(
                                text: 'REGISTER',
                                onPressed: () {
                                  cubit.onRegisterButtonPressed();
                                  Navigator.of(context)
                                      .pushReplacementNamed(homeScreenRoute);
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
                                          .pushReplacementNamed(
                                              signInScreenRoute);
                                    },
                                    child: Text(
                                      'Sign In',
                                      style:
                                          theme.textTheme.subtitle1?.copyWith(
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
        },
      ),
    );
  }
}
