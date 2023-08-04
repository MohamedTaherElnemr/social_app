import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social%20cubit/social_cubit.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/internal%20screens/chat_details_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: BlocProvider.of<SocialCubit>(context).users.length > 0,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildChatItem(context,
                    BlocProvider.of<SocialCubit>(context).users[index]),
                separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                      color: Colors.grey,
                      height: 20,
                      indent: 10,
                      endIndent: 10,
                    ),
                itemCount: BlocProvider.of<SocialCubit>(context).users.length),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget buildChatItem(context, UserModel model) => InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatDetailsScreen(userModel: model);
          }));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              '${model.name}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ]),
        ),
      );
}
