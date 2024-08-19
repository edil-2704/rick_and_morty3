import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/character_info_screen.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/common_progress_indicator.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/search_widget.dart';
import 'package:rick_and_morty/features/episodes/data/models/episode_image_model.dart';
import 'package:rick_and_morty/features/episodes/data/models/episode_models.dart';
import 'package:rick_and_morty/features/episodes/data/repository/episode_repository.dart';
import 'package:rick_and_morty/features/episodes/domain/episode_use_case/episode_use_case.dart';
import 'package:rick_and_morty/features/episodes/presentation/logic/bloc/episodes_bloc.dart';
import 'package:rick_and_morty/features/episodes/presentation/screens/episodes_info_screen.dart';
import 'package:rick_and_morty/internal/components/date_formatter.dart';
import 'package:rick_and_morty/internal/constants/text_helper/text_helper.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';

class AllEpisodesScreen extends StatefulWidget {
  const AllEpisodesScreen({super.key});

  @override
  State<AllEpisodesScreen> createState() => _AllEpisodesScreenState();
}

class _AllEpisodesScreenState extends State<AllEpisodesScreen> {
  late final ImagesEpisodeModel episodeModel;
  late final ScrollController scrollController;
  List<EpisodeResult> episodesList = [];
  bool isLoading = false;
  int page = 1;

  final EpisodesBloc bloc = EpisodesBloc(
    episodeUseCase: EpisodeUseCase(
      episodeRepository: EpisodeRepositoryImpl(),
    ),
  );

  final TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    bloc.add(GetAllEpisodes(
      page: page,
      isFirstCall: true,
    ));
    scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);

    super.initState();
  }

  _scrollListener() {
    if (episodesList.isNotEmpty) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        isLoading = true;

        if (isLoading) {
          page = page + 1;

          bloc.add(GetAllEpisodes(page: page));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          bottom: TabBar(
            labelColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            tabs: [
              Tab(
                child: Text('СЕЗОН 1'),
              ),
              Tab(
                child: Text('СЕЗОН 2'),
              ),
              Tab(
                child: Text('СЕЗОН 3'),
              ),
              Tab(
                child: Text('СЕЗОН 4'),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              SearchWidget(
                searchTextController: searchTextController,
                hintText: 'Найти Эпизод',
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      episodesList.clear();
                      bloc.add(GetAllEpisodes(
                        page: page,
                        isFirstCall: true,
                      ));
                    },
                    child: Column(
                      children: [
          
                        SizedBox(height: 20.h),
                        BlocConsumer<EpisodesBloc, EpisodesState>(
                          bloc: bloc,
                          listener: (context, state) {
                            if (state is EpisodesLoadingState) {
                              const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is EpisodesErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.error.message.toString()),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            log('state is $state');
          
                            if (state is EpisodesLoadedState) {
                              episodesList.addAll(state.episodeModel.results ?? []);
                              isLoading = false;
                            }
                            if (state is EpisodesLoadedState) {
                              return Column(
                                children: [
                                  ListView.separated(

                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: episodesList.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final url = imagesLocation.getNextImageUrl();
          
                                      if (index >= episodesList.length - 1) {
                                        return Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5.h),
                                          child: const CommonProgressIndicator(),
                                        );
                                      }
                                      return Center(
                                        child: InkWell(
                                          splashFactory: NoSplash.splashFactory,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EpisodesInfoScreen(
                                                  id: episodesList[index].id ?? 0,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 15),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 79,
                                                    width: 79,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(url),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(15),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: 104.w,
                                                      height: 60.h,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            episodesList[index]
                                                                    .episode ??
                                                                '',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .mainBlue,
                                                            ),
                                                          ),
                                                          Text(
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            episodesList[index]
                                                                    .name ??
                                                                '',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            dateConverter(episodesList[
                                                                        index]
                                                                    .created
                                                                    ?.millisecondsSinceEpoch ??
                                                                0),
                                                            style: TextHelper
                                                                .charSexText,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(height: 16);
                                    },
                                  ),
                                ],
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
