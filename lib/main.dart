import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/theme_bloc.dart';
import 'package:wechat_redesign/data/models/authentication_model_impl.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/pages/home_page.dart';
import 'package:wechat_redesign/pages/splash_screen_page.dart';
import 'package:wechat_redesign/persistence/hive_constants.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/utils/material_color_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Hive.initFlutter();

  Hive.registerAdapter(MomentVOAdaptor());

  await Hive.openBox<MomentVO>(BOX_NAME_MOMENT_VO);
  await Hive.openBox<String>(BOX_NAME_THEME);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = AuthenticationModelImpl();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeBloc(),
      child: Consumer<ThemeBloc>(
        builder: (context, themeBloc, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeBloc.themeMode,
            theme: themeBloc.lightTheme,
            darkTheme: themeBloc.darkTheme,
            home:
                auth.isLoggedIn() ? const HomePage() : const SplashScreenPage(),
          );
        },
      ),
    );
  }
}
