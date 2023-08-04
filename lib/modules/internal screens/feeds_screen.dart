// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social%20cubit/social_cubit.dart';

import '../../models/post_model.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({super.key});
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        // BlocProvider.of<SocialCubit>(context).getUserData();
        // BlocProvider.of<SocialCubit>(context).getPosts();
        return ConditionalBuilder(
          condition: BlocProvider.of<SocialCubit>(context).posts.length > 0 &&
              BlocProvider.of<SocialCubit>(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                const Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Image(
                        height: 200,
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?size=626&ext=jpg&ga=GA1.1.1860636554.1688653303&semt=sph'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          """Connect 
                          To 
                          Friends Easily""",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(
                        BlocProvider.of<SocialCubit>(context).posts[index],
                        context,
                        index,
                        commentController),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount:
                        BlocProvider.of<SocialCubit>(context).posts.length),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget buildPostItem(PostModel model, context, index,
        TextEditingController commentComntroller) =>
    Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 15,
                          )
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
              ],
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
            Text(
              '${model.text}',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    if (model.postImage != '')
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                image: NetworkImage('${model.postImage}'),
                                fit: BoxFit.cover)),
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite_border_outlined,
                                    size: 25,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      '${BlocProvider.of<SocialCubit>(context).likes[index]}'),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.comment_sharp,
                                    size: 25,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      '${BlocProvider.of<SocialCubit>(context).comments[index]} comments'),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundImage: NetworkImage(
                                      '${BlocProvider.of<SocialCubit>(context).userModel!.image}'),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: commentComntroller,
                                    decoration: InputDecoration(
                                      hintText: 'Write a comment..',
                                      border: InputBorder.none,
                                    ),
                                    onFieldSubmitted: (value) {
                                      BlocProvider.of<SocialCubit>(context)
                                          .commentpost(
                                              BlocProvider.of<SocialCubit>(
                                                      context)
                                                  .postId[index],
                                              value.toString());

                                      commentComntroller.clear();
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.favorite_border_outlined,
                                  size: 25,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text('Like'),
                              ],
                            ),
                          ),
                          onTap: () {
                            BlocProvider.of<SocialCubit>(context).likePost(
                                BlocProvider.of<SocialCubit>(context)
                                    .postId[index]);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
