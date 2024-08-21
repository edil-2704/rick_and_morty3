import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/internal/commons/common_elevated_button.dart';
import 'package:rick_and_morty/internal/commons/common_text_widget.dart';

import '../../../internal/commons/common_text_field_widget.dart';

class ProfileNameEdit extends StatefulWidget {
  const ProfileNameEdit({super.key});

  @override
  State<ProfileNameEdit> createState() => _ProfileNameEditState();
}

class _ProfileNameEditState extends State<ProfileNameEdit> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
        title: Text(
          'Изменить ФИО',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              CommonTextWidget(tittle: 'Имя'),
              CommonTextFieldWidget(
                controller: nameController,
                hintText: 'Имя',
              ),
              SizedBox(height: 20.h),
              CommonTextWidget(tittle: 'Фамилия'),
              CommonTextFieldWidget(
                controller: surnameController,
                hintText: 'Фамилия',
              ),
              SizedBox(height: 20.h),
              CommonTextWidget(tittle: 'Отчество'),
              Expanded(
                child: CommonTextFieldWidget(
                  controller: lastnameController,
                  hintText: 'Отчество',
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButtonWidget(
                onPressed: () {
                  CollectionReference collRef =
                      FirebaseFirestore.instance.collection('client');
                  collRef.add({
                    'name': nameController.text,
                    'surname': surnameController.text,
                    'lastname': lastnameController.text,
                  });
                },
                title: 'Сохранить',
              )
            ],
          ),
        ),
      ),
    );
  }
}
