import 'dart:convert';

List<VolunteerActivity> volunteerActivityFromJson(String str) =>
    List<VolunteerActivity>.from(
        json.decode(str).map((x) => VolunteerActivity.fromJson(x)));

String volunteerActivityToJson(List<VolunteerActivity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VolunteerActivity {
  int id;
  String name;
  String description;
  double moneyGoal;
  DateTime dateVolunteerCreated;
  DateTime endDate;
  String image;
  List<Tag> tags;
  Contract contract;

  VolunteerActivity({
    required this.id,
    required this.name,
    required this.description,
    required this.moneyGoal,
    required this.dateVolunteerCreated,
    required this.endDate,
    required this.image,
    required this.tags,
    required this.contract,
  });

  factory VolunteerActivity.fromJson(Map<String, dynamic> json) {
    return VolunteerActivity(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      moneyGoal: (json["money_goal"] != null)
          ? double.tryParse(json["money_goal"].toString()) ?? 0.0
          : 0.0,
      dateVolunteerCreated: DateTime.parse(json["date_volunteer_created"]),
      endDate: DateTime.parse(json["end_date"]),
      image: json["image"],
      tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      contract: json.containsKey("contract")
          ? Contract.fromJson(json["contract"])
          : Contract(contractAddress: ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "money_goal": moneyGoal,
        "date_volunteer_created": dateVolunteerCreated.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "image": image,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "contract": contract.toJson(),
      };
}

class Contract {
  String contractAddress;

  Contract({
    required this.contractAddress,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        contractAddress: json["contract_address"],
      );

  Map<String, dynamic> toJson() => {
        "contract_address": contractAddress,
      };
}

class Tag {
  int id;
  String name;

  Tag({
    required this.id,
    required this.name,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
