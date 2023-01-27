import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  final String asset;
  final VoidCallback onPressed;

  const SocialButton({
    required this.asset,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        shadowColor: MaterialStateProperty.all(
          Colors.black54.withOpacity(0.5),
        ),
        elevation: MaterialStateProperty.all(9),
      ),
      onPressed: onPressed,
      icon: SvgPicture.asset(asset, width: 24, height: 24),
    );
  }
}
