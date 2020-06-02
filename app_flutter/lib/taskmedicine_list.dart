import 'package:flutter/material.dart';
import 'package:hacknu/task_data.dart';
import 'package:hacknu/taskmedicine_card.dart';
import 'package:provider/provider.dart';

class MedicineList extends StatefulWidget {

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context,taskdata,child){
        return ListView.builder(
          controller: _scrollController,
          physics:ScrollPhysics(),
          itemCount: Provider.of<TaskData>(context).medicine.length,
          itemBuilder: (context,index){
            return MedicineCard(
              onlongpresscallback: (){
                taskdata.deletemedicineTask(taskdata.medicine[index]);
              },
              items: Provider.of<TaskData>(context,listen: false).medicine[index].items,
              name: Provider.of<TaskData>(context,listen: false).medicine[index].name,
              address: Provider.of<TaskData>(context,listen: false).medicine[index].Address,
              city: Provider.of<TaskData>(context,listen: false).medicine[index].City,
              phoneno: Provider.of<TaskData>(context,listen: false).medicine[index].Phoneno,
            );
          },
        );
      },
    );
  }
}
