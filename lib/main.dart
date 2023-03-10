import 'package:flutter/material.dart';
import 'package:open_weather_app/location_helper.dart';
import 'package:open_weather_app/presentation/home/home_view.dart';

import 'presentation/search/search_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocationHelper locationHelper = LocationHelper();
  await locationHelper.locationControle();
  await locationHelper.pullLocation();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Barlow'),
      home: Scaffold(
          body: PageView(
        children: const [HomeView(), SearchView()],
      )),
      debugShowCheckedModeBanner: false,
    );
  }
}
