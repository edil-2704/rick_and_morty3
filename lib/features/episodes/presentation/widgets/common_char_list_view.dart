
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/enum_funcs.dart';
import 'package:rick_and_morty/features/episodes/presentation/logic/bloc/episodes_bloc.dart';
import 'package:rick_and_morty/features/episodes/presentation/screens/episodes_info_screen.dart';
import 'package:rick_and_morty/internal/constants/text_helper/text_helper.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';

class CommonCharListView extends StatelessWidget {
  final EpisodesLoadedInfoState state;

  const CommonCharListView({
    super.key,
    required this.widget,
    required this.state,
  });

  final EpisodesInfoScreen widget;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.characterResult?.length ?? 0,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 74.h,
                  width: 74.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    image: DecorationImage(
                      image: NetworkImage(
                          state.characterResult?[index].image ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 62.h,
                    width: 213.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            statusConverter(
                                state.characterResult?[index].status ??
                                    Status.ALIVE) ??
                                '',
                            style: TextStyle(
                                color: state.characterResult?[index].status ==
                                    Status.ALIVE
                                    ? AppColors.mainGreen
                                    : AppColors.mainRed),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            state.characterResult?[index].name ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Expanded(
                            child: Text(
                              '${speciesConverter(state.characterResult?[index].species ?? Species.HUMAN) ?? ''}, ${genderConverter(state.characterResult?[index].gender ?? Gender.UNKNOWN) ?? ''}',
                              style: TextHelper.mainCharGender,
                            )),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EpisodesInfoScreen(
                            id: widget.id,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.arrow_forward_ios_sharp),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
    );
  }
}
