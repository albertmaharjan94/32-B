import 'package:flutter/material.dart';
import 'package:my_first_app/services/NotificationService.dart';

class NotificationDemo extends StatefulWidget {
  const NotificationDemo({Key? key}) : super(key: key);

  @override
  State<NotificationDemo> createState() => _NotificationDemoState();
}

class _NotificationDemoState extends State<NotificationDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification Demo"),),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            NotificationService.displayText(
                title: "This is title",
                body: "This is body"
            );
          }, child: Text("Notification with text")),
          ElevatedButton(onPressed: (){
            NotificationService.displayImage(
                title: "Notification with image",
                body: "Image load",
                icon: "assets/images/logo.png",
                image: "assets/images/logo.png");
          }, child: Text("Notification with image")),
        ],
      ),
    );
  }
}
