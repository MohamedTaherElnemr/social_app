// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social%20cubit/social_cubit.dart';
import 'package:social_app/shared/components/custome_text_form_field.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var userModelProfile2 = BlocProvider.of<SocialCubit>(context).userModel;
        var profileImage = BlocProvider.of<SocialCubit>(context).profileImage;
        var coverImage = BlocProvider.of<SocialCubit>(context).coverImage;

        nameController.text = userModelProfile2!.name;
        bioController.text = userModelProfile2.bio!;
        phoneController.text = userModelProfile2.phone;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            title: const Text(
              'Edit Profile',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    BlocProvider.of<SocialCubit>(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);

                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.black,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
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
                          child: Stack(
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight: Radius.circular(4)),
                                    image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage(
                                                '${userModelProfile2.cover}')
                                            : FileImage(coverImage)
                                                as ImageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<SocialCubit>(context)
                                      .getCoverImage();
                                },
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModelProfile2.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                BlocProvider.of<SocialCubit>(context)
                                    .getProfileImage();
                              },
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  if (coverImage != null || profileImage != null)
                    Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8)),
                                child: MaterialButton(
                                  onPressed: () {
                                    BlocProvider.of<SocialCubit>(context)
                                        .uploadProfileImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text);
                                  },
                                  child: const Text(
                                    'Update Profile Image',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8)),
                                child: MaterialButton(
                                  onPressed: () {
                                    BlocProvider.of<SocialCubit>(context)
                                        .uploadCoverImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text);
                                  },
                                  child: const Text(
                                    'Update Cover Images',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  customeTextFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Name Must Not Be Empty !';
                        }
                        return null;
                      },
                      hintText: 'name',
                      prefixIcon: Icons.person),
                  const SizedBox(
                    height: 15,
                  ),
                  customeTextFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'bio must not be empty !';
                        }
                        return null;
                      },
                      hintText: 'bio',
                      prefixIcon: Icons.info),
                  const SizedBox(
                    height: 15,
                  ),
                  customeTextFormField(
                      controller: phoneController,
                      type: TextInputType.number,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty !';
                        }
                        return null;
                      },
                      hintText: 'phone',
                      prefixIcon: Icons.phone),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
