import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
//import 'game1.dart';

void main() {
  runApp(MyApp());
}

//静的
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '目覚まし'),
    /*  initialRoute: '/',
      routes: {
        '/': (content) => MainPage(),
        '/game1': (content) => Game1(),
      },
     */
    );
  }
}

//動的
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //ローカルassetから音源を流すために必要
   AudioCache _player = AudioCache();
   AudioPlayer _player2 = AudioPlayer();


  //時間を設定
  String set_time1 = '00:00';
  String set_time2 = '00:00';
  String set_time3 = '00:00';
  String set_time4 = '00:00';
  String set_time5 = '00:00';

  //現在時刻の変数
  String now_time = '';

  //セットした時間と今の時間が同じかどうか判定(仮)
  var judge1 = 0;
  var judge2 = 0;
  var judge3 = 0;
  var judge4 = 0;
  var judge5 = 0;

  //音楽を鳴らす判定
  var music = 0;

  //各スイッチの値を表示
  //1個目
  bool _active1 = false;
  String switch_text1= "設定していません.";

  //2個目
  bool _active2 = false;
  String switch_text2= "設定していません.";

  //3個目
  bool _active3 = false;
  String switch_text3= "設定していません.";

  //4個目
  bool _active4 = false;
  String switch_text4= "設定していません.";

  //5個目
  bool _active5 = false;
  String switch_text5= "設定していません.";

  //音声ファイル
  //var url1 = 'https://smartomaizu.com/ringtones/%e7%9b%ae%e8%a6%9a%e3%81%be%e3%81%97%e9%9f%b3/0/su1014.mp3';


  void initState() { //現在時刻を取得する関数
    Timer.periodic(
      Duration(seconds: 1),
      _onTimer,
    );
    super.initState();
    //_player.loop('sounds/a.mp3').then((player) => _player2 = player);
  }


  void _onTimer(Timer timer) {
    //現在時刻を時、分にフォーマットし、アラームを鳴らす関数
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm');
    now_time = formatter.format(now);

    var count1 = 0;
    var count2 = 0;
    var count3 = 0;
    var count4 = 0;
    var count5 = 0;

    if (switch_text1 == "設定しました" && set_time1 == now_time) {
      count1 = 1;
      play();
    }
    if (switch_text2 == "設定しました" && set_time2 == now_time) {
      count2 = 1;
      play();
    }
    if (switch_text3 == "設定しました" && set_time3 == now_time) {
      count3 = 1;
      play();
    }
    if (switch_text4 == "設定しました" && set_time4 == now_time) {
      count4 = 1;
      play();
    }
    if (switch_text5 == "設定しました" && set_time5 == now_time) {
      count5 = 1;
      play();
    }

    setState(() => judge1 = count1);
    setState(() => judge2 = count2);
    setState(() => judge3 = count3);
    setState(() => judge4 = count4);
    setState(() => judge5 = count5);
  }


  //音楽の再生と停止の関数
  void play()  async {
    _player2?.stop();
    _player2 = await _player.loop('sounds/a.mp3');

  }

  //1個目の時間を設定する関数
  Future<void> _selectTime1(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      var dt = _toDateTime(picked);
      setState(() {
        set_time1 = (DateFormat.Hm()).format(dt);
      });
    }
  }

  //2個目の時間を設定する関数
  Future<void> _selectTime2(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      var dt = _toDateTime(picked);
      setState(() {
        set_time2 = (DateFormat.Hm()).format(dt);
      });
    }
  }

  //3個目の時間を設定する関数
  Future<void> _selectTime3(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      var dt = _toDateTime(picked);
      setState(() {
        set_time3 = (DateFormat.Hm()).format(dt);
      });
    }
  }

  //4個目の時間を設定する関数
  Future<void> _selectTime4(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      var dt = _toDateTime(picked);
      setState(() {
        set_time4 = (DateFormat.Hm()).format(dt);
      });
    }
  }

  //5個目の時間を設定する関数
  Future<void> _selectTime5(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      var dt = _toDateTime(picked);
      setState(() {
        set_time5 = (DateFormat.Hm()).format(dt);
      });
    }
  }


  //TimeOfDay型をString型に変換する関数
  _toDateTime(TimeOfDay t) {
    var now = DateTime.now();//年、月、日のみ使用
    return DateTime(
      now.year,now.month,now.day,
        t.hour, t.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "時間を設定してください.",
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),

            Container(//1個目の時間設定
              height: 58,
              width: 400,
              color: Colors.grey,
              margin:EdgeInsets.all(10.0),
              child: Row(
                  children: <Widget>[
                    new RaisedButton(
                          onPressed: () => _selectTime1(context),
                      child: new Text(set_time1,
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ),

                    new Switch(
                      value: _active1,
                      activeColor: Colors.black,
                      activeTrackColor: Colors.black,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.white,
                      onChanged: (bool value) {
                        setState(() {
                          _active1 = value;
                          if(_active1 == true) {
                            switch_text1 = '設定しました';
                          }
                          else {
                            switch_text1 = '設定されていません';
                          }
                        });
                      },
                    ),
                    Text(switch_text1),


                  ],
        ),
      ),


        Container(//2個目の時間設定
            height: 58,
            width: 400,
            color: Colors.grey,
            margin:EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                new RaisedButton(
                  onPressed: () => _selectTime2(context),
                  child: new Text(set_time2,
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),

                new Switch(
                  value: _active2,
                  activeColor: Colors.black,
                  activeTrackColor: Colors.black,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      _active2 = value;
                      if(_active2 == true) {
                        switch_text2 = '設定しました';
                      }
                      else {
                        switch_text2 = '設定されていません';
                      }
                    });
                  },
                ),
                Text(switch_text2),


              ],
            ),
        ),

            Container(//3個目の時間設定
              height: 58,
              width: 400,
              color: Colors.grey,
              margin:EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  new RaisedButton(
                    onPressed: () => _selectTime3(context),
                    child: new Text(set_time3,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),

                  new Switch(
                    value: _active3,
                    activeColor: Colors.black,
                    activeTrackColor: Colors.black,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.white,
                    onChanged: (bool value) {
                      setState(() {
                        _active3 = value;
                        if(_active3 == true) {
                          switch_text3 = '設定しました';
                        }
                        else {
                          switch_text3 = '設定されていません';
                        }
                      });
                    },
                  ),
                  Text(switch_text3),


                ],
              ),
            ),

            Container(//4個目の時間設定
              height: 58,
              width: 400,
              color: Colors.grey,
              margin:EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  new RaisedButton(
                    onPressed: () => _selectTime4(context),
                    child: new Text(set_time4,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),

                  new Switch(
                    value: _active4,
                    activeColor: Colors.black,
                    activeTrackColor: Colors.black,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.white,
                    onChanged: (bool value) {
                      setState(() {
                        _active4 = value;
                        if(_active4 == true) {
                          switch_text4 = '設定しました';
                        }
                        else {
                          switch_text4 = '設定されていません';
                        }
                      });
                    },
                  ),
                  Text(switch_text4),


                ],
              ),
            ),

            Container(//5個目の時間設定
              height: 58,
              width: 400,
              color: Colors.grey,
              margin:EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  new RaisedButton(
                    onPressed: () => _selectTime5(context),
                    child: new Text(set_time5,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),

                  new Switch(
                    value: _active5,
                    activeColor: Colors.black,
                    activeTrackColor: Colors.black,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.white,
                    onChanged: (bool value) {
                      setState(() {
                        _active5 = value;
                        if(_active5 == true) {
                          switch_text5 = '設定しました';
                        }
                        else {
                          switch_text5 = '設定されていません';
                        }
                      });
                    },
                  ),
                  Text(switch_text5),


                ],
              ),
            ),
   //   Text("$judge1"),
   //   Text("$judge2"),
   //   Text("$judge3"),
   //   Text("$judge4"),
   //   Text("$judge5"),
            RaisedButton(
              child: Text("stop"),
              color: Colors.green,
              textColor:Colors.white,
              onPressed: () => _player2.stop(),
            ),
    ]
    ),
    ),
    );
  }
}
