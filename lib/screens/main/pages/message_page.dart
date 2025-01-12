import 'package:flutter/material.dart';
import 'package:muslim_mariage/screens/message/message.dart';
import 'package:muslim_mariage/utils/colors.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Messages",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => Message()));
          },
          title: Text(
            "John Borino",
            style: TextStyle(
                color: black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            "Have a good day 🌸",
            style: TextStyle(
              color: black,
              fontSize: 12,
            ),
          ),
          trailing: Text(
            "2 min ago",
            style: TextStyle(
              color: black,
              fontSize: 12,
            ),
          ),
          leading: CircleAvatar(
            backgroundImage:
                AssetImage("assets/Front view of beautiful man.png"),
          ),
        );
      }),
    );
  }
}
