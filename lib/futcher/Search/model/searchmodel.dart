// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  bool? success;
  List<Datum>? data;
  Links? links;
  Meta? meta;
  String ?message;

  SearchModel({
    this.success,
    this.data,
    this.links,
    this.meta,
    this.message,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links!.toJson(),
    "meta": meta!.toJson(),
    "message": message,
  };
}

class Datum {
  int ?id;
  String? name;
  String ?email;
  DateTime? lastSignInTime;
  String ?status;
  String ?fcmToken;
  Guard? guard;
  String? isOnline;
  DateTime? createdAt;
  DateTime ?updatedAt;
  String? uid;

  Datum({
    this.id,
    this.name,
    this.email,
    this.lastSignInTime,
    this.status,
    this.fcmToken,
    this.guard,
    this.isOnline,
    this.createdAt,
    this.updatedAt,
    this.uid,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    lastSignInTime: DateTime.parse(json["lastSignInTime"]),
    status: json["status"],
    fcmToken: json["FcmToken"],
    guard: guardValues.map[json["guard"]],
    isOnline: json["is_online"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "lastSignInTime": lastSignInTime!.toIso8601String(),
    "status": status,
    "FcmToken": fcmToken,
    "guard": guardValues.reverse[guard],
    "is_online": isOnline,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "uid": uid,
  };
}

enum Guard {
  USER
}

final guardValues = EnumValues({
  "user": Guard.USER
});

class Links {
  String? prev;
  String ?next;

  Links({
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int ?total;
  int? perPage;
  int? currentPage;
  int? lastPage;

  Meta({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json["total"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "per_page": perPage,
    "current_page": currentPage,
    "last_page": lastPage,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
