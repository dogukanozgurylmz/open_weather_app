import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

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
      child: Column(
        children: [],
      ),
    );
  }
}
