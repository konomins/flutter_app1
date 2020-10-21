import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'package:sensors/sensors.dart';
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
        '/first_page': (BuildContext context) => new SubPage(),
        '/second_page': (BuildContext content) => new SubPage1(),
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

   //遷移判定
   var count = 0;

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
  String switch_text1= "設定していないよ.";

  //2個目
  bool _active2 = false;
  String switch_text2= "設定していないよ.";

  //3個目
  bool _active3 = false;
  String switch_text3= "設定していないよ.";

  //4個目
  bool _active4 = false;
  String switch_text4= "設定していないよ.";

  //5個目
  bool _active5 = false;
  String switch_text5= "設定していないよ.";


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

    //遷移画面判定
    int scene = Random().nextInt(2);
    //0の場合: 計算ゲーム
    //1の場合:加速度ゲーム



    if (switch_text1 == "設定しているよ" && set_time1 == now_time) {
      judge++;
      play();
      if(scene == 0){
        Navigator.of(context).pushNamed("/first_page");
      }
      else if(scene == 1){
        Navigator.of(context).pushNamed("/second_page");
      }

      switch_text1 = "設定していないよ";
      setState(() {
      });
    }
    else if (switch_text2 == "設定しているよ" && set_time2 == now_time) {
      judge++;
      play();
      if(scene == 0){
        Navigator.of(context).pushNamed("/first_page");
      }
      else if(scene == 1){
        Navigator.of(context).pushNamed("/second_page");
      }
      switch_text2 = "設定していないよ";
      setState(() {
      });
    }
    else if (switch_text3 == "設定しているよ" && set_time3 == now_time) {
      judge++;
      play();
      if(scene == 0){
        Navigator.of(context).pushNamed("/first_page");
      }
      else if(scene == 1){
        Navigator.of(context).pushNamed("/second_page");
      }
      switch_text3 = "設定していないよ";
      setState(() {
      });
    }
    else if (switch_text4 == "設定しているよ" && set_time4 == now_time) {
      judge++;
      play();
      if(scene == 0){
        Navigator.of(context).pushNamed("/first_page");
      }
      else if(scene == 1){
        Navigator.of(context).pushNamed("/second_page");
      }
      switch_text4 = "設定していないよ";
      setState(() {
      });
    }
    else if (switch_text5 == "設定しているよ" && set_time5 == now_time) {
      judge++;
      play();
      if(scene == 0){
        Navigator.of(context).pushNamed("/first_page");
      }
      else if(scene == 1){
        Navigator.of(context).pushNamed("/second_page");
      }
      switch_text5 = "設定していないよ";
      setState(() {
      });
    }

  }


  //音楽の再生と停止の関数
  void play()  async {
    if(judge == 1){
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
              "時間を設定しよう.",
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
                  Padding(
                    padding: EdgeInsets.only(right:10.0),
                  ),
                  new RaisedButton(
                      onPressed: () => _selectTime1(context),
                      child: new Text(set_time1,
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(right:5.0),
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
                            switch_text1 = '設定しているよ';
                          }
                          else {
                            switch_text1 = '設定していないよ';
                          }
                        });
                      },
                    ),
                  Padding(
                    padding: EdgeInsets.only(right:5.0),
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
                Padding(
                  padding: EdgeInsets.only(right:10.0),
                ),
                new RaisedButton(
                  onPressed: () => _selectTime2(context),
                  child: new Text(set_time2,
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(right:5.0),
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
                        switch_text2 = '設定しているよ';
                      }
                      else {
                        switch_text2 = '設定していないよ';
                      }
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(right:5.0),
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
                  Padding(
                    padding: EdgeInsets.only(right:10.0),
                  ),
                  new RaisedButton(
                    onPressed: () => _selectTime3(context),
                    child: new Text(set_time3,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(right:5.0),
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
                          switch_text3 = '設定しているよ';
                        }
                        else {
                          switch_text3 = '設定していないよ';
                        }
                      });
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.only(right:5.0),
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
                  Padding(
                    padding: EdgeInsets.only(right:10.0),
                  ),
                  new RaisedButton(
                    onPressed: () => _selectTime4(context),
                    child: new Text(set_time4,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(right:5.0),
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
                          switch_text4 = '設定しているよ';
                        }
                        else {
                          switch_text4 = '設定していないよ';
                        }
                      });
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.only(right:5.0),
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
                  Padding(
                    padding: EdgeInsets.only(right:10.0),
                  ),
                  new RaisedButton(
                    onPressed: () => _selectTime5(context),
                    child: new Text(set_time5,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(right:5.0),
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
                          switch_text5 = '設定しているよ';
                        }
                        else {
                          switch_text5 = '設定していないよ';
                        }
                      });
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.only(right:5.0),
                  ),

                  Text(switch_text5),


                ],
              ),
            ),
            Text(
              "ストップボタンを押すと",
              style: TextStyle(
                fontSize: 34.0,
              ),
            ),
            Text(
            "アラームが止まるよ",
              style: TextStyle(
                fontSize: 34.0,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom:15.0),
            ),

            RaisedButton(
              child: Text("stop"),
              color: Colors.green,
              textColor:Colors.white,
              //onPressed: () => _player2.stop(),
              onPressed: () => stop(),
            ),
           /* RaisedButton(
              child: Text("遷移"),
              color: Colors.green,
              textColor:Colors.white,
              onPressed: () => Navigator.of(context).pushNamed("/second_page"),
            ),
            */
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
        automaticallyImplyLeading: false,
        title: const Text('今日の問題',
        style: TextStyle(color: Colors.black),
        ),
       // backgroundColor: Colors.black,
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


  //問題(乱数)
  //問1: 2桁×1桁 問2: 2桁+2桁 問3: 3桁-2桁
  int q1_n1 = Random().nextInt(100);
  int q1_n2 = Random().nextInt(10);


  int q2_n1 = Random().nextInt(100);
  int q2_n2 = Random().nextInt(100);

  int q3_n1 = Random().nextInt(1000);
  int q3_n2 = Random().nextInt(100);

  //回答の入力
  String _a1 = '0';
  String _a2 = '0';
  String _a3 = '0';

  //回答の判定
  String answer_judge1 = 'x';
  String answer_judge2 = 'x';
  String answer_judge3 = 'x';

  //回答
  String answer1 = '';
  String answer2 = '';
  String answer3 = '';


  //正解個数
  var correct_count = 0;

  //1問目を回答する関数
  void _q1Text(String e) {
    var temp = q1_n1 * q1_n2;
    String judge = 'x';

    //答え判定
    setState(() {answer1 = temp.toString();});
    //文字の入力を画面に反映
    setState(() { _a1 = e;});
    //入力した回答が正解かの判定
    if (_a1 == answer1){
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
    var temp = q2_n1 + q2_n2;

    setState(() {answer2 = temp.toString();});

    setState(() { _a2 = e;});

    if(_a2 == answer2){
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
    var temp = q3_n1 - q3_n2;


    setState(() {answer3 = temp.toString();});

    setState(() { _a3 = e;});

    if(_a3 == answer3){
      judge = '〇';
    }

    setState(() { answer_judge3 = judge;});

    if(answer_judge1 == '〇' && answer_judge2 == '〇' && answer_judge3 == '〇'){
      Navigator.of(context).pop();
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
        //appBar: AppBar(
       //   backgroundColor: Colors.white.withOpacity(0.0),
      //  ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top:5.0),
                  ),
                  Text(
                      'それぞれの式の下にある解答欄に答えを入力しよう',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      )
                  ),

                  Padding(
                    padding: EdgeInsets.only(top:5.0),
                  ),

                  Container(
                    color : Colors.black,
                    width: 380.0,
                    height: 39.0,
                      padding: EdgeInsets.only(left:10.0),
                    child:Text(//2桁×1桁
                      q1_n1.toString() + ' × ' +  q1_n2.toString() + ' = ' +  _a1 +  '    判定: ' + answer_judge1,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new TextField(
                    enabled: true,
                    maxLength: 3,
                    maxLengthEnforced: true,
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 23.0,
                    ),
                    obscureText: false,
                    maxLines:1,
                    onChanged: _q1Text,
                      decoration: new InputDecoration( contentPadding: const EdgeInsets.only(left:15.0)),
                  ),
                  Container(//2桁 + 2桁
                    color : Colors.black,
                    width: 380.0,
                    height: 39.0,
                    padding: EdgeInsets.only(left:10.0),
                    child: Text(
                      q2_n1.toString() + ' + ' +  q2_n2.toString() + ' = ' +  _a2 +  '    判定: ' + answer_judge2,
                      style: TextStyle(
                        fontSize: 24.0,
                        color:Colors.white,
                      ),
                    ),
                  ),

                  new  TextField(
                    enabled: true,
                    maxLength: 3,
                    maxLengthEnforced: true,
                    cursorColor: Colors.red,
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 23.0,
                    ),
                    obscureText: false,
                    maxLines:1,
                    onChanged: _q2Text,
                    decoration: new InputDecoration( contentPadding: const EdgeInsets.only(left:15.0)),
                  ),
                  Container(
                    color: Colors.black,
                    width: 380.0,
                    height: 39.0,
                    padding: EdgeInsets.only(left:10.0),
                    child: Text(//3桁-2桁
                      q3_n1.toString() + ' - ' +  q3_n2.toString() + ' = ' +  _a3 +  '    判定: ' + answer_judge3,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new TextField(
                    enabled: true,
                    maxLength: 3,
                    maxLengthEnforced: true,
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 23.0,
                    ),
                    obscureText: false,
                    maxLines:1,
                    onChanged: _q3Text,
                    decoration: new InputDecoration( contentPadding: const EdgeInsets.only(left:15.0)),
                  ),
                ]
            ),
        ),
    );
  }
}

//静的(加速度ゲーム)
class SubPage1 extends StatelessWidget {
  @override

  Widget build(BuildContext content) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: const Text('加速度ゲーム',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: _AccGame(),
      ),
    );
  }
}

class _AccGame extends StatefulWidget {
  @override

  _AccGameState createState() => _AccGameState();
}

class _AccGameState extends State< _AccGame>
{

  //加速度データ取得
  //nullの例外処理は初期値を与えることでなくなる
  List<double> _Acceler_Values = [0,0,0];
  List<StreamSubscription<dynamic>> _streamSubcriptions = <StreamSubscription<dynamic>>[];

  //pop判定
  int _pop = 1;

  //最大値と最小値
  double max = 0.0;
  double min = 0.0;


  void dispose() {//画面切り替え時:加速度データ取得を止める
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubcriptions) {
      subscription.cancel();

    }
  }

  void initState() {//.addで毎回データが入力されるため判定を行うと複数実行される可能性がある
    super.initState();
    _streamSubcriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        _Acceler_Values = <double>[event.x, event.y, event.z];
        if(_pop == 1) {
          Accer_game_Judge();
        }
      });
    }));
  }

  void Accer_game_Judge() {
    if(max < _Acceler_Values[0]){
      max =_Acceler_Values[0];
    }

    if(max < _Acceler_Values[1]){
      max = _Acceler_Values[1];
    }

    if(min > _Acceler_Values[0]) {
      min = _Acceler_Values[0];
    }

    if(min > _Acceler_Values[1]) {
      min = _Acceler_Values[1];
    }

    if (
        _Acceler_Values[0] > 13.0 || _Acceler_Values[1] > 13.0 ||
        _Acceler_Values[0] < -13.0 || _Acceler_Values[1] < -13.0
    ) {
      Navigator.of(context).pop();
      _pop = 0;
    }
  }

  Widget build(BuildContext context) {

    final String accel_x = _Acceler_Values[0].toStringAsFixed(1);
    final String accel_y = _Acceler_Values[1].toStringAsFixed(1);

    final max_S = max.toStringAsFixed(1);
    final min_S = min.toStringAsFixed(1);

    return Scaffold(
        body: Center(
        child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
              ),

              Text('縦、横にスマホを振り'
              ,
              style: TextStyle(
                fontSize: 20.0,
              ),
              ),
              Padding(
                padding: EdgeInsets.only(top:5.0),
              ),
              Text('最大値が13以上または'
                ,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text('最小値が-13未満になるとクリア'
                ,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              new Image.asset('images/GameDescription.PNG',width: 380.0, height:380.0),
              Padding(
                padding: EdgeInsets.only(top:30.0),
              ),
              Text('最大値:  $max_S 最小値:  $min_S',
                  style: TextStyle(
                    fontSize: 30.0,
                  )),
          ]
        ),
        ),
    );
  }

}
