import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Prioridade { Baixa, Alta, Normal }

extension ParseToString on Prioridade {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class TarefaForm extends StatefulWidget {
  void Function(String, DateTime, String, String) onSubmit;

  TarefaForm(this.onSubmit);

  @override
  State<TarefaForm> createState() => _TarefaFormState();
}

class _TarefaFormState extends State<TarefaForm> {
  final _tarefaController = TextEditingController();
  final _comentarioController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();
  _submitForm() {
    final titulo = _tarefaController.text;
    final comentario = _comentarioController.text;

    if (titulo.isEmpty) {
      return;
    }

    widget.onSubmit(titulo, _dataSelecionada, comentario,
        prioridadeEscolhida!.toShortString());
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2023))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dataSelecionada = pickedDate;
      });
    });
  }

  Prioridade? prioridadeEscolhida = Prioridade.Normal;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 270,
        child: Column(children: <Widget>[
          SizedBox(
            height: 40,
            child: TextField(
              controller: _tarefaController,
              decoration: InputDecoration(labelText: 'Tarefa'),
            ),
          ),
          SizedBox(
            height: 40,
            child: TextField(
              controller: _comentarioController,
              decoration: InputDecoration(labelText: 'Comentário'),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Prioridade',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              )),
          Container(
            height: 25,
            child: ListTile(
              title: const Text('Baixa'),
              leading: Radio<Prioridade>(
                value: Prioridade.Baixa,
                groupValue: prioridadeEscolhida,
                onChanged: (Prioridade? value) {
                  setState(() {
                    prioridadeEscolhida = value;
                    print(prioridadeEscolhida!.toShortString());
                  });
                },
              ),
            ),
          ),
          Container(
            height: 25,
            child: ListTile(
              title: const Text('Normal'),
              leading: Radio<Prioridade>(
                value: Prioridade.Normal,
                groupValue: prioridadeEscolhida,
                onChanged: (Prioridade? value) {
                  setState(() {
                    prioridadeEscolhida = value;
                    print(prioridadeEscolhida);
                  });
                },
              ),
            ),
          ),
          Container(
            height: 25,
            child: ListTile(
              title: const Text('Alta'),
              leading: Radio<Prioridade>(
                value: Prioridade.Alta,
                groupValue: prioridadeEscolhida,
                onChanged: (Prioridade? value) {
                  setState(() {
                    prioridadeEscolhida = value;
                    print(prioridadeEscolhida);
                  });
                },
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                      'Data selecionada ${DateFormat('dd/MM/y').format(_dataSelecionada)}'),
                ),
                TextButton(
                    onPressed: _showDatePicker, child: Text('Selecionar data'))
              ],
            ),
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: _submitForm, child: Text('Confirmar')),
            ),
          ),
        ]),
      ),
    );
  }
}
