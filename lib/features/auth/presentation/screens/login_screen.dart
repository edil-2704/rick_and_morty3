import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/auth/presentation/logic/bloc/auth_bloc.dart';
import 'package:rick_and_morty/features/auth/presentation/screens/registration_screen.dart';
import 'package:rick_and_morty/features/auth/presentation/widgets/common_elevated_button.dart';
import 'package:rick_and_morty/generated/l10n.dart';
import 'package:rick_and_morty/internal/components/common_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final AuthBloc authBloc = AuthBloc();

  Future<void> signInWithEmailAndPassword() async {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: loginController.text,
      password: passwordController.text,
    );
  }

  // @override
  // void initState() {
  //   authBloc.add(
  //     LoginEvent(
  //       name: loginController.text,
  //       passwordToLogin: passwordController.text,
  //     ),
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/main.png',
                    height: 377,
                    width: 268,
                  ),
                ),
                Text(S.of(context).login),
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller: loginController,
                  hintText: S.of(context).login,
                  prefixIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                Text(S.of(context).password),
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller: passwordController,
                  hintText: 'Password',
                  suffixIcon: const Icon(Icons.visibility_off_sharp),
                  prefixIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 40),
                BlocListener<AuthBloc, AuthState>(
                  bloc: authBloc,
                  listener: (context, state) {
                    print(state);

                    if (state is AuthLoadedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('daaaaa')));
                    }
                  },
                  child: ElevatedButtonWidget(
                    onPressed: () {
                      authBloc.add(
                        LoginEvent(
                          name: loginController.text,
                          passwordToLogin: passwordController.text,
                        ),
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => RegistrationScreen()));
                    },
                    title: S.of(context).create,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  child: RichText(
                    text: TextSpan(
                      text: 'У вас еще нет аккаунта?  ',
                      style: const TextStyle(
                        color: Color(0xff5B6975),
                      ),
                      children: [
                        TextSpan(
                          text: S.of(context).create,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff43D049),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationScreen()));
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
