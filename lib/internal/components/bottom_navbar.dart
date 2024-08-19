import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/all_character_screen.dart';
import 'package:rick_and_morty/features/episodes/presentation/screens/all_episodes_screen.dart';
import 'package:rick_and_morty/features/location/presentation/screens/all_location_screen.dart';
import 'package:rick_and_morty/features/settings/screens/settings_screen.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  void onItemTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> screens = const [
    //персонажи
    AllCharacterScreen(),
    //локация
    AllLocationScreen(),
    //Эпизоды
    AllEpisodesScreen(),
    //настройки
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        selectedIconTheme: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme,
        selectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_4_sharp,
            ),
            // Image.asset(
            //   'assets/images/character.png',
            //   width: 24,
            //   height: 24,
            // ),
            label: 'Персонажи',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on_outlined,
            ),
            label: 'Локациии',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tv_rounded,
            ),
            label: 'Эпизоды',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Настройки',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTab,
      ),
    );
  }
}
