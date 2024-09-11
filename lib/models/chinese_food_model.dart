class ChineseFoodModel{
  String? id;
  String? title;
  String? difficulty;
  String? image;

  ChineseFoodModel({this.id, this.title, this.difficulty, this.image});

  ChineseFoodModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    difficulty = json['difficulty'];
    image = json['image'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String,dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['difficulty'] = this.difficulty;
    data['image'] = this.image;
    return data;
  }

}