import 'package:flutter/material.dart';
import '../components/td_appbar.dart';
import '../components/todo_item.dart';
import '../models/todo_model.dart';
import '../resource/app_color.dart';
import '../sevices/local/shared_prefs.dart';
import 'done_page.dart';
import 'home_page.dart';


class DeletedItemsPage extends StatefulWidget {
  final String title;
  const DeletedItemsPage({Key? key, required this.title,}) : super(key: key);

  @override
  State<DeletedItemsPage> createState() => _DeletedItemsPageState();
}

class _DeletedItemsPageState extends State<DeletedItemsPage> {
  final SharedPrefs _prefs = SharedPrefs();
  List<TodoModel> _deletedItems = [];

  int _selectedIndex = 0;

  void navi(int index){
 if(index==0) {
      Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) => const HomePage(title: 'Todos', )));
    }
    if(index==1) {
      Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) =>const DonePage(title: 'Todos Done', 

    
         )));
    }
    if(index==2) {
      Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) => const DeletedItemsPage(title: 'Todos Trash', )));
    }
  }
   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
     navi(index);
    });
  }
  // List<TodoModel> 

  @override
  void initState() {
    super.initState();
    _getDeletedItems();
  }

  void _getDeletedItems() async {
    List<TodoModel>? deletedItems = await _prefs.getDeletedItems();
    //Gọi phương thức getDeletedItems để lấy ds cv đã bị xóa từ _prefs 
    if (deletedItems != null) {
      setState(() {
        _deletedItems = deletedItems;
      });
    }
  }

//
void _restoreItem(int index) async {
  bool? status = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('😍'),
      content: const Text('Do you want to restore the todo?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('OK'),
        ),
      ],
    ),
  );
  if (status ?? false) {
    setState(() {
      TodoModel restoredItem = _deletedItems.removeAt(index);
      _prefs.addDeletedItems(_deletedItems);
     
    });
   
  }
  
}

  @override
  Widget build(BuildContext context) {
    _getDeletedItems();
    return Scaffold(
     backgroundColor: AppColor.bgColor,
      appBar: TdAppBar(
        title: widget.title,
      ),
      body: ListView.separated(
        itemCount: _deletedItems.length,
        itemBuilder: (context, index) {
          TodoModel todo = _deletedItems[index];

          return TodoItem(
            text: todo.text ?? '',
            isDone: todo.isDone ?? false,
                 onDeleted: () async {
              bool? status = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('😍'),
                  content: const Text('Do you want to remove the todo?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
              if (status ?? false) {
                setState(() {
                  _deletedItems.removeAt(index);
                  _prefs.addDeletedItems(_deletedItems);

                  // _todos.remove(todo);
                  // _prefs.addTodos(_todos);
                });
              }
            },
            //
            onRestored: (){
              _restoreItem(index);
            },
          );
        }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16.8),
      ),
       bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
            // backgroundColor: Color.fromARGB(255, 16, 19, 21),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_sharp, color: Colors.blue,),
            label: 'Complete',
            // backgroundColor: Color.fromARGB(255, 17, 22, 17),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_sweep, color: Color.fromARGB(255, 255, 78, 81)),
            label: 'Trash',
            // backgroundColor: Color.fromARGB(255, 23, 19, 20),
          ),
         
        ],
        currentIndex: _selectedIndex,

          onTap: _onItemTapped
      ),
    );
  }
}
