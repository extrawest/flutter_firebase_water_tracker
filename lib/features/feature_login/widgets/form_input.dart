import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final Function(String)? onChanged;
  final VoidCallback? onHidePassword;
  final bool isPasswordObscured;
  final String? errorText;

  const FormInput({
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.onChanged,
    this.onHidePassword,
    this.isPasswordObscured = true,
    this.errorText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
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
                  autocorrect: false,
                  onChanged: onChanged?.call,
                  obscureText: isPassword && isPasswordObscured,
                  showCursor: true,
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.white.withOpacity(0.5),
                        ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (isPassword)
                IconButton(
                  onPressed: onHidePassword?.call,
                  icon: Icon(
                    isPasswordObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
