import 'package:flutter/material.dart';
import 'package:nhom7_todoapp/pages/home_page.dart';
import 'package:nhom7_todoapp/pages/trash_page.dart';
import '../components/td_appbar.dart';
import '../components/todo_item.dart';
import '../models/todo_model.dart';
import '../resource/app_color.dart';
import '../sevices/local/shared_prefs.dart';


class DonePage extends StatefulWidget {
  final String title;

 

  const DonePage({Key? key, required this.title, 

  
   }) : super(key: key);

  @override
  _DonePageState createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  final SharedPrefs _prefs = SharedPrefs();
  List<TodoModel> _todos = [];
  


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

  @override
  void initState() {
    super.initState();
    _getDone();
  
 
  }

  _getDone() {
    _prefs.getTodos().then((value) {//lấy danh sách các công việc từ _prefs
      _todos = value?.where((todo) => todo.isDone == true).toList() ?? [];
      //value được kiểm tra có null không. 
      //Nếu không, phương thức where được dùng để lọc ds cv và chỉ lấy những cv có thuộc tính isDone là true.
      setState(() {});
    });
  }

 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: TdAppBar(
        title: widget.title,
        
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          TodoModel todo = _todos.reversed.toList()[index];
          return TodoItem(
            text: todo.text ?? '-:-',
            isDone: todo.isDone ?? false,
            
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16.8),
      ),
       bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
            // backgroundColor: Color.fromARGB(255, 16, 19, 21),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_sharp, color: Color.fromARGB(255, 255, 78, 81)),
            label: 'Complete',
            // backgroundColor: Color.fromARGB(255, 17, 22, 17),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_sweep, color: Colors.blue),
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