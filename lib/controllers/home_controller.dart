import 'dart:convert';
import '../api/api_client.dart';
import '../models/chinese_food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class HomeController extends ChangeNotifier {
  Client httpClient = Client();
  late ApiClient apiClient;
  List<ChineseFoodModel> chineseFoodModel = [];

  init() {
    apiClient = ApiClient(httpClient: httpClient);
    fetchChineseFood();
  }

  void fetchChineseFood() async {
    await apiClient.getAllFoods().then((response) {
      if (response != null) {
        Logger().i('Response: ${response.body}');
        final List<dynamic> body = jsonDecode(response.body);
        chineseFoodModel =
            body.map((item) => ChineseFoodModel.fromJson(item)).toList();
        notifyListeners();
      } else {
        Logger().e('Failed to fetch food info.');
      }
    });
  }
}
