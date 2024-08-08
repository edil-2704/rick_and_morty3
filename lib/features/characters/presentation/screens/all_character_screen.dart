import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/characters/data/repository/char_repository_impl.dart';
import 'package:rick_and_morty/features/characters/domain/char_use_case/char_use_case.dart';
import 'package:rick_and_morty/features/characters/presentation/logic/bloc/character_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/search_widget.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/to_grid_view.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/to_list_view.dart';
import 'package:rick_and_morty/internal/constants/text_helper/text_helper.dart';

class AllCharacterScreen extends StatefulWidget {
  const AllCharacterScreen({super.key});

  @override
  State<AllCharacterScreen> createState() => _AllCharacterScreenState();
}

class _AllCharacterScreenState extends State<AllCharacterScreen> {
  TextEditingController searchTextController = TextEditingController();

  final CharacterBloc characterBloc = CharacterBloc(
      charUseCase: CharUseCase(charRepository: CharRepositoryImpl()));

  bool isListView = true;

  @override
  void initState() {
    characterBloc.add(GetAllCharacters());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              SearchWidget(
                searchTextController: searchTextController, hintText: 'Найти персонажа',
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      'Всего песонажей: 200',
                      style: TextHelper.totalChar,
                    ),
                  ),
                  Expanded(
                    child: IconButton(
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
                  ),
                ],
              ),
              SizedBox(height: 20),
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

                      if (state is CharacterLoadingState) {
                        Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is CharacterLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is CharacterLoadedState) {
                        return isListView
                            ? ToListViewSeparated(
                                state: state,
                                onRefresh: () {
                                  characterBloc.add(GetAllCharacters());
                                },
                              )
                            : ToGridViewSeparated(
                                state: state,
                                onRefresh: () {
                                  characterBloc.add(GetAllCharacters());
                                },
                              );
                      }
                      if (state is CharacterErrorState) {
                        return Center(
                          child: Text('Failed to load characters'),
                        );
                      }
                      return Center(
                        child: Text('No characters found'),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
