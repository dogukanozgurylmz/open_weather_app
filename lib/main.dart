import 'package:flutter/material.dart';
import 'package:open_weather_app/location_helper.dart';
import 'package:open_weather_app/repository/fetch_data.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FetchData fetchData;
  // late LocationHelper locationHelper;
  bool isLoading = true;

  Future<void> _fetchData() async {
    await fetchData.fetchWeatherData();
    await fetchData.fetchOpenWeatherData();
    await fetchData.fetchMainData();
    await fetchData.fetchWindData();
    changeLoading();
  }

  void changeLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData = FetchData();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: !isLoading
          ? Center(
              child: Column(
                children: [
                  Text(
                    fetchData.weatherModel?.description ?? "veri yok",
                  ),
                  Text(
                    fetchData.mainModel?.temp.toString() ?? "veri yok",
                  ),
                  Text(
                    fetchData.windModel?.speed.toString() ?? "veri yok",
                  ),
                  Text(
                    fetchData.openWeatherModel?.name ?? "veri yok",
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
