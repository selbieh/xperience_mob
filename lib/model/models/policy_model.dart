class PolicyModel {
  String? key;
  String? content;

  PolicyModel({this.key, this.content});

  static PolicyModel fromJsonModel(Object? json) => PolicyModel.fromJson(json as Map<String, dynamic>);

  PolicyModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['content'] = content;
    return data;
  }
}
