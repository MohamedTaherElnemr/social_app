import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social%20cubit/social_cubit.dart';
import 'package:social_app/modules/internal%20screens/Edit_profile_screen.dart';
import 'package:social_app/modules/login_screen.dart';
import 'package:social_app/shared/network/cache_helper.dart';

import '../../models/user_model.dart';
import '../../shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel? userModelProfile =
            BlocProvider.of<SocialCubit>(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4)),
                            image: DecorationImage(
                                image:
                                    NetworkImage('${userModelProfile!.cover}'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    CircleAvatar(
                      radius: 65,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage('${userModelProfile.image}'),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                '${userModelProfile.name}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text(
                '${userModelProfile.bio}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    child: Column(
                      children: [
                        Text(
                          '100',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Text(
                          'posts',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '110',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          Text(
                            'Photos',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '10K',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '250',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          Text(
                            'Followings',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () {}, child: const Text('Add Photos'))),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EditProfileScreen();
                        }));
                      },
                      child: const Icon(
                        Icons.edit,
                        size: 18,
                      )),
                ],
              ),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      // CacheHelper.deleteItem(key: 'uId');

                      // uId == '';
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }), (route) => false);
                    },
                    child: const Text('Log Out')),
              )
            ],
          ),
        );
      },
    );
  }
}
