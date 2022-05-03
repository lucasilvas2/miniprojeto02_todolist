import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Prioridade{baixa, alta, normal}
class TarefaForm extends StatefulWidget {
  void Function(String, DateTime, String) onSubmit;

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

    widget.onSubmit(titulo, _dataSelecionada, comentario);
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
      // DropdownButton<String>(
      //   value: prioridadeEscolhida,
      //   //icon: const Icon(Icons.arrow_downward),
      //   //elevation: 16,
      //   //style: const TextStyle(color: Colors.deepPurple),
      //   underline: Container(
      //     height: 2,
      //     color: Colors.deepPurpleAccent,
      //   ),
      //   onChanged: (String? newValue) {
      //     setState(() {
      //       prioridadeEscolhida = newValue!;
      //     });
      //   },
      //   items: <String>['Baixa','Normal', 'Alta']
      //       .map<DropdownMenuItem<String>>((String value) {
      //     return DropdownMenuItem<String>(
      //       value: value,
      //       child: Text(value),
      //     );
      //   }).toList(),
      // ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              children: [
                ListTile(
                  title: const Text('Baixa'),
                  leading: Radio<Prioridade>(
                    value: Prioridade.baixa,
                    groupValue: prioridadeEscolhida,
                    onChanged: (Prioridade? value) {
                      setState(() {
                        prioridadeEscolhida = value;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                ListTile(
                  title: const Text('Normal'),
                  leading: Radio<Prioridade>(
                    value: Prioridade.normal,
                    groupValue: prioridadeEscolhida,
                    onChanged: (Prioridade? value) {
                      setState(() {
                        prioridadeEscolhida = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                ListTile(
                  title: const Text('Alta'),
                  leading: Radio<Prioridade>(
                    value: Prioridade.alta,
                    groupValue: prioridadeEscolhida,
                    onChanged: (Prioridade? value) {
                      setState(() {
                        prioridadeEscolhida = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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
