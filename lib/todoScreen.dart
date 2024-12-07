import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {  final TextEditingController _textController = TextEditingController();
final Box _todoBox = Hive.box('myBox');
int? _editingIndex;

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('To-Do App')),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Enter To-Do',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (_textController.text.trim().isEmpty) return;

                  if (_editingIndex == null) {

                    _todoBox.add(_textController.text.trim());
                  } else {

                    _todoBox.putAt(_editingIndex!, _textController.text.trim());
                    _editingIndex = null;
                  }

                  _textController.clear();
                  setState(() {});
                },
                child: Text(_editingIndex == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: _todoBox.listenable(),
            builder: (context, Box box, _) {
              if (box.isEmpty) {
                return Center(child: Text('No To-Do Items'));
              }

              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(box.getAt(index)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {

                            _textController.text = box.getAt(index);
                            setState(() {
                              _editingIndex = index;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            box.deleteAt(index);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}
}









