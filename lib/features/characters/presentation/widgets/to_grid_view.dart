import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/characters/presentation/logic/bloc/character_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/character_info_screen.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/enum_funcs.dart';
import 'package:rick_and_morty/internal/constants/text_helper/text_helper.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';

class ToGridViewSeparated extends StatelessWidget {
  final CharacterLoadedState state;
  final Function onRefresh;

  const ToGridViewSeparated({
    super.key,
    required this.state,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        shrinkWrap: true,
        itemCount: state.characterModel.results?.length ?? 0,
        itemBuilder: (context, index) {
          return Center(
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CharacterInfoScreen(
                      id: state.characterModel.results?[index].id ?? 0,
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
                          state.characterModel.results?[index].image ?? '',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      statusConverter(
                              state.characterModel.results?[index].status ??
                                  Status.ALIVE) ??
                          '',
                      style: TextStyle(
                          color: state.characterModel.results?[index].status ==
                                  Status.ALIVE
                              ? AppColors.mainGreen
                              : AppColors.mainRed),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      state.characterModel.results?[index].name ?? '',

                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${speciesConverter(state.characterModel.results?[index].species ?? Species.HUMAN) ?? ''}, ${genderConverter(state.characterModel.results?[index].gender ?? Gender.UNKNOWN) ?? ''}',
                      style: TextHelper.mainCharGender,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
