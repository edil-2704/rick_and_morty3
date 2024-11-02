import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rick_and_morty/features/characters/presentation/widgets/to_list_view.dart';
import 'package:rick_and_morty/internal/constants/text_helper/text_helper.dart';
import 'package:rick_and_morty/internal/constants/utils/enum_funcs.dart';

class CommonCharInkwell extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final String imageUrl;
  final String status;
  final String species;
  final ToListViewSeparated? widget;

  const CommonCharInkwell({
    super.key,
    this.widget,
    required this.name,
    required this.onTap,
    required this.imageUrl,
    required this.status,
    required this.species,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80.h,
            width: 80.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.r),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
              ),
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            height: 56.h,
            width: 209.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    status,
                    style: TextStyle(
                      color: getStatusColor(status),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    species,
                    style: TextHelper.mainCharGender,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: onTap,
              icon: Icon(Icons.arrow_forward_ios_sharp),
            ),
          ),
        ],
      ),
    );
  }
}
