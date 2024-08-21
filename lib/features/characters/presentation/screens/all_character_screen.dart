import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/characters/presentation/logic/bloc/character_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/common_chars_shimmer.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/to_grid_view.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/to_list_view.dart';
import 'package:rick_and_morty/internal/constants/text_helper/text_helper.dart';
import 'package:rick_and_morty/internal/constants/utils/search_widget.dart';
import 'package:rick_and_morty/internal/dependencies/get_it.dart';

class AllCharacterScreen extends StatefulWidget {
  const AllCharacterScreen({super.key});

  @override
  State<AllCharacterScreen> createState() => _AllCharacterScreenState();
}

class _AllCharacterScreenState extends State<AllCharacterScreen> {
  TextEditingController searchTextController = TextEditingController();

  final CharacterBloc characterBloc = getIt<CharacterBloc>();

  bool isListView = true;
  late final ScrollController scrollController;
  List<CharacterResult> charactersList = [];
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    characterBloc.add(GetAllCharactersEvent(
      page: page,
      isFirstCall: true,
    ));
    scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (charactersList.isNotEmpty) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        isLoading = true;

        if (isLoading) {
          page = page + 1;

          characterBloc.add(GetAllCharactersEvent(page: page));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: RefreshIndicator(
        onRefresh: () async {
          charactersList.clear();
          characterBloc.add(
            GetAllCharactersEvent(
              page: page,
              isFirstCall: true,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              children: [
                SearchWidget(
                  searchTextController: searchTextController,
                  hintText: 'Найти персонажа',
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<CharacterBloc, CharacterState>(
                        bloc: characterBloc,
                        builder: (context, state) {
                          if (state is CharacterLoadedState) {
                            return Text(
                              'Всего песонажей: ${state.characterModel.info?.count}',
                              style: TextHelper.totalChar,
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        isListView = !isListView;
                        setState(() {});
                      },
                      icon: Icon(
                        isListView
                            ? Icons.menu_outlined
                            : Icons.grid_view_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocConsumer<CharacterBloc, CharacterState>(
                    bloc: characterBloc,
                    listener: (context, state) {
                      if (state is CharacterErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error.message.toString()),
                          ),
                        );
                      }

                      if (state is CharacterLoadedState) {
                        charactersList
                            .addAll(state.characterModel.results ?? []);
                        isLoading = false;
                      }

                      if (state is CharacterLoadingState) {
                        const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is CharacterLoadingState) {
                        return ListView.separated(
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            return const CommonCharsShimmer();
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20.h);
                          },
                        );
                      }

                      if (state is CharacterLoadedState) {
                        return isListView
                            ? ToListViewSeparated(
                                charactersList: charactersList,
                                scrollController: scrollController,
                              )
                            : ToGridViewSeparated(
                                scrollController: scrollController,
                                charactersList: charactersList,
                              );
                      }
                      if (state is CharacterErrorState) {
                        return Center(
                          child: ElevatedButton(
                            onPressed: () {
                              characterBloc
                                  .add(GetAllCharactersEvent(page: page));
                            },
                            child: const Text('Нажмите чтобы обновить'),
                          ),
                        );
                      }
                      return const Center(
                        child: Text('No characters found'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
