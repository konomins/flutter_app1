import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math' as math;
import 'dart:io';
//import 'game1.dart';

void main() {
  runApp(MyApp());
}

//静的(時間を設定する画面)
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
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => new MyHomePage(),
        '/subpage': (BuildContext context) => new SubPage()
      },
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
   var judge = 0;

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

    if (switch_text1 == "設定しました" && set_time1 == now_time) {
      judge++;
      play();
    }
    else if (switch_text2 == "設定しました" && set_time2 == now_time) {
      judge++;
      play();
    }
    else if (switch_text3 == "設定しました" && set_time3 == now_time) {
      judge++;
      play();
    }
    else if (switch_text4 == "設定しました" && set_time4 == now_time) {
      judge++;
      play();
    }
    else if (switch_text5 == "設定しました" && set_time5 == now_time) {
      judge++;
      play();
    }
  }


  //音楽の再生と停止の関数
  void play()  async {
    if(judge == 1){
      // _player2?.stop();
      _player2 = await _player.loop('sounds/a.mp3');
    }
  }

  void stop() {
    _player2.stop();
    judge = 0;
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
            Text(
              "設定していない状態にし、止めてください"
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
              //onPressed: () => _player2.stop(),
              onPressed: () => stop(),
            ),
            RaisedButton(
              child: Text("遷移"),
              color: Colors.green,
              textColor:Colors.white,
              onPressed:() => Navigator.of(context).pushNamed("/subpage"),
            ),
    ]
    ),
    ),
    );
  }
}


//静的 (計算ゲーム画面)
class SubPage extends StatelessWidget{
  @override
  Widget build(BuildContext content) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(

        title: const Text('今日の問題',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: _GamePage(),
      ),
    );
  }
}

class _GamePage extends StatefulWidget {
  @override

  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<_GamePage> {
  @override

  //回答の入力
  String _q1 = '0';
  String _q2 = '0';
  String _q3 = '0';

  //回答の判定
  String answer_judge1 = 'x';
  String answer_judge2 = 'x';
  String answer_judge3 = 'x';

  //回答
  String answer1 = '1311';
  String answer2 = '10893';
  String answer3 = '172840';

  //正解個数
  var correct_count = 0;

  //乱数の使用
  var rand = new math.Random();

  //乱数
  //var q1_0 = rand.nextInt(10);

  //1問目を回答する関数
  void _q1Text(String e) {
    String judge = 'x';

    //文字の入力を画面に反映
    setState(() { _q1 = e;});
    //入力した回答が正解かの判定
    if (_q1 == answer1){
      judge = '〇';
      correct_count++;
    }
    setState(() { answer_judge1 = judge;});

    if(answer_judge1 == '〇' && answer_judge2 == '〇' && answer_judge3 == '〇'){
      Navigator.of(context).pop();
    }

  }

  //2問目を回答する関数
  void _q2Text(String e) {
    String judge = 'x';

    setState(() { _q2 = e;});

    if(_q2 == answer2){
      judge = '〇';
    }

    setState(() { answer_judge2 = judge;});

    if(answer_judge1 == '〇' && answer_judge2 == '〇' && answer_judge3 == '〇'){
      Navigator.of(context).pop();
    }
  }

  //3問目を回答する関数
  void _q3Text(String e) {
    String judge = 'x';

    setState(() { _q3 = e;});

    if(_q3 == answer3){
      judge = '〇';
    }

    setState(() { answer_judge3 = judge;});

    if(answer_judge1 == '〇' && answer_judge2 == '〇' && answer_judge3 == '〇'){
      Navigator.of(context).pop();
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'それぞれの式の下にある解答欄に答えを入力してください',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                )
              ),
             Container(
               color : Colors.black,
               width: 380.0,
               height: 40.0,
               child:Text(//2桁×2桁
                  '23 × 57 =' + _q1 + '    判定:' + answer_judge1,
                 style: TextStyle(
                   fontSize: 24.0,
                   color: Colors.white,
                 ),
               ),
             ),
              new TextField(
                enabled: true,
                maxLength: 4,
                maxLengthEnforced: true,
                style: TextStyle(
                  color:Colors.white,
                  fontSize: 24.0,
                ),
                obscureText: false,
                maxLines:1,
                onChanged: _q1Text,
              ),
              Container(//4桁 + 4桁
                color : Colors.black,
                width: 380.0,
                height: 40.0,
                child: Text(
                  '3586 + 7307 =' + _q2 + '    判定:' + answer_judge2,
                style: TextStyle(
                  fontSize: 24.0,
                  color:Colors.white,
                ),
                ),
              ),
              new TextField(
                enabled: true,
                maxLength: 5,
                maxLengthEnforced: true,
                style: TextStyle(
                  color:Colors.white,
                  fontSize: 24.0,
                ),
                obscureText: false,
                maxLines:1,
                onChanged: _q2Text,
              ),
              Container(
                color: Colors.black,
                width: 380.0,
                height: 40.0,
                child: Text(//3桁×3桁
                  '596 × 290 = '+ _q3 + '    判定:' + answer_judge3,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
              ),
              new TextField(
                enabled: true,
                maxLength: 6,
                maxLengthEnforced: true,
                style: TextStyle(
                  color:Colors.white,
                  fontSize: 24.0,
                ),
                obscureText: false,
                maxLines:1,
                onChanged: _q3Text,
              ),
          ]
          ),
        ),
    );
  }
}
