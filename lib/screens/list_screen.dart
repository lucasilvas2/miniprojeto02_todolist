import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:miniprojeto02_todolist/components/TarefaLista.dart';
import 'package:miniprojeto02_todolist/models/tarefa.dart';

class ListScreen extends StatelessWidget {
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
                    Navigator.of(context).pushNamed('/add-tarefa');
                  },
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}
