import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/common_chars_shimmer.dart';
import 'package:rick_and_morty/features/episodes/data/models/episode_image_model.dart';
import 'package:rick_and_morty/features/episodes/presentation/logic/bloc/episodes_bloc.dart';
import 'package:rick_and_morty/features/episodes/presentation/widgets/common_char_list_view.dart';
import 'package:rick_and_morty/internal/constants/text_helper/text_helper.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';
import 'package:rick_and_morty/internal/dependencies/get_it.dart';
import '../../../../internal/commons/date_formatter.dart';

class EpisodesInfoScreen extends StatefulWidget {
  final int id;

  const EpisodesInfoScreen({super.key, required this.id});

  @override
  State<EpisodesInfoScreen> createState() => _EpisodesInfoScreenState();
}

class _EpisodesInfoScreenState extends State<EpisodesInfoScreen> {
  late final ImagesEpisodeModel episodeModel;

  final EpisodesBloc episodesBloc = getIt<EpisodesBloc>();

  @override
  void initState() {
    episodesBloc.add(GetEpisodesById(id: widget.id));
    super.initState();
  }

  @override
  void dispose() {
    episodesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final url = imagesLocation.getNextImageUrl();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 335.h,
              width: 385.w,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topLeft,
                children: [
                  Image.network(
                    url,
                    fit: BoxFit.cover,
                    height: 275.h,
                  ),
                  Positioned(
                    left: 16,
                    top: 40,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_outlined,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Positioned(
                    top: 235,
                    left: 120.w,
                    child: SizedBox(
                      height: 132.h,
                      width: 132.w,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(66.0),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/vector.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocConsumer<EpisodesBloc, EpisodesState>(
                bloc: episodesBloc,
                listener: (context, state) {
                  if (state is EpisodesErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error.message.toString()),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final url = imagesLocation.getNextImageUrl();

                  if (state is EpisodesLoadingState) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const CommonCharsShimmer();
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20.h);
                          },
                        ),
                      ),
                    );
                  }

                  if (state is EpisodesErrorState) {
                    return Center(
                      child: ElevatedButton(
                          onPressed: () {
                            episodesBloc.add(GetEpisodesById(id: widget.id));
                          },
                          child: const Text('Нажмите чтобы обновить')),
                    );
                  }

                  if (state is EpisodesLoadedInfoState) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  state.result.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  state.result.episode ?? '',
                                  style: const TextStyle(
                                    color: AppColors.mainBlue,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 35),
                              const Text(
                                'Зигерионцы помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концен-трирован- ной темной материи.',
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Премьера',
                                style: TextHelper.charSexText,
                              ),
                              Text(
                                dateConverter(state.result.created
                                        ?.millisecondsSinceEpoch ??
                                    0),
                              ),
                              const SizedBox(height: 20),
                              Divider(height: 5.h),
                              Text(
                                'Персонажи',
                                style: TextHelper.mainBold20,
                              ),
                              CommonCharListView(
                                widget: widget,
                                state: state,
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox();
                }),
          ],
        ),
      ),
    );
  }
}
