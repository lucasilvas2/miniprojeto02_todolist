import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:miniprojeto02_todolist/main.dart';
import 'package:miniprojeto02_todolist/models/tarefa.dart';

class TarefaLista extends StatefulWidget {
  final List<Tarefa> _tarefaLista;

  TarefaLista(this._tarefaLista);

  @override
  State<TarefaLista> createState() => _TarefaListaState();
}

class _TarefaListaState extends State<TarefaLista> {
  final ScrollController _scrollController = ScrollController();
  final List<Tarefa> tarefaListafiltro = [];

  bool isChecked = false;
  String? dropdownValue;
  String? dropdownValueData;


  _deleteTarefa(value) {
    for (var i = 0; i < widget._tarefaLista.length; i++) {
      if (widget._tarefaLista[i].id == value) {
        setState(() {
          widget._tarefaLista.removeAt(i);
        });
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
    return Container(
      child: widget._tarefaLista.isEmpty
          ? Text('Nenhuma tarefa cadastrada')
          : Container(
              height: 200,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('Filtro:')
                        ),
                        Container(
                          child: DropdownButton(
                            value: dropdownValue,
                            hint: Text('Prioridade'),
                            elevation: 16,
                            style: const TextStyle(color: Colors.purple),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['Todas', 'Baixa', 'Normal', 'Alta',]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          child: DropdownButton(
                            value: dropdownValueData,
                            hint: Text('Data'),
                            elevation: 16,
                            style: const TextStyle(color: Colors.purple),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValueData = newValue!;
                                print(DateFormat('d MMM y')
                                            .format(widget._tarefaLista[0].data_execucao));
                              });
                            },
                            items: <String>['Todas','01/02/22', '02/05/22', '03/05/12',]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Scrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    child: SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: widget._tarefaLista.length,
                        itemBuilder: (context, index) {
                          final tarefa = widget._tarefaLista[index];
                          return Card(
                            child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: tarefa.data_execucao.day >=
                                                  DateTime.now().day
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Colors.red),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                        DateFormat('d MMM y')
                                            .format(tarefa.data_execucao),
                                        style: TextStyle(
                                            color: tarefa.data_execucao.day >=
                                                    DateTime.now().day
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
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
                                Container(
                                  width: 5,
                                  height: 5,
                                  alignment: Alignment.centerRight,
                                  child: Checkbox(
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    checkColor:
                                        Theme.of(context).colorScheme.primary,
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      _deleteTarefa(tarefa.id);
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
