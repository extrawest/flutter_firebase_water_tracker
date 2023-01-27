import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/common/constants.dart';
import 'package:water_tracker_app/common/routes.dart';
import 'package:water_tracker_app/features/feature_login/widgets/login_scaffold.dart';
import 'package:water_tracker_app/features/feature_login/widgets/social_button.dart';

import '../../repositories/login_repository.dart';
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
      create: (context) => SignInCubit(
        loginRepository: RepositoryProvider.of<LoginRepositoryImpl>(context),
      ),
      child: Builder(
        builder: (context) {
          return LoginScaffold<SignInCubit, SignInState>(
            listener: (context, state) {
              if (state.isSignedIn) {
                Navigator.of(context).pushReplacementNamed(homeScreenRoute);
              } else if (state.error.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    duration: const Duration(seconds: 5),
                  ),
                );
              }
            },
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
                FormInput(
                  key: const Key('signInEmailInput'),
                  label: 'Email',
                  hint: 'Enter your email',
                  icon: Icons.email,
                  onChanged:
                  context.read<SignInCubit>().onEmailChanged,
                ),
                const SizedBox(height: 16),
                FormInput(
                  key: const Key('signInPasswordInput'),
                  label: 'Password',
                  hint: 'Enter your password',
                  icon: Icons.lock,
                  isPassword: true,
                  onHidePassword: context
                      .read<SignInCubit>()
                      .togglePasswordObscure,
                  isPasswordObscured: context
                      .watch<SignInCubit>()
                      .state
                      .isPasswordObscured,
                  onChanged:
                  context.read<SignInCubit>().onPasswordChanged,
                ),
                const SizedBox(height: 32),
                AuthButton(
                  key: const Key('signInButton'),
                  text: 'LOGIN',
                  onPressed:() async {
                    await context.read<SignInCubit>().onLoginPressed();
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
                      onPressed: () async {
                        await context.read<SignInCubit>().onGoogleLoginPressed();
                      },
                    ),
                    const SizedBox(width: 16),
                    SocialButton(
                      asset: Assets.facebookLogo,
                      onPressed: () async {
                        await context.read<SignInCubit>().onFacebookLoginPressed();
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
                      key: const ValueKey('signUpButton'),
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
          );
        }
      ),
    );
  }
}
