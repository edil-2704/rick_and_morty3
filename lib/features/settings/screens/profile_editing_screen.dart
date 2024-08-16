import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/common_column_data.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';

class ProfileEditingScreen extends StatefulWidget {
  const ProfileEditingScreen({super.key});

  @override
  State<ProfileEditingScreen> createState() => _ProfileEditingScreenState();
}

class _ProfileEditingScreenState extends State<ProfileEditingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Редактировать профиль'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start ,
          children: [
            Center(
              child: CircleAvatar(
                radius: 75.r,
                backgroundImage: AssetImage('assets/images/ea.png'), // Path to the profile image
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {

                },
                child: Text(
                  'Изменить фото',
                  style: TextStyle(color: AppColors.mainBlue, fontSize: 16,),
                ),
              ),
            ),
            Text('профиль'.toUpperCase(), style: TextStyle(color: AppColors.mainGrey),),
            SizedBox(height: 30),
            CommonCharDataWidget(tittle: 'tittle', subTittle: 'subTittle'),
            SizedBox(height: 30),
            CommonCharDataWidget(tittle: 'tittle', subTittle: 'subTittle'),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}


