class NotificationModel {
  int? id;
  String? title;
  String? body;
  String? createdAt;
  bool? read;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.createdAt,
    this.read,
  });

  static NotificationModel fromJsonModel(Object? json) => NotificationModel.fromJson(json as Map<String, dynamic>);

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['created_at'];
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['created_at'] = createdAt;
    data['read'] = read;
    return data;
  }
}
