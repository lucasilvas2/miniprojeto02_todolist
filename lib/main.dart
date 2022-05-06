//developed by Jean Lima

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:miniprojeto02_todolist/components/TarefaForm.dart';
import 'package:miniprojeto02_todolist/components/TarefaLista.dart';
import 'package:miniprojeto02_todolist/models/tarefa.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.purple,
                secondary: Colors.amber,
              )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _novaTarefa(
      String titulo, DateTime data_, String comentario, String prioridade) {
    Tarefa novaTarefa = Tarefa(
        id: Random().nextInt(9999).toString(),
        data_criacao: DateTime.now(),
        titulo: titulo,
        data_execucao: data_,
        prioridade: prioridade,
        comentario: comentario);

    setState(() {
      _tarefas.add(novaTarefa);
    });

    print(titulo);
  }

  List<Tarefa> _tarefas = [
    // Tarefa(
    //     id: 't0',
    //     titulo: 'Estudar',
    //     data_execucao: DateTime.now(),
    //     data_criacao: DateTime.now(),
    //     prioridade: 'Normal',
    //     comentario: 'um'),
    // Tarefa(
    //     id: 't1',
    //     titulo: 'Jogar',
    //     data_execucao: DateTime.now(),
    //     data_criacao: DateTime.now(),
    //     prioridade: 'Alta',
    //     comentario: 'dois'),
    // Tarefa(
    //     id: 't2',
    //     titulo: 'Assistir',
    //     data_execucao: DateTime.now().subtract(Duration(days: 2)),
    //     data_criacao: DateTime.now(),
    //     prioridade: 'Baixa',
    //     comentario: 'três')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TarefaForm(_novaTarefa),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[TarefaLista(_tarefas)],
            )
          ],
        ),
      ),
    );
  }
}
