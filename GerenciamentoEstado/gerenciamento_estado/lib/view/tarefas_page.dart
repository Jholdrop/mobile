import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa02_todolist/controller/tarefa_controller.dart';
import 'package:sa02_todolist/view/dashboard_page.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  //atributos
  final TextEditingController tarefaInput = TextEditingController();
  //final => recebe o valor uma única vez, depois não altera mais

  // lógica de construção da janela
  @override
  Widget build(BuildContext context) {
    //Controller => controller opera a interface do usuário e enviar a solicitação para o Model
    final tarefaController = Provider.of<TarefaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciador de Tarefas"),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DashboardPage()),
              );
            },
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            //input da tarefa
            TextField(
              //quem vai administrar o campo de texto é o tarefaInput
              controller: tarefaInput,
              decoration: InputDecoration(
                //labelText = PlaceHolder
                labelText: "Digite uma Tarefa",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  // ao apertar o botão, pega o texto do input e cria uma tarefa com o controller
                  onPressed: () {
                    tarefaController.criarTarefa(tarefaInput.text);
                    tarefaInput.clear();
                  },
                  icon: Icon(Icons.add),
                ),
              ),
            ),

            //listar as tarefas adicionadas
            Expanded(
              child: tarefaController.tarefas.isEmpty
                  ? Center(child: Text("Lista de Tarefas Vazia"))
                  : ListView.builder(
                      // ListView.builder == ForEach ; ele percorre uma lista para construir a interface
                      itemCount: tarefaController.tarefas.length,
                      itemBuilder: (context, index) {
                        //para cada tarefa da lista crie uma tarefa e um card
                        final tarefa = tarefaController.tarefas[index];
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.all(4),
                          child: ListTile(
                            leading: Checkbox(
                              value: tarefa.concluida,
                              //(_) => checkbox independe do value, o que importa é a ação de clicar
                              onChanged: (_) {
                                tarefaController.alterarTarefa(index);
                              },
                            ),
                            title: Text(
                              tarefa.titulo,
                              style: TextStyle(
                                decoration: tarefa.concluida
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            subtitle: Text(
                              tarefa.concluida ? "Concluida" : "Pendente",
                            ),
                            //delete
                            trailing: IconButton(
                              onPressed: () =>
                                  tarefaController.removerTarefa(index),
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
