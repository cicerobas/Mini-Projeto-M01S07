class DB {
  final List<Map<String, dynamic>> _taskData = [
    {
      'id': 1,
      'titulo': ' Corrigir bug login ',
      'responsavel': 'Ana',
      'status': 'concluida',
      'prioridade': 'alta',
      'valor': 'R\$ 120,00',
      'horas': '2',
    },
    {
      'id': 2,
      'titulo': 'Criar tela de perfil',
      'responsavel': ' Bruno ',
      'status': 'em andamento',
      'prioridade': 'media',
      'valor': 'R\$ 250,50',
      'horas': '5',
    },
    {
      'id': 3,
      'titulo': null,
      'responsavel': 'Carla',
      'status': 'pendente',
      'prioridade': 'baixa',
      'valor': 'R\$ 80,00',
      'horas': null,
    },
    {
      'id': 4,
      'titulo': ' Ajustar navegação ',
      'responsavel': null,
      'status': 'concluida',
      'prioridade': 'alta',
      'valor': 'R\$ 150,75',
      'horas': '3',
    },
    {
      'id': 5,
      'titulo': 'Revisar regras de negócio',
      'responsavel': 'Daniel',
      'status': 'cancelada',
      'prioridade': 'media',
      'valor': 'R\$ 0,00',
      'horas': '0',
    },
    {
      'id': 6,
      'titulo': 'Implementar validação de dados',
      'responsavel': 'Eduarda',
      'status': 'concluida',
      'prioridade': 'alta',
      'valor': 'R\$ 200,00',
      'horas': '4',
    },
    {
      'id': 7,
      'titulo': 'Organizar documentação',
      'responsavel': 'Felipe',
      'status': 'pendente',
      'prioridade': 'baixa',
      'valor': 'R\$ 90,00',
      'horas': '2',
    },
  ];

  List<Map<String, dynamic>> get taskData => _taskData;
}
