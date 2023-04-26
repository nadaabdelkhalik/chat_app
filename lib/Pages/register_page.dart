import 'package:chat_app/Bloc/register_states.dart';
import 'package:chat_app/Pages/chats_list_page.dart';
import 'package:chat_app/Widgets/set_new_photo.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/register_cubit.dart';
import '../Utilities/consts.dart';
import '../Widgets/button.dart';

import '../Widgets/text_field.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
              statusBarColor: Colors.grey[100],
              statusBarIconBrightness: Brightness.light),
          child: Scaffold(
            body: BlocBuilder<RegisterCubit, RegisterStates>(
              builder: (BuildContext context, state) => ListView(children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        " Sign UP",
                        style: TextStyle(color: kprimaryColor, fontSize: 34),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                       const Center(
                        child: SetNewPhoto(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppTextField(
                        hintText: "First Name",
                        textInputType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) return 'Enter your Name';

                          return null;
                        },
                        controller: BlocProvider.of<RegisterCubit>(context)
                            .firstNameController,
                        obscure: false,
                        onPressed: () {},
                      ),
                      AppTextField(
                        hintText: "Last Name",
                        textInputType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) return 'Enter your Last Name';

                          return null;
                        },
                        controller: BlocProvider.of<RegisterCubit>(context)
                            .lastNameController,
                        obscure: false,
                        onPressed: () {},
                      ),
                      AppTextField(
                        hintText: "Email",
                        prefix: Icons.email,
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) return 'Enter your Email';

                          return null;
                        },
                        controller: BlocProvider.of<RegisterCubit>(context)
                            .emailAddressController,
                        obscure: false,
                        onPressed: () {},
                      ),
                      AppTextField(
                          hintText: "Password",
                          obscure: BlocProvider.of<RegisterCubit>(context)
                              .obscurePassword,
                          prefix: Icons.lock,
                          suffixIcon: BlocProvider.of<RegisterCubit>(context)
                              .passwordVisibilityIcon,
                          textInputType: TextInputType.visiblePassword,
                          onPressed: () =>
                              BlocProvider.of<RegisterCubit>(context)
                                  .viewPassword(),
                          validator: (value) {
                            if (value!.isEmpty) return 'Enter your Password';

                            return null;
                          },
                          controller: BlocProvider.of<RegisterCubit>(context)
                              .passwordController),
                      AppTextField(
                          hintText: " confirm Password",
                          obscure: BlocProvider.of<RegisterCubit>(context)
                              .obscureConfirmPassword,
                          prefix: Icons.lock,
                          suffixIcon: BlocProvider.of<RegisterCubit>(context)
                              .confirmPasswordVisibilityIcon,
                          textInputType: TextInputType.visiblePassword,
                          onPressed: () =>
                              BlocProvider.of<RegisterCubit>(context)
                                  .viewConfirmedPassword(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your Password';
                            } else if (value !=
                                BlocProvider.of<RegisterCubit>(context)
                                    .passwordController
                                    .text) {
                              return "Passwords don't match";
                            }

                            return null;
                          },
                          controller: BlocProvider.of<RegisterCubit>(context)
                              .confirmController),
                      Button(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(context)
                                .signUpWithEmailAndPassword();

                            if (state is SuccessState) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => ChatsListPage()),
                                ),
                              );
                            } else if (state is FailureState) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Center(
                                  child: Text(
                                      BlocProvider.of<RegisterCubit>(context)
                                          .errorMessageForSigningUp!),
                                ),
                                backgroundColor: Colors.red,
                                shape: const StadiumBorder(),
                                margin: const EdgeInsets.all(60),
                                behavior: SnackBarBehavior.floating,
                              ));
                            }
                          }
                        },
                        isSmall: false,
                        child: state is LoadingState
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Sign UP"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("already have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => LoginPage()),
                                  ),
                                );
                              },
                              child: const Text("login"))
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            ),
          )),
    );
  }
}
