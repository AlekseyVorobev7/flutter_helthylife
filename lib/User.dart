class UserModel {
  String? firstname;
  String? secondname;
  String? school;
  String? email;
  int? balanc;
  int? clas;
  int? complete_tasks;
  bool? fir_task;
  bool? sec_task;
  bool? thi_task;
  bool? fou_task;
  bool? fith_task;

  UserModel();

  UserModel.formJson(Map<String, dynamic> json) {
    firstname = json['first name'];
    secondname = json['second name'];
    school = json['scholl'];
    email = json['email'];
    balanc = json['balanc'];
    clas = json['class'];
    complete_tasks = json['complete tasks'];
    fir_task = json['is first task'];
    sec_task = json['is second task'];
    thi_task = json['is third task'];
    fou_task = json['is fourth task'];
    fith_task = json['is fith task'];
  }
}
