import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/search_box.dart';
import '../components/td_appbar.dart';
import '../components/todo_item.dart';
import '../models/todo_model.dart';
import '../resource/app_color.dart';
import '../sevices/local/shared_prefs.dart';
import 'done_page.dart';
import 'trash_page.dart';


class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  final _addController = TextEditingController();
  final _addFocus = FocusNode();
  bool _showAddBox = false;

  final SharedPrefs _prefs = SharedPrefs();
  List<TodoModel> _todos = [];
  List<TodoModel> _searches = [];
  List<TodoModel> _deleteItems = [];
  int _selectedIndex = 0;

  void navi(int index){
 if(index==0) {
      Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) => const HomePage(title: 'Todos', )));
    }
    if(index==1) {
      Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) => const DonePage(title: 'Todos Complete',  
    
           )));
    }
    if(index==2) {
      Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) => const DeletedItemsPage(title: 'Todos Trash',  )));
    }
   
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
     navi(index);
    });
  }

  
  @override
  //khởi tạo trạng thái 
  void initState() {
    super.initState();
    _getTodos();
  }
  //lấy danh sách công việc từ _prefs
  _getTodos() {
    _prefs.getTodos().then((value) {
      _todos = value ?? todosInit;
      _searches = [..._todos];
      setState(() {});
    });
  }
  //tìm kiếm công việc trong _todos
  _searchTodos(String searchText) {
    searchText = searchText.toLowerCase();//searchText được chuyển thành chữ thường
    _searches = _todos
        .where((element) =>
            (element.text ?? '').toLowerCase().contains(searchText))
        .toList();
  }
  
   void _deleteItem(TodoModel todo) async {
    bool? status = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('😍'),
        content:  const Row(
          children: [
            Expanded(
              child: Text(
                'Do you want to remove the todo?',
                style: TextStyle(fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (status ?? false) {//Nếu status không null và có giá trị true
      setState(() {
        _deleteItems.add(todo);
        _todos.remove(todo);
        _searches.remove(todo);
        _prefs.addTodos(_todos);
        // thêm todo vô deletedItems
        _prefs.getDeletedItems().then((value) {
          value =  value ?? [];
          value.add(todo);
          _prefs.addDeletedItems(value);
        });
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: TdAppBar(
          rightPressed: () async {
            bool? status = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('😍'),
                content:  const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Do you want to logout?',
                        style: TextStyle(fontSize: 22.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
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
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
          },
          title: widget.title),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0)
                    .copyWith(top: 12.0, bottom: 92.0),
                child: Column(
                  children: [
                    SearchBox(
                        onChanged: (value) =>
                            setState(() => _searchTodos(value)),
                        controller: _searchController),
                    const Divider(
                        height: 32.6, thickness: 1.36, color: AppColor.grey),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: _searches.length,
                      itemBuilder: (context, index) {
                        TodoModel todo = _searches.reversed.toList()[index];
                        return TodoItem(
                          onTap: () async{
                            setState(() {
                              todo.isDone = !(todo.isDone ?? false);//nếu không có giá trị, thì mặc định là false
                              _prefs.addTodos(_todos);
                              
                            });  
                          },
                         
                          onDeleted: ()  {
                            _deleteItem(todo);
                          },
                          text: todo.text ?? '-:-',
                          isDone: todo.isDone ?? false,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16.8),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20.0,
            right: 20.0,
            bottom: 14.6,
            child: Row(
              children: [
                Expanded(
                  child: Visibility(
                    visible: _showAddBox,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5.6),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(color: Color.fromARGB(255, 29, 12, 212)),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColor.shadow,
                            offset: Offset(0.0, 3.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _addController,
                        focusNode: _addFocus,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add a new todo item',
                          hintStyle: TextStyle(color: AppColor.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18.0),
                GestureDetector(
                  onTap: () {
                    _showAddBox = !_showAddBox;

                    if (_showAddBox) {
                      setState(() {});
                      _addFocus.requestFocus();// Yêu cầu trỏ tới hộp văn bản để nhập
                      return;
                    }

                    String text = _addController.text.trim();//Lấy giá trị của TEXT đã nhập và loại bỏ khoảng trắng
                    if (text.isEmpty) {
                      setState(() {});
                      FocusScope.of(context).unfocus();//Huỷ bỏ trạng thái trỏ tới của hộp văn bản
                      return;
                    }

                    int id = 1;
                    if (_todos.isNotEmpty) {
                      id = (_todos.last.id ?? 0) + 1;
                      //Lấy id của việc cuối trong _todos và tăng nó lên 1. Nếu không có giá trị id, thì mặc định là 0.
                    }
                    TodoModel todo = TodoModel()
                      ..id = id
                      ..text = text;
                    _todos.add(todo);
                    _prefs.addTodos(_todos);
                    _addController.clear();
                    _searchController.clear();
                    _searchTodos('');
                    setState(() {});
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14.6),
                    decoration: BoxDecoration(
                      color: AppColor.blue,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColor.shadow,
                          offset: Offset(0.0, 3.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add,
                        size: 32.0, color: AppColor.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 255, 78, 81)),
            label: 'Home',
            // backgroundColor: Color.fromARGB(255, 16, 19, 21),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_sharp, color: Colors.blue,),
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
