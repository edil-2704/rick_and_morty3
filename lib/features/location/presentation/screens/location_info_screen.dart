import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/location/data/models/location_image_model.dart';
import 'package:rick_and_morty/features/location/data/models/location_model.dart';
import 'package:rick_and_morty/features/location/data/repository/location_repository_impl.dart';
import 'package:rick_and_morty/features/location/domain/location_use_case/location_use_case.dart';
import 'package:rick_and_morty/features/location/presentation/logic/bloc/location_bloc.dart';

class LocationInfoScreen extends StatefulWidget {
  final int id;
  final ImagesLocationModel? imagesLocationModel;

  const LocationInfoScreen({
    super.key,
    required this.id,
    this.imagesLocationModel,
  });

  @override
  State<LocationInfoScreen> createState() => _LocationInfoScreenState();
}

class _LocationInfoScreenState extends State<LocationInfoScreen> {
  final LocationBloc locationBloc = LocationBloc(
      locationUseCase:
          LocationUseCase(locationRepositories: LocationRepositoryImpl()));

  @override
  void initState() {
    locationBloc.add(GetLocationsById(id: widget.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final url = imagesLocation.getNextImageUrl();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: 375.w,
                  height: 250.h,
                ),
                Positioned(
                  left: 16,
                  top: 40,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocConsumer<LocationBloc, LocationState>(
                bloc: locationBloc,
                listener: (context, state) {
                  if (state is LocationLoadingState) {
                    CircularProgressIndicator();
                  }

                  if (state is LocationErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error.message ?? '')));
                  }
                },
                builder: (context, state) {
                  if (state is LocationLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is LocationInfoLoadedState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.locationResult.name ?? '',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ' ${state.locationResult.type ?? ''} , ${state.locationResult.type ?? ''}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Это планета, на которой проживает человеческая раса, и главное место для персонажей Рика и Морти. Возраст этой Земли более 4,6 миллиардов лет, и она является четвертой планетой от своей звезды.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Персонажи',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.locationResult.residents?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Column(children: [

                            ],);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20.h);
                          },
                        ),
                      ],
                    );
                  }

                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
//
// class CommonCharLocListView extends StatelessWidget {
//   final LocationInfoLoadedState state;
//
//   const CommonCharLocListView({
//     super.key,
//     required this.widget,
//     required this.state,
//   });
//
//   final LocationInfoScreen widget;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: state.characterResult?.length ?? 0,
//       itemBuilder: (context, index) {
//         return Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 74.h,
//                   width: 74.w,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14.r),
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           state.characterResult?[index].image ?? ''),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: Container(
//                     alignment: Alignment.centerLeft,
//                     height: 62.h,
//                     width: 213.w,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             statusConverter(
//                                 state.characterResult?[index].status ??
//                                     Status.ALIVE) ??
//                                 '',
//                             style: TextStyle(
//                                 color: state.characterResult?[index].status ==
//                                     Status.ALIVE
//                                     ? AppColors.mainGreen
//                                     : AppColors.mainRed),
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             state.characterResult?[index].name ?? '',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 5.h),
//                         Expanded(
//                             child: Text(
//                               '${speciesConverter(state.characterResult?[index].species ?? Species.HUMAN) ?? ''}, ${genderConverter(state.characterResult?[index].gender ?? Gender.UNKNOWN) ?? ''}',
//                               style: TextHelper.mainCharGender,
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 SizedBox(
//                   height: 24.h,
//                   width: 24.w,
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => EpisodesInfoScreen(
//                             id: widget.id,
//                           ),
//                         ),
//                       );
//                     },
//                     icon: Icon(Icons.arrow_forward_ios_sharp),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//       separatorBuilder: (context, index) {
//         return const SizedBox(height: 20);
//       },
//     );
//   }
// }
