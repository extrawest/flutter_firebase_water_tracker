import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/common/routes.dart';
import 'package:water_tracker_app/features/feature_home/repositories/account_repository.dart';
import 'package:water_tracker_app/features/feature_home/screens/account_screen/account_state.dart';

import 'account_cubit.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AccountCubit(RepositoryProvider.of<AccountRepositoryImpl>(context))
            ..initScreen(),
      child: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () async {
                  await context
                      .read<AccountCubit>()
                      .dispose()
                      .then((_) => Navigator.of(context).pop());
                },
              ),
              title: const Text('User info'),
            ),
            body: SafeArea(
              child: state.status == AccountStatus.success
                  ? Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          if (state.user!.photoUrl.isNotEmpty)
                            CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  NetworkImage(state.user!.photoUrl),
                            )
                          else
                            const CircleAvatar(
                              radius: 64,
                              child: Icon(Icons.person),
                            ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () async {
                              await context.read<AccountCubit>().uploadPhoto();
                            },
                            child: const Text('Upload Photo'),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            state.user!.name,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            state.user!.email,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 14),
                          ),
                          IconButton(
                            onPressed: () async {
                              final cubit = context.read<AccountCubit>();
                              final intake = await cubit.getOverallWaterIntake();
                              final uri = await cubit.createDynamicLink(path: '?intake=$intake');
                              Clipboard.setData(ClipboardData(text: uri.toString())).then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Link copied to clipboard'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              });
                            },
                            icon: const Icon(Icons.share),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              context.read<AccountCubit>().signOut();
                              Navigator.of(context)
                                  .pushReplacementNamed(signInScreenRoute);
                            },
                            child: const Text('Sign Out'),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
