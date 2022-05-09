import 'package:flutter/material.dart';
import 'package:local_notifictaion/notification_widget.dart';
import 'package:local_notifictaion/secound_page.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationWidget.init(scheduled:true);
    listenNotification();
  }

  void listenNotification()=>NotificationWidget.onNotifications.stream.listen((event) {
     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TwoPage(),));
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: (){
                   NotificationWidget.shoeNotifcation(title: "xxx",body: "sjsjshbujsh jhsusbnsj ushus ujsbus suiihsu",payload: "sjsjsjsj hshsh");
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  color: Colors.green,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: Text("simple")),
                ),
              ),InkWell(
                onTap: (){
                  NotificationWidget.shoeScheduleNotifcation(title: "xxx",
                      body: "sjsjshbujsh jhsusbnsj ushus ujsbus suiihsu",
                      payload: "sjsjsjsj hshsh",
                      time: DateTime.now().add(Duration(seconds: 10)));
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  color: Colors.green,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: Text("schedule ")),
                ),
              ),InkWell(
                onTap: (){

                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  color: Colors.green,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: Text("remove")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}