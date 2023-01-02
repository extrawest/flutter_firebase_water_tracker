import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/common/routes.dart';
import 'package:water_tracker_app/features/feature_home/repositories/account_repository.dart';
import 'package:water_tracker_app/features/feature_home/screens/account_screen/account_state.dart';

import 'account_cubit.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  void dispose() {
    context.read<AccountCubit>().dispose();
    super.dispose();
  }

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
              leading: const BackButton(),
              title: const Text('User info'),
            ),
            body: SafeArea(
              child: state.status == AccountStatus.success
                  ? Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          if (state.user!.photoUrl.isNotEmpty) CircleAvatar(
                                  radius: 64,
                                  backgroundImage:
                                      NetworkImage(state.user!.photoUrl),
                                ) else const CircleAvatar(
                                  radius: 64,
                                  child: Icon(Icons.person),
                                ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () async {
                            },
                            child: const Text('Upload Photo'),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            state.user!.name ?? 'No name',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            state.user!.email ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 14),
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
