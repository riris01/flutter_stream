import 'package:flutter/material.dart';
import 'package:flutter_steam/widgets/one_steam.dart';

class SteamPage extends StatelessWidget {
  const SteamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var padding = constraints.maxWidth / 8;
          return Stack(
              children: List.generate(
                  OneSteam.maxSteamNumber,
                  (index) => OneSteam(
                      index: index,
                      screen: Size(constraints.maxWidth - padding * 2,
                          constraints.maxHeight),
                      sidePadding: padding)));
        },
      ),
    );
  }
}
