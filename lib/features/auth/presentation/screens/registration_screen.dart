import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rick_and_morty/internal/commons/common.dart';
import '../logic/bloc/bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isHiddenPassword = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  final AuthBloc registrationBloc = AuthBloc();

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Создать аккаунт',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const CommonTextWidget(tittle: 'Name'),
              CommonTextFieldWidget(
                controller: nameController,
                hintText: 'Name',
              ),
              const CommonTextWidget(tittle: 'Surname'),
              CommonTextFieldWidget(
                controller: secondNameController,
                hintText: 'Surname',
              ),
              const CommonTextWidget(tittle: 'Lastname'),
              CommonTextFieldWidget(
                controller: lastNameController,
                hintText: 'Lastname',
              ),
              const SizedBox(height: 10),
              const Divider(height: 5),
              const SizedBox(height: 10),
              const CommonTextWidget(tittle: 'Login'),
              CommonTextFieldWidget(
                controller: emailController,
                hintText: 'Login',
                prefixIcon: const Icon(Icons.person),
              ),
              const CommonTextWidget(tittle: 'Password'),
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
              const SizedBox(height: 10),
              BlocListener<AuthBloc, AuthState>(
                bloc: registrationBloc,
                listener: (context, state) {
                  if (state is AuthLoadedState) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBar(),
                      ),
                    );
                  }
                },
                /// TODO: переименовать на CommonElevatedButton
                child: ElevatedButtonWidget(
                  onPressed: () {
                    registrationBloc.add(
                      RegisterEvent(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  },
                  title: 'Create',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
