class Task {
  String? title;
  String? description;
  DateTime? time;
  int? dayOfWeek;

  Task({this.title, this.description, this.time, this.dayOfWeek});

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    final timeString = json['time'];
    time = timeString != null ? DateTime.parse(timeString) : null;
    dayOfWeek = json['dayOfWeek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['time'] = time != null
        ? time!.toIso8601String()
        : null; // Salvando o horário como string no formato "HH:mm".
    data['dayOfWeek'] = dayOfWeek;
    return data;
  }

  @override
  String toString() =>
      "Task: title: $title,  description: $description, time: $time , dayOfWeek: $dayOfWeek";
}
