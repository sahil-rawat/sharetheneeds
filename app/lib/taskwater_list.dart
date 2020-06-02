import 'package:flutter/material.dart';
import 'package:hacknu/taskwater_card.dart';
import 'package:hacknu/task_data.dart';
import 'package:provider/provider.dart';

class WaterList extends StatefulWidget {

  @override
  _WaterListState createState() => _WaterListState();
}

class _WaterListState extends State<WaterList> {
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context,taskdata,child){
        return ListView.builder(
          controller: _scrollController,
          physics:ScrollPhysics(),
          itemCount: Provider.of<TaskData>(context).water.length,
          itemBuilder: (context,index){
            return WaterCard(
              onlongpresscallback: (){
                taskdata.deletewaterTask(taskdata.water[index]);
              },
              items: Provider.of<TaskData>(context,listen: false).water[index].items,
              name: Provider.of<TaskData>(context,listen: false).water[index].name,
              address: Provider.of<TaskData>(context,listen: false).water[index].Address,
              city: Provider.of<TaskData>(context,listen: false).water[index].City,
              phoneno: Provider.of<TaskData>(context,listen: false).water[index].Phoneno,
            );
          },
        );
      },
    );
  }
}
