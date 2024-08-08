import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/search_widget.dart';
import 'package:rick_and_morty/features/episodes/data/repository/episode_repository.dart';
import 'package:rick_and_morty/features/episodes/domain/episode_use_case/episode_use_case.dart';
import 'package:rick_and_morty/features/episodes/presentation/logic/bloc/episodes_bloc.dart';

class AllEpisodesScreen extends StatefulWidget {
  const AllEpisodesScreen({super.key});

  @override
  State<AllEpisodesScreen> createState() => _AllEpisodesScreenState();
}

class _AllEpisodesScreenState extends State<AllEpisodesScreen> {
  final EpisodesBloc bloc = EpisodesBloc(
    episodeUseCase: EpisodeUseCase(
      episodeRepository: EpisodeRepositoryImpl(),
    ),
  );

  final TextEditingController searchTextController = TextEditingController();
  @override
  void initState() {
    bloc.add(GetAllEpisodes());
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
                searchTextController: searchTextController,
                hintText: 'Найти Эпизод',
              ),
              BlocConsumer<EpisodesBloc, EpisodesState>(
                bloc: bloc,
                listener: (context, state) {
                  if (state is EpisodesLoadingState) {
                    Center(
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
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.episodeModel.results?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Row(
                            children: [
                              Text(state.episodeModel.results?[index].name ??
                                  ' '),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 16);
                      },
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
