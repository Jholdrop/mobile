import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa02_todolist/controller/tarefa_controller.dart';
import 'package:sa02_todolist/view/tarefas_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TarefaController(),
      child: const MaterialApp(home: TarefaPage()),
    );
  }
}
