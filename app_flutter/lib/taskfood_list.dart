import 'package:flutter/material.dart';
import 'package:hacknu/taskfood_card.dart';
import 'package:hacknu/task_data.dart';
import 'package:provider/provider.dart';

class FoodList extends StatefulWidget {

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context,taskdata,child){
        return ListView.builder(
          controller: _scrollController,
          physics:ScrollPhysics(),
          itemCount: Provider.of<TaskData>(context).food.length,
          itemBuilder: (context,index){
            return FoodCard(
              onlongpresscallback: (){
                taskdata.deleteFoodTask(taskdata.food[index]);
              },
              items: Provider.of<TaskData>(context,listen: false).food[index].items,
              name: Provider.of<TaskData>(context,listen: false).food[index].name,
              address: Provider.of<TaskData>(context,listen: false).food[index].Address,
              city: Provider.of<TaskData>(context,listen: false).food[index].City,
              phoneno: Provider.of<TaskData>(context,listen: false).food[index].Phoneno,
            );
          },
        );
      },
    );
  }
}
