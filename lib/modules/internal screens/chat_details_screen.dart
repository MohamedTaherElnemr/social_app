// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social%20cubit/social_cubit.dart';
import 'package:social_app/models/user_model.dart';

import '../../models/message_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({super.key, required this.userModel});

  UserModel userModel;

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      BlocProvider.of<SocialCubit>(context)
          .getMessages(recieverId: userModel.uId!);

      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('${userModel.image}'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '${userModel.name}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  )
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition:
                  BlocProvider.of<SocialCubit>(context).messages.length > 0,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            var message = BlocProvider.of<SocialCubit>(context)
                                .messages[index];

                            if (BlocProvider.of<SocialCubit>(context)
                                    .userModel!
                                    .uId ==
                                message.senderId) {
                              return buildMyMessage(message);
                            } else {
                              return buildMessage(message);
                            }
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 15,
                              ),
                          itemCount: BlocProvider.of<SocialCubit>(context)
                              .messages
                              .length),
                    ),
                    //  Spacer(
                    //     flex: 1,
                    //   ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'write a message...',
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(8),
                              color: Colors.blue,
                            ),
                            child: MaterialButton(
                              minWidth: 1,
                              onPressed: () {
                                BlocProvider.of<SocialCubit>(context)
                                    .sendMessage(
                                        recieverId: userModel.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);

                                messageController.clear();
                              },
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                bottomEnd: Radius.circular(10),
              )),
          child: Text('${messageModel.text}'),
        ),
      );

  Widget buildMyMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                bottomStart: Radius.circular(10),
              )),
          child: Text('${messageModel.text}'),
        ),
      );
}
