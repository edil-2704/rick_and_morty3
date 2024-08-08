import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/all_character_screen.dart';
import 'package:rick_and_morty/features/episodes/presentation/screens/all_episodes_screen.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBarScreen> {
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
    AllCharacterScreen(),
    //Эпизоды
    AllEpisodesScreen(),
    //настройки
    AllEpisodesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.mainBlue,
        unselectedItemColor: AppColors.mainGrey,
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
