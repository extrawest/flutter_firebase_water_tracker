import 'package:flutter/material.dart';

import '../../../common/constants.dart';

class HomePlaceholder extends StatelessWidget {
  const HomePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: RadialGradient(
              radius: 0.4,
              colors: [
                theme.colorScheme.primary.withOpacity(0.3),
                Colors.white,
              ],
            )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.homePlaceholder),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 100,
                color: Colors.white,
                child: Text(
                  'No drinks added today',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
