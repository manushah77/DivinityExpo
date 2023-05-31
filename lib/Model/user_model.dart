class SignUpModel {
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userPasword;
  String? userConfrimPasword;

  SignUpModel({
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userPasword,
    this.userConfrimPasword,
  });

  SignUpModel.fromJson(Map<String, dynamic> map) {
    userName = map['fullName'];
    userPhone = map['phone'];
    userEmail = map['email'];
    userPasword = map['password'];
    userConfrimPasword = map['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fullName'] = userName;
    _data['phone'] = userPhone;
    _data['email'] = userEmail;
    _data['password'] = userPasword;
    _data['password_confirmation'] = userConfrimPasword;
    return _data;
  }
}
