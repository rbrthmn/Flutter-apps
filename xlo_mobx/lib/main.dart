import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlomobx/screens/base/base_screen.dart';
import 'package:xlomobx/stores/page_store.dart';
import 'package:xlomobx/stores/user_manager_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setUpLocators();
  runApp(MyApp());
}

Future<void> initializeParse() async {
  await Parse().initialize(
      'MyU8p7SxSrLOlos4ydVo0KOImuRCRjJ7H54sfuPM',
      'https://parseapi.back4app.com/',
      clientKey: '57UEnRXnYlpgHCvDabTKdA17Sxny3mD4QN1tNylR',
      autoSendSessionId: true,
      debug: true
  );
}

void setUpLocators() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(UserManagerStore());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.purple,
        appBarTheme: AppBarTheme(
          elevation: 0
        ),
        cursorColor: Colors.orange
      ),
      debugShowCheckedModeBanner: false,
      home: BaseScreen(),
    );
  }
}
