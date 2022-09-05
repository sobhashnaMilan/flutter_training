import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/utils/app_string.dart';
import 'package:flutter_training/utils/common/app_bar.dart';
import 'package:flutter_training/utils/styles_utils.dart';

class Credentials extends Equatable {
  const Credentials({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];

  @override
  bool get stringify => false;
}

class Person {
  const Person(this.name);

  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class EquatableDemo extends StatefulWidget {
  const EquatableDemo({Key? key}) : super(key: key);

  @override
  State<EquatableDemo> createState() => _EquatableDemoState();
}

class _EquatableDemoState extends State<EquatableDemo> {
  @override
  void initState() {
    super.initState();
    const credentialsA = Credentials(username: 'ok', password: 'ab123');
    const credentialsB = Credentials(username: 'okGoogle', password: 'abc');
    const credentialsC = Credentials(username: 'okGoogle', password: 'abc');
    flutterPrint(msg: (credentialsA == credentialsA).toString());
    flutterPrint(msg: (credentialsB == credentialsB).toString());
    flutterPrint(msg: credentialsA.toString());
    flutterPrint(msg: (credentialsC == credentialsC).toString());
    flutterPrint(msg: (credentialsA == credentialsB).toString());
    flutterPrint(msg: (credentialsB == credentialsC).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(toolbarText: AppString().btnEquatableDemo),
        body: const Center(child: Text("EquatableDemo")));
  }
}
