import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/characters/data/repository/char_repository_impl.dart';
import 'package:rick_and_morty/features/characters/domain/char_use_case/char_use_case.dart';
import 'package:rick_and_morty/features/characters/presentation/logic/bloc/character_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/common_column_data.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/enum_funcs.dart';
import 'package:rick_and_morty/features/episodes/data/repository/episode_repository.dart';
import 'package:rick_and_morty/features/episodes/domain/episode_use_case/episode_use_case.dart';
import 'package:rick_and_morty/internal/components/date_formatter.dart';
import 'package:rick_and_morty/internal/constants/text_helper/text_helper.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';

class CharacterInfoScreen extends StatefulWidget {
  final int id;

  const CharacterInfoScreen({
    super.key,
    required this.id,
  });

  @override
  State<CharacterInfoScreen> createState() => _CharacterInfoScreenState();
}

class _CharacterInfoScreenState extends State<CharacterInfoScreen> {
  final CharacterBloc characterBloc = CharacterBloc(
    charUseCase: CharUseCase(
      charRepository: CharRepositoryImpl(),
    ),
    episodeUseCase: EpisodeUseCase(
      episodeRepository: EpisodeRepositoryImpl(),
    ),
  );

  @override
  void initState() {
    characterBloc.add(GetCharactersByIdEvent(id: widget.id));
    super.initState();
  }

  @override
  void dispose() {
    characterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<CharacterBloc, CharacterState>(
              bloc: characterBloc,
              listener: (context, state) {
                if (state is CharacterErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error.message.toString()),
                    ),
                  );
                }

                if (state is CharacterLoadingState) {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              builder: (context, state) {
                if (state is CharacterLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is CharacterLoadedInfoState) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 218.h,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      state.result.image ?? '',
                                    ),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 8.0, sigmaY: 0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 61.h,
                                  left: 16.w,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 138.h,
                                left: 100.w,
                                child: Container(
                                  width: 146.w,
                                  height: 146.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        state.result.image ?? '',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(73.r),
                                    ),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 70.h),
                        Text(
                          state.result.name ?? '',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          statusConverter(
                                  state.result.status ?? Status.ALIVE) ??
                              '',
                          style: TextStyle(
                              color: state.result.status == Status.ALIVE
                                  ? AppColors.mainGreen
                                  : AppColors.mainRed),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          child: TextHelper.charDescription,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: CommonCharDataWidget(
                                tittle: 'Пол',
                                subTittle:
                                    '${genderConverter(state.result.gender ?? Gender.UNKNOWN)}',
                              ),
                            ),
                            Expanded(
                              child: CommonCharDataWidget(
                                tittle: 'Расса',
                                subTittle:
                                    '${speciesConverter(state.result.species ?? Species.HUMAN)}',
                              ),
                            ),
                            const SizedBox(width: 60),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonCharDataWidget(
                                tittle: 'Место Рождения',
                                subTittle: state.result.origin?.name ?? '',
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonCharDataWidget(
                                tittle: 'Местоположение',
                                subTittle: state.result.location?.name ?? '',
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                          height: 5,
                          color: AppColors.mainGrey,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Эпизоды',
                              style: TextHelper.mainBold20,
                            ),
                            Text(
                              'Все Эпизоды',
                              style: TextHelper.totalChar,
                            ),
                          ],
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.result.episode?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 74.h,
                                      width: 74.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              state.result.image ?? ''),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(state.episodeResult?[index]
                                                .episode ??
                                            ''),
                                        Text(state.episodeResult?[index].name ??
                                            ''),
                                        Text(
                                          dateConverter(state
                                                  .episodeResult?[index]
                                                  .created
                                                  ?.millisecondsSinceEpoch ??
                                              0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 20);
                          },
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
