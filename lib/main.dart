import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/features/auth/presentation/screens/login_screen.dart';
import 'package:rick_and_morty/firebase_options.dart';
import 'package:rick_and_morty/generated/l10n.dart';
import 'package:rick_and_morty/internal/components/bottom_navbar.dart';
import 'package:rick_and_morty/internal/constants/theme_mode/theme_provider.dart';
import 'package:rick_and_morty/internal/helpers/localization/bloc/localization_bloc.dart';
import 'package:rick_and_morty/internal/helpers/localization/localization_hive.dart';

Future<void> main() async {
  await initMyHive();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? locale;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalizationBloc()
        ..add(
          ChangeLocaleEvent(
            locale: LocalizationHive.getLocale(),
          ),
        ),
      child: BlocConsumer<LocalizationBloc, LocalizationState>(
        listener: (context, state) {
          if (state is LocalizationLoadedState) {
            locale = state.updatedLocale;
          }
        },
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(361, 761),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: Locale.fromSubtags(languageCode: locale ?? 'ru \$'),
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: Provider.of<ThemeProvider>(context).themeData,
                home: const BottomNavBarScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
