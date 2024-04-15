import 'dart:convert';

//UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// class UserModel {
//   final String status;
//   List<Data> data;
//   UserModel({this.status = "NoStatus", this.data = const []});

//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         status: json["status"],
//         data: List<Data>.from(json["data"].map((e) => Data.fromJson(e))),
//       );
// }

// class Data {
//   final int id;
//   final String name;
//   Data({this.id = 0, this.name = "NoName"});

//   factory Data.fromJson(Map<String, dynamic> json) =>
//       Data(id: json["id"], name: json["name"]);
// }

// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);


UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    List<Data> data;

    UserModel({
        required this.data,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Data {
    int id;
    String name;

    Data({
        required this.id,
        required this.name,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
