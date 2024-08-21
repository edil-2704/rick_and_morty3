import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/features/auth/presentation/screens/login_screen.dart';
import 'package:rick_and_morty/features/settings/screens/profile_editing_screen.dart';
import 'package:rick_and_morty/internal/constants/text_helper/text_helper.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';
import 'package:rick_and_morty/internal/constants/theme_mode/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    final navigator = Navigator.of(context);

    await FirebaseAuth.instance.signOut();

    navigator.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (Route<dynamic> route) => false);
  }

  //doc IDs
  List<String> docId = [];

  //get docsID
  Future getClient() async {
    await FirebaseFirestore.instance.collection('client').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docId.add(document.reference.id);
          }),
        );
  }

  @override
  void initState() {
    getClient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Настройки',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/ea.png'),
                  radius: 36,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user?.email}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Rick',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileEditingScreen(),
                    ),
                  );
                },
                child: Text('Редактировать'),
                style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color(0xff22A2BD),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  foregroundColor: const Color(0xff22A2BD),
                  minimumSize: const Size(335, 48),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.color_lens_outlined),
                const SizedBox(width: 10),
                const Text(
                  'Темная тема',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        int selectedValue = themeProvider.isDarkMode ? 2 : 1;

                        ///TODO: выносить отдельным виджетом
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              backgroundColor: Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .backgroundColor,
                              surfaceTintColor: Colors.blue,
                              title: const Text('Темная тема'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainBlue,
                                        value: 1,
                                        groupValue: selectedValue,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value!;
                                            themeProvider.toggleTheme();
                                          });
                                        },
                                      ),
                                      const Expanded(child: Text('Выключена')),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainBlue,
                                        value: 2,
                                        groupValue: selectedValue,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value!;
                                            themeProvider.toggleTheme();
                                          });
                                        },
                                      ),
                                      const Expanded(child: Text('Включена')),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainBlue,
                                        value: 3,
                                        groupValue: selectedValue,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value!;
                                            themeProvider.toggleTheme();
                                          });
                                        },
                                      ),
                                      const Expanded(
                                        child: Text(
                                          'Следовать настройкам системы',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainBlue,
                                        value: 4,
                                        groupValue: selectedValue,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value!;
                                            themeProvider.toggleTheme();
                                          });
                                        },
                                      ),
                                      const Expanded(
                                        child:
                                            Text('В режиме энергосбережения'),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    child: const Text('ОТМЕНА'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(),
            const Text(
              'О ПРИЛОЖЕНИИ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.mainGrey,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              maxLines: 4,
              'Затворщики помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концептуально-тяжелой темной материи.',
              style: TextStyle(
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                Text(
                  'Версия приложения',
                  style: TextHelper.charSexText,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Rick & Morty v1.0.0',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Center(
              child: MaterialButton(
                  color: AppColors.mainBlue,
                  child: const Text('SignOut'),
                  onPressed: () {
                    signOut();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
