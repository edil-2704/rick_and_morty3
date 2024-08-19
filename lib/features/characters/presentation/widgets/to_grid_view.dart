import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/characters/presentation/logic/bloc/character_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/character_info_screen.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/common_progress_indicator.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/enum_funcs.dart';
import 'package:rick_and_morty/internal/constants/text_helper/text_helper.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';

class ToGridViewSeparated extends StatefulWidget {
  final List<CharacterResult> charactersList;
  final ScrollController scrollController;

  const ToGridViewSeparated({
    super.key,
    required this.charactersList,
    required this.scrollController,
  });

  @override
  State<ToGridViewSeparated> createState() => _ToGridViewSeparatedState();
}

class _ToGridViewSeparatedState extends State<ToGridViewSeparated> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: widget.scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      shrinkWrap: true,
      itemCount: widget.charactersList.length ?? 0,
      itemBuilder: (context, index) {
        if (index >= widget.charactersList.length - 1) {
          return CommonProgressIndicator();
        }
        return Center(
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CharacterInfoScreen(
                    id: widget.charactersList[index].id ?? 0,
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 122,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(61),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.charactersList[index].image ?? '',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    statusConverter(widget.charactersList[index].status ??
                            Status.ALIVE) ??
                        '',
                    style: TextStyle(
                        color:
                            widget.charactersList[index].status == Status.ALIVE
                                ? AppColors.mainGreen
                                : AppColors.mainRed),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.charactersList[index].name ?? '',
                  ),
                ),
                Expanded(
                  child: Text(
                    '${speciesConverter(widget.charactersList[index].species ?? Species.HUMAN) ?? ''}, ${genderConverter(widget.charactersList[index].gender ?? Gender.UNKNOWN) ?? ''}',
                    style: TextHelper.mainCharGender,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

