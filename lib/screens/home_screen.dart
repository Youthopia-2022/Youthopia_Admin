import 'package:youthopia_admin/services/events.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../services/supabase.dart';

class Home extends StatefulWidget {
  const Home(this.event, {super.key});
  final Event event;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isLoaded = false;
  List eventParticipants = [];
  Supa supa = Supa();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    eventParticipants = await supa.getParticipantList(widget.event.eventId);
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.eventName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Center(
              child: Text(eventParticipants.length.toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
      body: (!isLoaded)? const Center(
        child: CircularProgressIndicator(),
      ) : (eventParticipants.isEmpty) ? const Center(
        child: Text('No Registrations'),
      ) :
          ListView.builder(
            itemCount: eventParticipants.length,
              itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: Colors.blue,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Name : ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        Flexible(
                          child: Text(eventParticipants[index].participantName,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text('Identity : ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        Flexible(child: Text(eventParticipants[index].participantIdentity,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text('Email : ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        Flexible(child: Text(eventParticipants[index].participantEmail,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text('Phone : ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        Flexible(child: Text(eventParticipants[index].participantPhone,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    (widget.event.isTeamEvent)? Column(
                      children: [
                        Row(
                          children: [
                            const Text('Team Name : ',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Flexible(
                              child: Text(eventParticipants[index].teamName,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text('Team Members : ',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Flexible(child: Text(eventParticipants[index].teamMembers,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ) :
                    const SizedBox(
                      height: 10,
                    ),
                    (eventParticipants[index].isDIt) ? const SizedBox(height: 0,) :
                        SizedBox(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: PhotoView(imageProvider: NetworkImage(
                              '${eventParticipants[index].imageUrl}.png'
                          ),
                          ),
                        )
                  ],
                ),
              );
              })
    );
  }
}
