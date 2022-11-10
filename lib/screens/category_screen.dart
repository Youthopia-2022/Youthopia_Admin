import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youthopia_admin/screens/see_more_screen.dart';
import 'package:youthopia_admin/services/events.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              SeeMoreScreen(Event.techEvents!)));
                },
                child: Text('Technical')),
            const SizedBox(
              height: 10,
            ),
            TextButton(onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          SeeMoreScreen(Event.culturalEvents!)));
            }, child: Text('Cultural')),
            const SizedBox(
              height: 10,
            ),
            TextButton(onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          SeeMoreScreen(Event.informalEvents!)));
            }, child: Text('Informal')),
            const SizedBox(
              height: 10,
            ),
            TextButton(onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          SeeMoreScreen(Event.debateEvents!)));
            }, child: Text('Literary')),
            const SizedBox(
              height: 10,
            ),
            TextButton(onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) =>
                          SeeMoreScreen(Event.artsEvents!)));
            }, child: Text('Fine Arts')),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
