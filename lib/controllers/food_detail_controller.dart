
import 'package:chinoot/api/api_client.dart';
import 'package:chinoot/models/detail_foods_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class FoodDetailController extends ChangeNotifier {
  Client httpClient = Client();
  late ApiClient apiClient;

  DetailFoodsModel? detailFoodsModel;

  FoodDetailController() {
    apiClient = ApiClient(httpClient: httpClient);
  }

  void fetchFoodDetails(String id) async {
    try {
      final response = await apiClient.getFoodDetailById(id);
      if (response != null) {
        Logger().i('Response: $response');
        detailFoodsModel = DetailFoodsModel.fromJson(response);
        notifyListeners();
      } else {
        Logger().e('Failed to fetch food info.');
      }
    } catch (e) {
      Logger().e('Error occurred while fetching food details: $e');
    }
  }
}
