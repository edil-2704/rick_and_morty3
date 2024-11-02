import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/character_info_screen.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/common_chars_shimmer.dart';
import 'package:rick_and_morty/features/location/data/models/location_image_model.dart';
import 'package:rick_and_morty/features/location/presentation/logic/bloc/location_bloc.dart';
import 'package:rick_and_morty/internal/constants/utils/common_inkwell_char.dart';
import 'package:rick_and_morty/internal/constants/utils/enum_funcs.dart';
import 'package:rick_and_morty/internal/dependencies/get_it.dart';

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
  final LocationBloc locationBloc = getIt<LocationBloc>();

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
                  width: 390.w,
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
                  if (state is LocationErrorState) {
                    return Center(
                      child: ElevatedButton(
                          onPressed: () {
                            locationBloc.add(GetLocationsById(id: widget.id));
                          },
                          child: Text('Нажмите чтобы обновить')),
                    );
                  }
                  if (state is LocationLoadingState) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return CommonCharsShimmer();
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20.h);
                          },
                        ),
                      ),
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
                         SizedBox(height: 4.h),
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
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          'Персонажи',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                         SizedBox(height: 16.h),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              state.locationResult.residents?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                CommonCharInkwell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CharacterInfoScreen(
                                          id: state.residentsModel[index].id ??
                                              0,
                                        ),
                                      ),
                                    );
                                  },
                                  status:
                                      '${statusConverter(state.residentsModel[index].status ?? Status.ALIVE) ?? ''}',
                                  name:
                                      '${state.residentsModel[index].name ?? ''}',
                                  species:
                                      '${speciesConverter(state.residentsModel[index].species ?? Species.HUMAN) ?? ''}, ${genderConverter(state.residentsModel[index].gender ?? Gender.UNKNOWN) ?? ''}',
                                  imageUrl:
                                      '${state.residentsModel[index].image ?? ''}',
                                ),
                              ],
                            );
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
