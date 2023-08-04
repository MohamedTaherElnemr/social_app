// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social%20cubit/social_cubit.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({super.key});
  var postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              'Create Post',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    var now = DateTime.now();
                    if (BlocProvider.of<SocialCubit>(context).postImage ==
                        null) {
                      BlocProvider.of<SocialCubit>(context).createPost(
                          text: postController.text, dateTime: now.toString());
                    } else {
                      BlocProvider.of<SocialCubit>(context).uploadPostImage(
                          text: postController.text, dateTime: now.toString());
                    }

                    // Navigator.pop(context);
                    BlocProvider.of<SocialCubit>(context).removePostImage();
                  },
                  child: const Text(
                    'POST',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          '${BlocProvider.of<SocialCubit>(context).userModel!.image}'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${BlocProvider.of<SocialCubit>(context).userModel!.name}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: InputDecoration(
                        hintText: 'whats in your mind...?',
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (BlocProvider.of<SocialCubit>(context).postImage != null &&
                    state is! RemovePostImageSuccessState)
                  Stack(
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4)),
                          image: DecorationImage(
                              image: FileImage(
                                  BlocProvider.of<SocialCubit>(context)
                                      .postImage!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<SocialCubit>(context)
                                .removePostImage();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            BlocProvider.of<SocialCubit>(context)
                                .getPostImage();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Add Photo'),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: () {}, child: Text('#tags')),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
