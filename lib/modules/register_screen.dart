import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social%20cubit/social_cubit.dart';
import 'package:social_app/layouts/home_layout.dart';
import '../cubits/register cubit/register_cubit.dart';
import '../shared/components/custome_text_form_field.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is CreateUserSuccess) {
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
              backgroundColor: Colors.greenAccent,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'REGIESTER',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        'Register Now To Join Our App',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      customeTextFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          hintText: 'name',
                          prefixIcon: Icons.person,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'name can not be empty !';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      customeTextFormField(
                          isPass: false,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          hintText: 'email',
                          prefixIcon: Icons.email_outlined,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'email can not be empty !';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      customeTextFormField(
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password can not be empty !';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      customeTextFormField(
                          isPass: false,
                          controller: phoneController,
                          type: TextInputType.phone,
                          hintText: 'phone',
                          prefixIcon: Icons.phone_android_outlined,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password can not be empty !';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                          condition: state is! RegisterLoading,
                          builder: (context) => Container(
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(10)),
                                width: double.infinity,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      BlocProvider.of<RegisterCubit>(context)
                                          .userRegister(
                                              email: emailController.text,
                                              password: passController.text,
                                              name: nameController.text,
                                              phone: phoneController.text);

                                      BlocProvider.of<SocialCubit>(context)
                                          .getUserData();
                                      BlocProvider.of<SocialCubit>(context)
                                          .getPosts();
                                    }
                                  },
                                  child: const Text(
                                    'REGISTER',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          fallback: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
