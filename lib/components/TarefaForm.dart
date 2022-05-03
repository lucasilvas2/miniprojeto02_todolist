import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Prioridade { 
  baixa, alta, normal
}

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

    widget.onSubmit(titulo, _dataSelecionada, comentario, prioridadeEscolhida!.toShortString());
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

  Prioridade? prioridadeEscolhida = Prioridade.normal;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
        controller: _tarefaController,
        decoration: InputDecoration(labelText: 'Tarefa'),
      ),
      TextField(
        controller: _comentarioController,
        decoration: InputDecoration(labelText: 'Comentário'),
      ),
      Text('Prioridade'),
      ListTile(
        title: const Text('Baixa'),
        leading: Radio<Prioridade>(
          value: Prioridade.baixa,
          groupValue: prioridadeEscolhida,
          onChanged: (Prioridade? value) {
            setState(() {
              prioridadeEscolhida = value;
              print(prioridadeEscolhida!.toShortString());
            });
          },
        ),
      ),
      ListTile(
        title: const Text('Normal'),
        leading: Radio<Prioridade>(
          value: Prioridade.normal,
          groupValue: prioridadeEscolhida,
          onChanged: (Prioridade? value) {
            setState(() {
              prioridadeEscolhida = value;
              print(prioridadeEscolhida);
            });
          },
        ),
      ),
      ListTile(
        title: const Text('Alta'),
        leading: Radio<Prioridade>(
          value: Prioridade.alta,
          groupValue: prioridadeEscolhida,
          onChanged: (Prioridade? value) {
            setState(() {
              prioridadeEscolhida = value;
              print(prioridadeEscolhida);
            });
          },
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
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(onPressed: _submitForm, child: Text('Confirmar')),
      ),
    ]);
  }
}
