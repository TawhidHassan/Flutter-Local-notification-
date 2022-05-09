import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class NotificationWidget{
  static final _notification=FlutterLocalNotificationsPlugin();
  static final onNotifications=BehaviorSubject<String?>();

  static Future init({bool scheduled=false})async{

   var initAndroidSettings=AndroidInitializationSettings('@mipmap/ic_launcher');
   var ios =IOSInitializationSettings();
   final settings=InitializationSettings(android: initAndroidSettings,iOS: ios);
   await _notification.initialize(settings,onSelectNotification: (payload)async{
     onNotifications.add(payload);
   }
   );

   if(scheduled){
     tz.initializeTimeZones();

     final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
     tz.setLocalLocation(tz.getLocation(timeZoneName));
   }

  }


  static Future shoeNotifcation({
    String? title,String? body,String? payload
  })async=>_notification.show(
      4, title, body, await notificationdetails(),payload:payload
  );


  ///period of time
  static Future shoeScheduleNotifcation({
    String? title,String? body,String? payload,required DateTime time
  })async=>_notification.zonedSchedule(
      4,
      title,
      body,
      tz.TZDateTime.from(time,tz.local),
      await notificationdetails(),
      payload:payload,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,

  );

  ///period of daily task
  static Future shoeDailyScheduleNotifcation({
    String? title,String? body,String? payload,required DateTime time
  })async=>_notification.zonedSchedule(
      4,
      title,
      body,
      _scheduleDaily(Time(8)),
      await notificationdetails(),
      payload:payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time
  );


  static notificationdetails()async{
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          "chanel_id",
          "chanel_name",
        importance: Importance.max
      ),
      iOS: IOSNotificationDetails()
    );
  }




  static tz.TZDateTime _scheduleDaily(Time time) {
    final now=tz.TZDateTime.now((tz.local));
    final scheduleDate=tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day
    );
    return scheduleDate.isBefore(now)?
    scheduleDate.add(Duration(days: 1)):scheduleDate;
  }
}

