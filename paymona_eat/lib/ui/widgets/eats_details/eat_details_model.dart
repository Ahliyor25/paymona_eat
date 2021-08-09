import 'package:dart_lesson/domain/api_client/api_client.dart';
import 'package:dart_lesson/domain/entity/eat_details.dart';
import 'package:flutter/material.dart';

class EatDetailsModel extends ChangeNotifier {
  final _apiClinet = ApiClient();
  final int eatId;
  EatDetails? _eatDetails;

  EatDetails? get eatDetails => _eatDetails;
  EatDetailsModel(this.eatId);

  Future<void> loadDetails() async {
    _eatDetails = await _apiClinet.eatDetails(eatId);
    notifyListeners();
  }
}
