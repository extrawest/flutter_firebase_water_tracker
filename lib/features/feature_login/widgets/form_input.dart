import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/features/feature_login/cubit/login_cubit.dart';
import 'package:water_tracker_app/features/feature_login/cubit/login_state.dart';

class FormInput extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;

  const FormInput({
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.isPasswordObscured != current.isPasswordObscured,
      builder: (context, state) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.15),
                  offset: const Offset(0, 3),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    obscureText: isPassword && state.isPasswordObscured,
                    showCursor: true,
                    cursorColor: Colors.white,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle:
                          Theme.of(context).textTheme.bodyText2?.copyWith(
                                color: Colors.white.withOpacity(0.5),
                              ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (isPassword)
                  IconButton(
                    onPressed: () {
                      context.read<LoginCubit>().togglePasswordObscure();
                    },
                    icon: Icon(
                      state.isPasswordObscured
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
