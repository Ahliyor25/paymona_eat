import 'package:dart_lesson/domain/api_client/api_client.dart';
import 'package:dart_lesson/domain/entity/eat.dart';
import 'package:dart_lesson/ui/navigation/main_navigation.dart';

import 'package:flutter/material.dart';

class EatListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _eats = <Eat>[];
  List<Eat> get eats => List.unmodifiable(_eats);
  late int _page = 0;
  var _isLoad = false;
  Future<void> loadEats() async {
    final nextpage = _page + 1;
    try {
      final eatsRes = await _apiClient.popularEat(nextpage);

      if (_isLoad || eatsRes.count <= _page) return;
      _isLoad = true;
      if (eatsRes.count > _page) {
        _page++;
      }
      ;
      _eats.addAll(eatsRes.eats);
      _isLoad = false;
      notifyListeners();
    } catch (e) {
      _isLoad = false;
    }
  }

  void onEatTap(BuildContext context, int index) {
    final id = _eats[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id,
    );
  }

  void showEatAtIndex(int index) {
    if (index < _eats.length - 1) return;
    loadEats();
  }
}
