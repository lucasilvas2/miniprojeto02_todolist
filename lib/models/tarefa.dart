enum Prioridade{
  Baixa, Normal, Alta
}

class Tarefa {
  String id;
  String titulo;
  DateTime data_criacao;
  DateTime data_execucao;
  String prioridade;
  String comentario;

  Tarefa({required this.id,required this.data_criacao, required this.titulo, required this.data_execucao, required this.comentario, required this.prioridade});
}
