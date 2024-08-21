import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/character_info_screen.dart';

import 'package:rick_and_morty/internal/constants/utils/common_inkwell_char.dart';
import 'package:rick_and_morty/internal/constants/utils/common_progress_indicator.dart';

import 'package:rick_and_morty/internal/constants/utils/enum_funcs.dart';

class ToListViewSeparated extends StatefulWidget {
  final List<CharacterResult> charactersList;
  final ScrollController scrollController;

  const ToListViewSeparated({
    super.key,
    required this.charactersList,
    required this.scrollController,
  });

  @override
  State<ToListViewSeparated> createState() => _ToListViewSeparatedState();
}

class _ToListViewSeparatedState extends State<ToListViewSeparated> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: widget.scrollController,
      shrinkWrap: true,
      itemCount: widget.charactersList.length ?? 0,
      itemBuilder: (context, index) {

        if (index >= widget.charactersList.length - 1) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: CommonProgressIndicator(),
          );
        }
        return Center(
          child: CommonCharInkwell(
            widget: widget,
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
            status:
                '${statusConverter(widget.charactersList[index].status ?? Status.ALIVE) ?? ''}',
            name: '${widget.charactersList[index].name ?? ''}',
            species:
                '${speciesConverter(widget.charactersList[index].species ?? Species.HUMAN) ?? ''}, ${genderConverter(widget.charactersList[index].gender ?? Gender.UNKNOWN) ?? ''}',
            imageUrl: '${widget.charactersList[index].image ?? ''}',
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
    );
  }
}
