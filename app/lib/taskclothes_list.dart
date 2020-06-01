import 'package:flutter/material.dart';
import 'package:hacknu/taskclothes_card.dart';
import 'package:hacknu/task_data.dart';
import 'package:provider/provider.dart';

class ClothesList extends StatefulWidget {

  @override
  _ClothesListState createState() => _ClothesListState();
}

class _ClothesListState extends State<ClothesList> {
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context,taskdata,child){
        return ListView.builder(
          controller: _scrollController,
          physics:ScrollPhysics(),
          itemCount: Provider.of<TaskData>(context).clothes.length,
          itemBuilder: (context,index){
            return ClothesCard(
              onlongpresscallback: (){
                taskdata.deleteClothesTask(taskdata.food[index]);
              },
              items: Provider.of<TaskData>(context,listen: false).clothes[index].items,
              name: Provider.of<TaskData>(context,listen: false).clothes[index].name,
              address: Provider.of<TaskData>(context,listen: false).clothes[index].Address,
              city: Provider.of<TaskData>(context,listen: false).clothes[index].City,
              phoneno: Provider.of<TaskData>(context,listen: false).clothes[index].Phoneno,
            );
          },
        );
      },
    );
  }
}
