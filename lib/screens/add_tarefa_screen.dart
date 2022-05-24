import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:miniprojeto02_todolist/components/TarefaForm.dart';
import 'package:miniprojeto02_todolist/models/tarefa.dart';

class AddTarefaScreen extends StatefulWidget {
  @override
  State<AddTarefaScreen> createState() => _AddTarefaScreenState();
}

class _AddTarefaScreenState extends State<AddTarefaScreen> {
  @override
  Widget build(BuildContext context) {
    final _listaTarefa =
        ModalRoute.of(context)!.settings.arguments as List<Tarefa>;

    return Scaffold(
      appBar: AppBar(title: Text('Add tarefa')),
      body: Text('add tarefa'),
    );
  }
}
