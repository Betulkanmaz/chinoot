class DetailFoodsModel {
  String? id;
  String? title;
  String? difficulty;
  String? portion;
  String? time;
  String? description;
  List<String>? ingredients;
  List<Method>? method;
  String? image;

  DetailFoodsModel(
      {this.id,
        this.title,
        this.difficulty,
        this.portion,
        this.time,
        this.description,
        this.ingredients,
        this.method,
        this.image});

  DetailFoodsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    difficulty = json['difficulty'];
    portion = json['portion'];
    time = json['time'];
    description = json['description'];
    ingredients = json['ingredients'].cast<String>();
    if (json['method'] != null) {
      method = <Method>[];
      json['method'].forEach((v) {
        method!.add(Method.fromJson(v));
      });
    }
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['difficulty'] = difficulty;
    data['portion'] = portion;
    data['time'] = time;
    data['description'] = description;
    data['ingredients'] = ingredients;
    if (method != null) {
      data['method'] = method!.map((v) => v.toJson()).toList();
    }
    data['image'] = image;
    return data;
  }
}

class Method {
  List<String>? steps;

  Method({this.steps});

  Method.fromJson(Map<String, dynamic> json) {
    steps = [];
    json.forEach((key, value) {
      if (key.startsWith('Step')) {
        steps!.add(value);
      }
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (steps != null) {
      for (int i = 0; i < steps!.length; i++) {
        data['Step ${i + 1}'] = steps![i];
      }
    }
    return data;
  }
}
