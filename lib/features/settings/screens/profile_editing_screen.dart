import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/settings/screens/profile_name_edit.dart';
import 'package:rick_and_morty/internal/constants/utils/common_column_data.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileEditingScreen extends StatefulWidget {
  const ProfileEditingScreen({super.key});

  @override
  State<ProfileEditingScreen> createState() => _ProfileEditingScreenState();
}

class _ProfileEditingScreenState extends State<ProfileEditingScreen> {
  File? selectedImage;

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Редактировать профиль'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                  radius: 75.r,
                  backgroundImage: selectedImage != null
                      ? FileImage(selectedImage!)
                      : const AssetImage('assets/images/ea.png')
                          as ImageProvider // Path to the profile image
                  ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  _pickImageFromGallery();
                },
                child: const Text(
                  'Изменить фото',
                  style: TextStyle(
                    color: AppColors.mainBlue,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'профиль'.toUpperCase(),
              style: const TextStyle(color: AppColors.mainGrey),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Expanded(
                  child: CommonCharDataWidget(
                    tittle: 'Изменить ФИО',
                    subTittle: 'Oleg Belotserkovsky',
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileNameEdit()));
                  },
                  icon: const Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Expanded(
                  child: CommonCharDataWidget(
                    tittle: 'Логин',
                    subTittle: 'Rick',
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileNameEdit(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
