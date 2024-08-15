import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/location/data/repository/location_repository_impl.dart';
import 'package:rick_and_morty/features/location/domain/location_use_case/location_use_case.dart';
import 'package:rick_and_morty/features/location/presentation/logic/bloc/location_bloc.dart';

class LocationInfoScreen extends StatefulWidget {
  final int id;
  const LocationInfoScreen({super.key, required this.id});

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/earth.png', // путь к изображению земли
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
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
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is LocationInfoLoadedState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Земля С-137',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Мир · Измерение С-137',
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
                        CharacterTile(
                          name: 'Рик Санчез',
                          subtitle: 'Человек, Мужской',
                          imageUrl: 'assets/images/rick_sanchez.png',
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

class CharacterTile extends StatelessWidget {
  final String name;
  final String subtitle;
  final String imageUrl;

  const CharacterTile({
    super.key,
    required this.name,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundImage: AssetImage(imageUrl),
        radius: 24,
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {},
    );
  }
}
