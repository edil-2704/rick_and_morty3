import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/auth/presentation/logic/bloc/auth_bloc.dart';
import 'package:rick_and_morty/features/auth/presentation/screens/registration_screen.dart';
import 'package:rick_and_morty/features/auth/presentation/widgets/common_elevated_button.dart';
import 'package:rick_and_morty/generated/l10n.dart';
import 'package:rick_and_morty/internal/components/bottom_navbar.dart';
import 'package:rick_and_morty/internal/components/common_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHiddenPassword = true;
  TextEditingController loginController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final AuthBloc authBloc = AuthBloc();

  Future<void> signInWithEmailAndPassword() async {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: loginController.text,
      password: passwordController.text,
    );
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    height: 377.h,
                    width: 268.w,
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
                TextFormField(
                  autocorrect: false,
                  controller: passwordController,
                  obscureText: isHiddenPassword,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffF2F2F2),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 15.h,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    hintText: 'Введите пароль',
                    prefixIcon: const Icon(Icons.password),
                    suffix: InkWell(
                      onTap: togglePasswordView,
                      child: Icon(
                        isHiddenPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                BlocListener<AuthBloc, AuthState>(
                  bloc: authBloc,
                  listener: (context, state) {
                    print(state);

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        if (state is AuthErrorState) {
                          AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text("Ошибка"),
                            content: Text("Введены неверные логин или пароль"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Закрыть диалог
                                },
                                child: Text("Ок"),
                              ),
                            ],
                          );
                        }

                        return SizedBox();
                      },
                    );

                    if (state is AuthLoadedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('daaaaa')));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavBar(),
                        ),
                      );
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
                    },
                    title: S.of(context).login,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 20.h,
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
