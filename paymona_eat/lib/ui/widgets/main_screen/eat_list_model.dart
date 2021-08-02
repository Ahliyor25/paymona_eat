import 'package:dart_lesson/domain/api_client/api_client.dart';
import 'package:dart_lesson/domain/entity/eat.dart';
import 'package:dart_lesson/ui/navigation/main_navigation.dart';

import 'package:flutter/material.dart';

class EatListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _eats = <Eat>[];
  List<Eat> get eats => List.unmodifiable(_eats);

  Future<void> loadEats() async {
    final eatsRes = await _apiClient.popularEat(1);
    _eats.addAll(eatsRes.eats);
    notifyListeners();
  }

  void onEatTap(BuildContext context, int index) {
    final id = _eats[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id,
    );
  }
}
