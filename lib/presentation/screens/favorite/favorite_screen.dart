import 'package:auto_route/auto_route.dart';
import 'package:cine_favorite/helper/utils.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Favorite"),
      body: const Center(
        child: Text('Favorite Screen'),
      ),
    );
  }
}
