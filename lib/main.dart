import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/login%20cubit/login_cubit.dart';
import 'package:social_app/cubits/register%20cubit/register_cubit.dart';
import 'package:social_app/cubits/social%20cubit/social_cubit.dart';
import 'package:social_app/layouts/home_layout.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/cache_helper.dart';
import 'firebase_options.dart';
import 'modules/login_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var token = await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();

  uId = CacheHelper.getData(key: 'uId');
  Widget widget;

  if (uId != null) {
    widget = HomeLayout();
  } else {
    widget = LoginPage();
  }

  runApp(SocialApp(
    startWidget: widget,
  ));
}

class SocialApp extends StatelessWidget {
  const SocialApp({super.key, required this.startWidget});
  final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getPosts()
              ..userModel)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // brightness: Brightness.dark,
          fontFamily: 'Barlow',
        ),
        home: startWidget,
      ),
    );
  }
}
