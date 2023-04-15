import 'package:meta/meta.dart';
import 'dart:convert';

Institute instituteFromJson(String str) => Institute.fromJson(json.decode(str));

String instituteToJson(Institute data) => json.encode(data.toJson());

class Institute {
  Institute({
    required this.iId,
    required this.iShName,
    required this.iFlName,
  });

  final String iId;
  final String iShName;
  final String iFlName;

  factory Institute.fromJson(Map<String, dynamic> json) => Institute(
    iId: json["I_ID"],
    iShName: json["I_SH_NAME"],
    iFlName: json["I_FL_NAME"],
  );

  Map<String, dynamic> toJson() => {
    "I_ID": iId,
    "I_SH_NAME": iShName,
    "I_FL_NAME": iFlName,
  };
}
