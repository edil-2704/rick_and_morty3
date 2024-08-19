import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/data/repository/char_repository_impl.dart';
import 'package:rick_and_morty/features/characters/domain/char_use_case/char_use_case.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/search_widget.dart';
import 'package:rick_and_morty/features/location/data/models/location_image_model.dart';
import 'package:rick_and_morty/features/location/data/models/location_model.dart';
import 'package:rick_and_morty/features/location/data/repository/location_repository_impl.dart';
import 'package:rick_and_morty/features/location/domain/location_use_case/location_use_case.dart';
import 'package:rick_and_morty/features/location/presentation/logic/bloc/location_bloc.dart';
import 'package:rick_and_morty/features/location/presentation/widgets/common_location_card.dart';
import 'package:rick_and_morty/internal/constants/text_helper/text_helper.dart';

class AllLocationScreen extends StatefulWidget {
  const AllLocationScreen({super.key});

  @override
  State<AllLocationScreen> createState() => _AllLocationScreenState();
}

class _AllLocationScreenState extends State<AllLocationScreen> {
  final TextEditingController searchTextController = TextEditingController();

  late final ScrollController scrollController;
  List<LocationResult> locationsList = [];
  bool isLoading = false;
  int page = 1;

  final LocationBloc locationBloc = LocationBloc(
      locationUseCase:
          LocationUseCase(locationRepositories: LocationRepositoryImpl()),
      charUseCase: CharUseCase(charRepository: CharRepositoryImpl()));

  @override
  void initState() {
    locationBloc.add(GetAllLocations(
      page: page,
      isFirstCall: true,
    ));
    scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (locationsList.isNotEmpty) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        isLoading = true;

        if (isLoading) {
          page = page + 1;

          locationBloc.add(GetAllLocations(
            page: page,
            isFirstCall: true,
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: () async {
          locationsList.clear();
          locationBloc.add(GetAllLocations(
            page: page,
            isFirstCall: true,
          ));
        },
        child: SingleChildScrollView(
          controller: scrollController,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SearchWidget(
                  searchTextController: searchTextController,
                  hintText: 'Поиск Локаций',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor:
                            Theme.of(context).colorScheme.surface,
                        content: SizedBox(
                          height: 761.h,
                          width: 375.w,
                          child: Column(
                            children: [
                              Text('Status'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<LocationBloc, LocationState>(
                  bloc: locationBloc,
                  builder: (context, state) {

                    if (state is LocationLoadedState) {
                      return Text(
                        'Всего локаций: ${state.locationModel.info?.count ?? ''}',
                        style: TextHelper.totalChar,
                      );
                    }
                    return SizedBox();
                  },
                ),
                BlocConsumer<LocationBloc, LocationState>(
                  bloc: locationBloc,
                  listener: (context, state) {
                    if (state is LocationLoadingState) {
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LocationLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is LocationLoadedState) {
                      locationsList.addAll(state.locationModel.results ?? []);
                      isLoading = false;
                    }

                    if (state is LocationLoadedState) {
                      return Column(
                        children: [
                          CommonLocationCard(
                            locationsList: locationsList,
                            imagesLocationModel: imagesLocation,
                            scrollController: scrollController,
                          ),
                        ],
                      );
                    }
                    if (state is LocationErrorState) {
                      return Center(
                        child: ElevatedButton(
                            onPressed: () {
                              locationBloc.add(GetAllLocations(page: page));
                            },
                            child: Text('Нажмите чтобы обновить')),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
