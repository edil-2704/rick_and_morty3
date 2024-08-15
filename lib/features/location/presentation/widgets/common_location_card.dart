import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/location/data/models/location_image_model.dart';
import 'package:rick_and_morty/features/location/presentation/logic/bloc/location_bloc.dart';
import 'package:rick_and_morty/features/location/presentation/screens/location_info_screen.dart';
import 'package:rick_and_morty/internal/constants/text_helper/text_helper.dart';

class CommonLocationCard extends StatefulWidget {
  final LocationLoadedState locationLoadedState;
  final ImagesLocationModel imagesLocationModel;

  const CommonLocationCard({
    super.key,
    required this.locationLoadedState,
    required this.imagesLocationModel,
  });

  @override
  State<CommonLocationCard> createState() => _CommonLocationCardState();
}

class _CommonLocationCardState extends State<CommonLocationCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Всего локаций: ${widget.locationLoadedState.locationModel.info?.count ?? 0}',
          style: TextHelper.totalChar,
        ),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:
              widget.locationLoadedState.locationModel.results?.length ?? 0,
          itemBuilder: (context, index) {
            final url = imagesLocation.getNextImageUrl();

            return InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationInfoScreen(
                        id: widget.locationLoadedState.locationModel
                                .results?[index].id ??
                            0),
                  ),
                );
              },
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
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
                              height: 218,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.locationLoadedState.locationModel
                                          .results?[index].name ??
                                      '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${widget.locationLoadedState.locationModel.results?[index].type ?? ''} , ${widget.locationLoadedState.locationModel.results?[index].dimension ?? ''}',
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
