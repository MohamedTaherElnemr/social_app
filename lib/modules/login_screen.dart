import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/login%20cubit/login_cubit.dart';
import 'package:social_app/cubits/social%20cubit/social_cubit.dart';
import 'package:social_app/modules/register_screen.dart';
import 'package:social_app/shared/components/custome_text_form_field.dart';
import 'package:social_app/shared/components/message_on_screeen.dart';

import '../layouts/home_layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginIFailed) {
            showMessage(message: state.errMessage, state: ToastState.ERROR);
          }

          if (state is LoginSuccess) {
            // CacheHelper.setData(
            //     key: 'uId', value: BlocProvider.of<LoginCubit>(context).uId);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return HomeLayout();
            }), (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      'LOGIN',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customeTextFormField(
                        controller: emailController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Email must not be empty ! ';
                          }
                          return null;
                        },
                        hintText: 'Email.',
                        prefixIcon: Icons.email_outlined),
                    const SizedBox(
                      height: 15,
                    ),
                    customeTextFormField(
                        controller: passController,
                        type: TextInputType.text,
                        isPass: true,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Password must not be empty ! ';
                          }
                          return null;
                        },
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline),
                    const SizedBox(
                      height: 15,
                    ),
                    ConditionalBuilder(
                        condition: state is! LoginLoading,
                        builder: (context) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.greenAccent,
                              ),
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<LoginCubit>(context)
                                        .userLogin(
                                            email: emailController.text,
                                            password: passController.text);

                                    BlocProvider.of<SocialCubit>(context)
                                        .getUserData();
                                    BlocProvider.of<SocialCubit>(context)
                                        .getPosts();
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                        fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            )),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "don't have an account ? ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return RegisterScreen();
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              'REGISTER',
                              style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
