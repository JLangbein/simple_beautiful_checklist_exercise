import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';

// This is a SINGELTON with FACTORY Constructor
// Because it is best-practice when dealing with Databases
class SharedPreferencesRepository extends DatabaseRepository {
  static SharedPreferences? _preferences;

  // The class' own instance of itself
  static final SharedPreferencesRepository _instance =
      SharedPreferencesRepository._internal();

  SharedPreferencesRepository._internal();

  // unnamed factory constructor
  factory SharedPreferencesRepository() {
    return _instance;
  }
  @override
  Future<void> initialise() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> addItem(String item) async {
    List<String>? tempList = _preferences?.getStringList('taskList') ?? [];
    tempList.add(item);
    try {
      await _preferences!.setStringList('taskList', tempList);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Future<void> deleteItem(int index) async {
    List<String>? tempList = _preferences!.getStringList('taskList');
    tempList!.removeAt(index);
    try {
      await _preferences!.setStringList('taskList', tempList);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    List<String>? tempList = _preferences!.getStringList('taskList');
    tempList![index] = newItem;
    try {
      await _preferences!.setStringList('taskList', tempList);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Future<int> getItemCount() async {
    List<String>? tempList = _preferences?.getStringList('taskList') ?? [];
    return tempList.length;
  }

  @override
  Future<List<String>> getItems() async {
    return _preferences?.getStringList('taskList') ?? [];
  }
}
