class FaqModel {
  int? id;
  String? question;
  String? answer;

  FaqModel({this.id, this.question, this.answer});

  static FaqModel fromJsonModel(Object? json) => FaqModel.fromJson(json as Map<String, dynamic>);

  FaqModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}
