class ProgramDayTask{
  int? id;
  int? isCompleted;
  String? date;
  String? taskDay;
  String? content;

  ProgramDayTask({
    this.id,
    this.isCompleted,
    this.date,
    this.taskDay,
    this.content
});

  ProgramDayTask.fromJson(Map<String, dynamic> json){
    id = json['id'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    taskDay = json['taskDay'];
    content = json['content'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['taskDay'] = this.taskDay;
    data['content'] = this.content;
    return data;
  }
}