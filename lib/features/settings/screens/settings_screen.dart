import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';
import 'package:rick_and_morty/internal/constants/theme_mode/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    // Получаем текущий статус темы из провайдера
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Настройки'),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/ea.png'),
                  radius: 36,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Oleg Belotserkovsky',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rick',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          ElevatedButton(
            onPressed: () {
              // Логика для редактирования профиля
            },
            child: Text('Редактировать'),
            style: ElevatedButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(0xff22A2BD),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              foregroundColor: Color(0xff22A2BD),
              minimumSize: Size(335, 48),
            ),
          ),
          Divider(),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              showDialog(
                barrierColor: Colors.black.withOpacity(0.4),
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    titleTextStyle: TextStyle(color: Colors.black),
                    title: Text(
                      'Темная тема',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Вы хотите изменить тему на ${_checkboxValue ? 'темную' : 'светлую'}?',
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.black,
                              value: _checkboxValue,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _checkboxValue = newValue ?? false;
                                });
                              },
                            ),
                            Text(
                              'Выключена',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text('Отмена'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: Text('Да'),
                        onPressed: () {
                          if (_checkboxValue) {
                            // Save user preference to not show the dialog again
                            // For example, using SharedPreferences or a similar approach
                          }
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme();
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Icon(
                    Icons.color_lens_outlined,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text('Темная тема'),
                ),
                Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'О приложении',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Затворщики помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концептуально-тяжелой темной материи.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 40),
          ListTile(
            title: Text('Версия приложения'),
            subtitle: Text('Rick & Morty v1.0.0'),
          ),
        ],
      ),
    );
  }
}
