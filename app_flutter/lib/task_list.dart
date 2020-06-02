import 'package:flutter/material.dart';
import 'package:hacknu/task_card.dart';
import 'package:hacknu/task_data.dart';
import 'package:provider/provider.dart';

class EventList extends StatefulWidget {

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context,taskdata,child){
        return ListView.builder(
          controller: _scrollController,
          physics:ScrollPhysics(),
          itemCount: Provider.of<TaskData>(context).event_card.length,
          itemBuilder: (context,index){
            return EventCard(
              onlongpresscallback: (){
                taskdata.deleteTask(taskdata.event_card[index]);
              },
              items: Provider.of<TaskData>(context,listen: false).event_card[index].items,
              name: Provider.of<TaskData>(context,listen: false).event_card[index].name,
              address: Provider.of<TaskData>(context,listen: false).event_card[index].Address,
              city: Provider.of<TaskData>(context,listen: false).event_card[index].City,
              phoneno: Provider.of<TaskData>(context,listen: false).event_card[index].Phoneno,
            );
          },
        );
      },
    );
  }
}
