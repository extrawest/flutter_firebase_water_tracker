import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/common/constants.dart';

class LoginScaffold<B extends StateStreamable<S>, S> extends StatelessWidget {
  final Widget child;
  final Function(BuildContext, S) listener;

  const LoginScaffold({
    Key? key,
    required this.listener,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<B, S>(
        listener: listener,
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
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.horizontalPadding,
                  ),
                  child: SafeArea(child: child),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
