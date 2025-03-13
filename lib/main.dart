import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'core/di/core_di.dart';
import 'modules/home/home.dart';
import 'router.dart';

final GetIt inject = GetIt.instance;
final Logger logger = Logger();
final router = FluroRouter();

main() async {
  Intl.defaultLocale = 'pt_BR';
  WidgetsFlutterBinding.ensureInitialized();
  defineRouter(router);

  await startModules();
  initializeDateFormatting('pt_BR', null).then((_) => runApp(const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
      ),
      home: const HomePresentation(),
    );
  }
}
