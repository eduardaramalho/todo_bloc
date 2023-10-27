import 'package:bloc_estudos/todo_bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'data/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  addTodo(Todo todo){
    context.read<TodoBloc>().add(
      AddTodo(todo)
    );
  }

  removeTodo(Todo todo){
    context.read<TodoBloc>().add(
      RemoveTodo(todo)
    );
  }

  alertTodo(int index){
    context.read<TodoBloc>().add(
      AlterTodo(index)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state){
            if(state.status == TodoStatus.success){
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, int i ){
                  return Card(
                    color: Theme.of(context).colorScheme.primary,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Slidable(
                      key: const ValueKey(0),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              removeTodo(state.todos[i]);
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ]),
                        child: ListTile(
                          title: Text(state.todos[i].title),
                          subtitle: Text(state.todos[i].subtitle),
                          trailing: Checkbox(
                            value: state.todos[i].isDone,
                            activeColor: Theme.of(context).colorScheme.secondary,
                            onChanged: (value){
                              alertTodo(i);
                            }),
                        ),
                    ),
                  );
                },
              );
            } else if (state.status == TodoStatus.initial){
              return const Center(child: CircularProgressIndicator());
            } else{
              return Container();
            }
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Center(
          child: Text(
            'ToDo App', 
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController title = TextEditingController();
              TextEditingController subtitle = TextEditingController();
              return AlertDialog(
                title: const Text('Adicione uma tarefa'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: title,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      decoration: InputDecoration(
                        hintText: 'Título da tarefa',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary
                          )
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey
                          )
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        controller: subtitle,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        decoration: InputDecoration(
                          hintText: 'Descrição da tarefa',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary
                            )
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey
                            )
                          )
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextButton(
                      onPressed: (){
                        addTodo(
                          Todo(title: title.text, subtitle: subtitle.text)
                        );
                        title.text = '';
                        subtitle.text = '';
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary
                          ),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        foregroundColor: Theme.of(context).colorScheme.secondary
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child:  Icon(Icons.check, color: Colors.green.shade300,)
                        ),
                      )
                    ),
                ],
              );
            }
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}