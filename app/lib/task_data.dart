import 'package:flutter/foundation.dart';
import 'constants.dart';

class TaskData extends ChangeNotifier{
  List<Event> event_card = [
    Event(
        name: 'Ajay',
        Address: 'Gandhi Park',
        Phoneno: '63473676437',
        items: 'water',
        City: 'Jaipur'),
  ];
  List<Event> food = [];
  List<Event> clothes = [];
  List<Event> water = [];
  List<Event> medicine = [];

  void addEvent(String name,String Address,String Phoneno,String items,String City){
    final event=Event(name: name,Address: Address,Phoneno: Phoneno,items: items,City: City);
    event_card.add(event);
    notifyListeners();
  }
  void addFoodEvent({String name,String Address,String Phoneno,String items,String City}){
    final event=Event(name: name,Address: Address,Phoneno: Phoneno,items: items,City: City);
    food.add(event);
    notifyListeners();
  }
  void addWaterEvent({String name,String Address,String Phoneno,String items,String City}){
    final event=Event(name: name,Address: Address,Phoneno: Phoneno,items: items,City: City);
    water.add(event);
    notifyListeners();
  }
  void addClothesEvent({String name,String Address,String Phoneno,String items,String City}){
    final event=Event(name: name,Address: Address,Phoneno: Phoneno,items: items,City: City);
    clothes.add(event);
    notifyListeners();
  }
  void addMedicineEvent({String name,String Address,String Phoneno,String items,String City}){
    final event=Event(name: name,Address: Address,Phoneno: Phoneno,items: items,City: City);
    medicine.add(event);
    notifyListeners();
  }

  void deleteTask(Event event){
    event_card.remove(event);
    notifyListeners();
  }
  void deleteFoodTask(Event event){
    food.remove(event);
    notifyListeners();
  }
  void deleteClothesTask(Event event){
    clothes.remove(event);
    notifyListeners();
  }
  void deletewaterTask(Event event){
    water.remove(event);
    notifyListeners();
  }
  void deletemedicineTask(Event event){
    medicine.remove(event);
    notifyListeners();
  }
}

