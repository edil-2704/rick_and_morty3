import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/search_widget.dart';
import 'package:rick_and_morty/features/location/data/models/location_image_model.dart';
import 'package:rick_and_morty/features/location/data/repository/location_repository_impl.dart';
import 'package:rick_and_morty/features/location/domain/location_use_case/location_use_case.dart';
import 'package:rick_and_morty/features/location/presentation/logic/bloc/location_bloc.dart';
import 'package:rick_and_morty/features/location/presentation/widgets/common_location_card.dart';

class AllLocationScreen extends StatefulWidget {
  const AllLocationScreen({super.key});

  @override
  State<AllLocationScreen> createState() => _AllLocationScreenState();
}

class _AllLocationScreenState extends State<AllLocationScreen> {
  final TextEditingController searchTextController = TextEditingController();

  final LocationBloc locationBloc = LocationBloc(
      locationUseCase:
          LocationUseCase(locationRepositories: LocationRepositoryImpl()));

  @override
  void initState() {
    locationBloc.add(GetAllLocations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                SearchWidget(
                  searchTextController: searchTextController,
                  hintText: 'Поиск Локаций',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Theme.of(context).colorScheme.surface,
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
                      return CommonLocationCard(
                        locationLoadedState: state,
                        imagesLocationModel: imagesLocation,
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
