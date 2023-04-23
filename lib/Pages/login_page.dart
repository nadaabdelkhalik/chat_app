import 'package:chat_app/Pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/login_cubit.dart';
import '../Bloc/login_states.dart';
import '../Utilities/consts.dart';
import '../Widgets/button.dart';
import '../Widgets/text_field.dart';
import 'chats_list_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: ListView(children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  " Sign In",
                  style: TextStyle(color: kprimaryColor, fontSize: 34),
                ),
                const SizedBox(
                  height: 30,
                ),
                textField(
                    hintText: "Email",
                    prefix: Icons.email,
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) return 'Enter your Email';

                      return null;
                    },
                    controller: BlocProvider.of<LoginCubit>(context)
                        .emailAddressController),
                textField(
                    hintText: "Password",
                    obscure: BlocProvider.of<LoginCubit>(context).obscure,
                    prefix: Icons.lock,
                    suffixIcon:
                        BlocProvider.of<LoginCubit>(context).visibilityIcon,
                    textInputType: TextInputType.visiblePassword,
                    onPressed: () =>
                        BlocProvider.of<LoginCubit>(context).viewPassword(),
                    validator: (value) {
                      if (value!.isEmpty) return 'Enter your Password';

                      return null;
                    },
                    controller: BlocProvider.of<LoginCubit>(context)
                        .passwordController),
                materialButton(
                    context: context,
                    child: state is LoadingState
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Sign In"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context)
                            .signInWithEmailAndPassword();
                        if (state is SuccessState) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => ChatsListPage()),
                            ),
                          );
                        } else if (state is FailureState) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Center(
                              child: Text(BlocProvider.of<LoginCubit>(context)
                                  .errorMessageForLoggingIn!),
                            ),
                            backgroundColor: Colors.red,
                            shape: const StadiumBorder(),
                            margin: const EdgeInsets.all(60),
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => RegisterPage()),
                            ),
                          );
                        },
                        child: const Text("register now"))
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
