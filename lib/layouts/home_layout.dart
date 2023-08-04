import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social%20cubit/social_cubit.dart';
import 'package:social_app/modules/internal%20screens/add_new_post_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              BlocProvider.of<SocialCubit>(context)
                  .titles[BlocProvider.of<SocialCubit>(context).currentIndex],
              style: const TextStyle(
                  fontWeight: FontWeight.w900, color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NewPostScreen();
                    }));
                  },
                  icon: const Icon(
                    Icons.upload_file_outlined,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
            ],
          ),
          body: BlocProvider.of<SocialCubit>(context)
              .screens[BlocProvider.of<SocialCubit>(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.greenAccent,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: Colors.white,
              currentIndex: BlocProvider.of<SocialCubit>(context).currentIndex,
              onTap: (index) {
                BlocProvider.of<SocialCubit>(context).changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble), label: 'chat'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.location_pin), label: 'Location'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ]),
        );
      },
    );
  }
}
