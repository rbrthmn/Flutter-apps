import 'package:mobx/mobx.dart';
import 'package:todomobx/stores/todo_store.dart';

part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {

  @observable
  String newTodoTitle = "";

  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();

  @computed
  bool get isFormValid => newTodoTitle.isNotEmpty;

  @action
  void setNewTodoTitle(String value) => this.newTodoTitle = value;

  @action
  void addTodo() {
    todoList.insert(0, TodoStore(newTodoTitle));
    newTodoTitle = "";
  }
}