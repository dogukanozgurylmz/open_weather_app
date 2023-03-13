import 'package:flutter/material.dart';
import 'package:open_weather_app/api_url.dart';
import 'package:open_weather_app/model/weather_search_model.dart';
import 'package:open_weather_app/repository/weather_search_fetch.dart';
import 'package:open_weather_app/widgets/text_form_field_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();
  late List<WeatherSearchModel?> weatherSearchList;
  String apiUrlSearch = "";
  bool isLoad = false;
  @override
  void initState() {
    super.initState();
  }

  void checkUrl() async {
    ApiUrl api = ApiUrl();
    apiUrlSearch = api.apiUrlSearch(_controller.text);
  }

  Future<void> fetchSearch() async {
    setState(() {
      isLoad = false;
    });
    checkUrl();
    print(_controller.text);
    WeatherSearchFetch weatherSearchFetch = WeatherSearchFetch();
    weatherSearchList = (await weatherSearchFetch.getAll(apiUrlSearch))!;
    setState(() {
      isLoad = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xff02001E),
          Color(0xff05003F),
          Color(0xff5b0060),
        ],
        tileMode: TileMode.mirror,
      )),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormFieldWidget(
                // controller: controller,
                labelText: 'search...',
                onChanged: (text) {
                  setState(() {
                    _controller.text = text;
                    fetchSearch();
                  });
                },
              ),
              isLoad
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: weatherSearchList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              weatherSearchList[index]!.name.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : _controller.text.isEmpty
                      ? const SizedBox.shrink()
                      : const Center(
                          child: CircularProgressIndicator(),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
