import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:miniprojeto02_todolist/main.dart';
import 'package:miniprojeto02_todolist/models/tarefa.dart';

class TarefaLista extends StatelessWidget {
  List<Tarefa> _tarefaLista;

  TarefaLista(this._tarefaLista);

  final ScrollController _scrollController = ScrollController();
  bool isChecked = false;

  _deleteTarefa(value) {
    for (var i = 0; i < _tarefaLista.length; i++) {
      if (_tarefaLista[i].id == value) {
        _tarefaLista.removeAt(i);
      }
    }
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.purple;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      controller: _scrollController,
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: _tarefaLista.length,
          itemBuilder: (context, index) {
            final tarefa = _tarefaLista[index];
            return Card(
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color:
                                tarefa.data_execucao.day >= DateTime.now().day
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.red),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                          DateFormat('d MMM y').format(tarefa.data_execucao),
                          style: TextStyle(
                              color:
                                  tarefa.data_execucao.day >= DateTime.now().day
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.red))),
                  Container(
                      width: 65,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Text(tarefa.titulo)),
                  Container(
                    width: 60,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Text(tarefa.prioridade,
                        style: TextStyle(
                            color: tarefa.prioridade == 'Normal'
                                ? Colors.purple
                                : (tarefa.prioridade == 'Baixa'
                                    ? Colors.blue
                                    : Colors.redAccent))),
                  ),
                  Checkbox(
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    checkColor: Theme.of(context).colorScheme.primary,
                    value: isChecked,
                    onChanged: (bool? value) {
                      _deleteTarefa(tarefa.id);
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
