import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:miniprojeto02_todolist/components/TarefaForm.dart';

class AddTarefaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add tarefa')),
      body: Text('Add tarefa'),
    );
  }
}
