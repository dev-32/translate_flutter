import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:translator/presentation/home/bloc/first_lang_cubit_controller.dart';
import 'package:translator/presentation/home/bloc/first_lang_sel_cubit.dart';
import 'package:translator/presentation/home/bloc/loading_cubit.dart';
import 'package:translator/presentation/home/bloc/second_lang_cubit.dart';
import 'package:translator/presentation/home/bloc/second_lang_sel_cubit.dart';
import 'package:translator/presentation/main/bloc/bottom_nav_bar_cubit.dart';
import 'package:translator/core/config/assets/theme/theme.dart';
import 'package:translator/presentation/main/bloc/theme_cubit.dart';
import 'package:translator/presentation/main/screen/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavbarCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (context) => FirstLangCubit()),
        BlocProvider(create: (context) => SecondLangCubit()),
        BlocProvider(create: (context) => LoadingCubit()),
        BlocProvider(create: (context) => FirstLangSelCubit()),
        BlocProvider(create: (context) => SecondLangSelCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Text Translator',
          home: const MainScreenPage(),
          themeMode: state,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
        );
      }),
    );
  }
}
