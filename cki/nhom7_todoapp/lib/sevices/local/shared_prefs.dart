import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/todo_model.dart';

class SharedPrefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<TodoModel>?> getTodos() async {//lấy danh sách todos đã lưu trữ từ shared preferences
    SharedPreferences prefs = await _prefs;
    String? data = prefs.getString('todos');//lấy dữ liệu đã lưu trữ trong 'todos' 
    if (data == null) return null;
    List<Map<String, dynamic>> maps = jsonDecode(data)
        .cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
    List<TodoModel> todos = maps.map((e) => TodoModel.fromJson(e)).toList();
    //Chuyển đổi dữ liệu từ chuỗi JSON thành danh sách các đối tượng TodoModel.
    return todos;
  }

  Future<void> addTodos(List<TodoModel> todos) async {// thêm danh sách todos vào shared preferences
    List<Map<String, dynamic>> maps = todos.map((e) => e.toJson()).toList();
    SharedPreferences prefs = await _prefs;
    prefs.setString('todos', jsonEncode(maps));//lưu trữ danh sách các bản đồ JSON, Chuỗi JSON được lưu trữ với 'todos'.
  }

  Future<List<TodoModel>?> getDeletedItems() async {
  SharedPreferences prefs = await _prefs;
  String? data = prefs.getString('deletedItems');
  if (data == null) return null;
  List<Map<String, dynamic>> maps = jsonDecode(data)
      .cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
  List<TodoModel> deletedItems = maps.map((e) => TodoModel.fromJson(e)).toList();
  return deletedItems;
}

  Future<void> addDeletedItems(List<TodoModel> deletedItems) async {
    List<Map<String, dynamic>> maps =
        deletedItems.map((e) => e.toJson()).toList();
    SharedPreferences prefs = await _prefs;
    prefs.setString('deletedItems', jsonEncode(maps));
  }

}

