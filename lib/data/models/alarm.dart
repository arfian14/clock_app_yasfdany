import 'dart:convert';

class Alarm {
  String title;
  DateTime time;
  Map dayLoop;
  int color;
  int ringtone;
  bool active;

  Alarm({
    this.title,
    this.time,
    this.dayLoop,
    this.color,
    this.ringtone,
    this.active = true,
  });

  factory Alarm.fromJson(Map<String, dynamic> json) => Alarm(
        title: json["title"] == null ? null : json["title"],
        color: json["color"] == null ? null : json["color"],
        active: json["active"] == null ? true : json["active"],
        ringtone: json["ringtone"] == null ? null : json["ringtone"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        dayLoop: json["dayLoop"] == null ? null : jsonDecode(json["dayLoop"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "color": color == null ? null : color,
        "active": active == null ? true : active,
        "ringtone": ringtone == null ? null : ringtone,
        "time": time == null ? null : time.toIso8601String(),
        "dayLoop": dayLoop == null ? null : jsonEncode(dayLoop),
      };
}
