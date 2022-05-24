import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:miniprojeto02_todolist/components/TarefaForm.dart';
import 'package:miniprojeto02_todolist/components/TarefaLista.dart';
import 'package:miniprojeto02_todolist/models/tarefa.dart';

class ListScreen extends StatefulWidget {
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Tarefa> _listTarefa = [
    new Tarefa(
        id: 't1',
        data_criacao: DateTime.now(),
        titulo: 'Teste',
        data_execucao: DateTime.now(),
        comentario: 'testanto tela',
        prioridade: 'Alta'),
    new Tarefa(
        id: 't1',
        data_criacao: DateTime.now(),
        titulo: 'Teste 2',
        data_execucao: DateTime.now(),
        comentario: 'tela',
        prioridade: 'Baixa')
  ];

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
      _listTarefa.add(novaTarefa);
    });

    print(titulo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo list')),
      body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(child: TarefaLista(_listTarefa)),
              Container(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    // Navigator.of(context)
                    //     .pushNamed('/add-tarefa', arguments: _listTarefa);
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(child: TarefaForm(_novaTarefa));
                      },
                    );
                  },
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}
