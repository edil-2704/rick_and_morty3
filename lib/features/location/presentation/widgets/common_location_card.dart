import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/common_progress_indicator.dart';
import 'package:rick_and_morty/features/location/data/models/location_image_model.dart';
import 'package:rick_and_morty/features/location/data/models/location_model.dart';
import 'package:rick_and_morty/features/location/presentation/logic/bloc/location_bloc.dart';
import 'package:rick_and_morty/features/location/presentation/screens/location_info_screen.dart';
import 'package:rick_and_morty/internal/constants/text_helper/text_helper.dart';

class CommonLocationCard extends StatefulWidget {
  final ImagesLocationModel imagesLocationModel;
  final List<LocationResult> locationsList;
  final ScrollController scrollController;

  const CommonLocationCard({
    super.key,
    required this.locationsList,
    required this.imagesLocationModel,
    required this.scrollController,
  });

  @override
  State<CommonLocationCard> createState() => _CommonLocationCardState();
}

class _CommonLocationCardState extends State<CommonLocationCard> {
  final ScrollController scrollController2 = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        ListView.separated(

          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.locationsList.length ?? 0,
          itemBuilder: (context, index) {
            final url = imagesLocation.getNextImageUrl();

            if (index >= widget.locationsList.length - 1) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: CommonProgressIndicator(),
              );
            }

            return InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationInfoScreen(
                      id: widget.locationsList[index].id ?? 0,
                    ),
                  ),
                );
              },
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.network(
                              url,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 218.h,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.locationsList[index].name ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${widget.locationsList[index].type ?? ''} , ${widget.locationsList[index].dimension ?? ''}',
                                  style: TextHelper.charSexText,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
        ),
      ],
    );
  }
}
