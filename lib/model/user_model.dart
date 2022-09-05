import 'dart:convert';
/// id : 3166
/// name : "Aamod Chattopadhyay"
/// email : "chattopadhyay_aamod@hodkiewicz-bartoletti.co"
/// gender : "female"
/// status : "inactive"

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());
class UserModel {
  UserModel({
      int? id, 
      String? name, 
      String? email, 
      String? gender, 
      String? status,}){
    _id = id;
    _name = name;
    _email = email;
    _gender = gender;
    _status = status;
}

  UserModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _gender = json['gender'];
    _status = json['status'];
  }
  int? _id;
  String? _name;
  String? _email;
  String? _gender;
  String? _status;
UserModel copyWith({  int? id,
  String? name,
  String? email,
  String? gender,
  String? status,
}) => UserModel(  id: id ?? _id,
  name: name ?? _name,
  email: email ?? _email,
  gender: gender ?? _gender,
  status: status ?? _status,
);
  int? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get gender => _gender;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['gender'] = _gender;
    map['status'] = _status;
    return map;
  }

}