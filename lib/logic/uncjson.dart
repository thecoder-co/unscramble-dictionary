import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

class Welcome {
  Welcome({
    this.string,
    this.unscrambledWords,
    this.time,
  });

  String? string;
  List<String>? unscrambledWords;
  double? time;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        string: json["string"],
        unscrambledWords:
            List<String>.from(json["unscrambled_words"].map((x) => x)),
        time: json["time"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "string": string!,
        "unscrambled_words":
            List<dynamic>.from(unscrambledWords!.map((x) => x)),
        "time": time!,
      };
}
