import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'package:sensors/sensors.dart';

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
      debugShowCheckedModeBanner: false,
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

  //時間を設定
   List<String> setTime = ['00:00','00:00','00:00','00:00','00:00'];

   //時間表示
   List<String> setTimeOutput = ['AM 00:00','AM 00:00','AM 00:00','AM 00:00','AM 00:00'];

  //アラームを鳴らすか止めるかの判定
   var judge = 0;

   //スイッチの切り替え
   List<bool> _active = [false,false,false,false,false];
   //スイッチの表示
   List<String> switchText = ["設定してないよ.","設定してないよ.","設定してないよ."
     ,"設定してないよ.","設定してないよ."];


  void initState() { //現在時刻を取得する関数(1秒ごとに判定)
    Timer.periodic(
      Duration(seconds: 1),
      _onTimer,
    );
    super.initState();
  }


  void _onTimer(Timer timer) {//現在時刻を時、分にフォーマットし、アラームを鳴らす関数

    String nowTime = ''; //現在時刻の変数
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm');
    nowTime = formatter.format(now);

    //ゲームの選択
    int scene = Random().nextInt(2);
    //0の場合: 計算ゲーム 1の場合:加速度ゲーム


    if (switchText[0] == "設定しているよ" && setTime[0] == nowTime) {
      judge++;
      play();//アラーム再生
      gameSelect(scene);//ゲーム選択
      switchText[0] = "設定してないよ";//アラームを止めた後にアラームがならないための処理
    }
    else if (switchText[1] == "設定しているよ" && setTime[1] == nowTime) {
      judge++;
      play();//アラーム再生
      gameSelect(scene);//ゲーム選択
      switchText[1] = "設定してないよ";//アラームを止めた後にアラームがならないための処理
    }
    else if (switchText[2] == "設定しているよ" && setTime[2] == nowTime) {
      judge++;
      play();//アラーム再生
      gameSelect(scene);//ゲーム選択
      switchText[2] = "設定してないよ";//アラームを止めた後にアラームがならないための処理
    }
    else if (switchText[3] == "設定しているよ" && setTime[3] == nowTime) {
      judge++;
      play();//アラーム再生
      gameSelect(scene);//ゲーム選択
      switchText[3] = "設定してないよ";//アラームを止めた後にアラームがならないための処理
    }
    else if (switchText[4] == "設定しているよ" && setTime[4] == nowTime) {
      judge++;
      play();//アラーム再生
      gameSelect(scene);//ゲーム選択
      switchText[4] = "設定してないよ";//アラームを止めた後にアラームがならないための処理
    }

  }


  //音楽の再生の関数
  void play()  async {
    if(judge == 1){
      _player2 = await _player.loop('sounds/a.mp3');
    }
  }

  //音声の停止の関数
  void stop() {
    _player2.stop();
    judge = 0;
  }

  //ゲーム選択の関数
   void gameSelect(select) {
     if(select == 0){
       Navigator.of(context).pushNamed("/first_page");
     }
     else if(select == 1){
       Navigator.of(context).pushNamed("/second_page");
     }
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
        setTimeOutput[0] = (DateFormat('a hh:mm')).format(dt);
        setTime[0] = (DateFormat('HH:mm')).format(dt);
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
        setTimeOutput[1] = (DateFormat('a hh:mm')).format(dt);
        setTime[1] = (DateFormat('HH:mm')).format(dt);
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
        setTimeOutput[2] = (DateFormat('a hh:mm')).format(dt);
        setTime[2] = (DateFormat('HH:mm')).format(dt);
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
        setTimeOutput[3] = (DateFormat('a hh:mm')).format(dt);
        setTime[3] = (DateFormat('HH:mm')).format(dt);
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
        setTimeOutput[4] = (DateFormat('a hh:mm')).format(dt);
        setTime[4] = (DateFormat('HH:mm')).format(dt);
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
            Padding(
              padding: EdgeInsets.only(top:9.0),
            ),
            Text(
              "時間を設定しよう.",
              style: TextStyle(
                fontSize: 29.0,
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
                      child: new Text(setTimeOutput[0],
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(right:5.0),
                  ),

                    new Switch(
                      value: _active[0],
                      activeColor: Colors.black,
                      activeTrackColor: Colors.black,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.white,
                      onChanged: (bool value) {
                        setState(() {
                          _active[0] = value;
                          if(_active[0] == true) {
                            switchText[0] = '設定しているよ';
                          }
                          else {
                            switchText[0] = '設定してないよ';
                          }
                        });
                      },
                    ),
                  Padding(
                    padding: EdgeInsets.only(right:5.0),
                  ),
                    Text(switchText[0]),
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
                  child: new Text(setTimeOutput[1],
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(right:5.0),
                ),

                new Switch(
                  value: _active[1],
                  activeColor: Colors.black,
                  activeTrackColor: Colors.black,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      _active[1] = value;
                      if(_active[1] == true) {
                        switchText[1] = '設定しているよ';
                      }
                      else {
                        switchText[1] = '設定してないよ';
                      }
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(right:5.0),
                ),
                Text(switchText[1]),
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
                    child: new Text(setTimeOutput[2],
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(right:5.0),
                  ),

                  new Switch(
                    value: _active[2],
                    activeColor: Colors.black,
                    activeTrackColor: Colors.black,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.white,
                    onChanged: (bool value) {
                      setState(() {
                        _active[2] = value;
                        if(_active[2] == true) {
                          switchText[2] = '設定しているよ';
                        }
                        else {
                          switchText[2] = '設定してないよ';
                        }
                      });
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.only(right:5.0),
                  ),

                  Text(switchText[2]),
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
                    child: new Text(setTimeOutput[3],
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(right:5.0),
                  ),

                  new Switch(
                    value: _active[3],
                    activeColor: Colors.black,
                    activeTrackColor: Colors.black,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.white,
                    onChanged: (bool value) {
                      setState(() {
                        _active[3] = value;
                        if(_active[3] == true) {
                          switchText[3] = '設定しているよ';
                        }
                        else {
                          switchText[3] = '設定してないよ';
                        }
                      });
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.only(right:5.0),
                  ),

                  Text(switchText[3]),
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
                    child: new Text(setTimeOutput[4],
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(right:5.0),
                  ),

                  new Switch(
                    value: _active[4],
                    activeColor: Colors.black,
                    activeTrackColor: Colors.black,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.white,
                    onChanged: (bool value) {
                      setState(() {
                        _active[4] = value;
                        if(_active[4] == true) {
                          switchText[4] = '設定しているよ';
                        }
                        else {
                          switchText[4] = '設定してないよ';
                        }
                      });
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.only(right:5.0),
                  ),

                  Text(switchText[4]),
                ],
              ),
            ),
            /*Text(
              "ストップボタンを押すと",
              style: TextStyle(
                fontSize: 34.0,
              ),
            ),
             */
            Text(
            "アラームが止まるよ",
              style: TextStyle(
                fontSize: 34.0,
              ),
            ),
            Text(
              "↓",
              style: TextStyle(
                fontSize: 34.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom:8.0),
            ),

            RaisedButton(
              child: Text("stop"),
              color: Colors.green,
              textColor:Colors.white,
              //onPressed: () => _player2.stop(),
              onPressed: () => stop(),
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

  //問1: 2桁-1桁
  int q1N1 = Random().nextInt(100);
  int q1N2 = Random().nextInt(10);

  //問2: 2桁+2桁
  int q2N1 = Random().nextInt(100);
  int q2N2 = Random().nextInt(100);

  //問3: 3桁-2桁
  int q3N1 = Random().nextInt(1000);
  int q3N2 = Random().nextInt(100);

  //回答の入力
  String answerText = '';

  //回答判定の保存
  List<String> answerJudge = ['x','x','x'];

  //回答の判定
  String OutputA = '';

  //回答
  List<String> answer = ['','',''];

  int trueCount = 0;

  //式の表示
  String output = '';

  //表示用
  String n1 = '';
  String n2 = '';
  String calC = ' × ';

  var _controller = TextEditingController();

  //回答する関数
  void _q1Text(String a) {
    answer[0] = (q1N1 * q1N2).toString();//答え判定
    answer[1] = (q2N1 + q2N2).toString();//答え判定
    answer[2] = (q3N1 - q3N2).toString();//答え判定
    while(q3N1 - q3N2 < 0){
      q3N1 = Random().nextInt(1000);
      q3N2 = Random().nextInt(100);
    }

    setState(() { //配当の判定

        answerText = a;//入力文字を反映

      if (a == answer[0]) {//問1判定
        answerJudge[0] = '〇';
        trueCount++;
        answerText = '';
      }
      if (a == answer[1]) {//問2判定
        answerJudge[1] = '〇';
        trueCount++;
        answerText = '';
        }
      if (a == answer[2]) {//問3判定
        answerJudge[2] = '〇';
        trueCount++;
        }

      a = '';
    });

    _allQuestion();
  }

void _allQuestion() {//全問正解か判定する関数
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (trueCount == 3) {
      FocusScope.of(context).requestFocus(new FocusNode());
      Navigator.of(context).pop();
    }
  });
}

  Future<bool> _onBackPressed() async {//本体の戻るボタンを押しても戻らない関数
    return false;//でバック用に変更
  }


  Widget build(BuildContext context) {

    n1 = q1N1.toString();
    n2 = q1N2.toString();
    OutputA = answerJudge[0];

    if( answerJudge[0] == '〇'){//問1表示
      n1 = q2N1.toString();
      n2 = q2N2.toString();
      calC = ' + ';
      OutputA = answerJudge[1];
    }
    if(answerJudge[1] == '〇'){
    n1 = q3N1.toString();
    n2 = q3N2.toString();
    calC = ' - ';
    OutputA = answerJudge[2];
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
    child: Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top:15.0),
                  ),
                  Text(
                      '解答欄に答えを入力しよう',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:10.0),
                  ),
                  Text(
                      '3問クリアすると元の画面に戻るよ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                      )
                  ),

                  Padding(
                    padding: EdgeInsets.only(top:10.0),
                  ),

                  Container(
                    color : Colors.black,
                    width: 380.0,
                    height: 68.0,
                      padding: EdgeInsets.only(top: 10.0,left:30.0),
                    child:Text(//2桁×1桁
                      n1 +  calC +  n2  + ' = ' + answerText,
                      style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  new TextField(
                    keyboardType: TextInputType.number,
                    enabled: true,
                    maxLength: 3,
                    maxLengthEnforced: true,
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 35.0,
                    ),
                    obscureText: false,
                    maxLines:1,
                    controller: _controller,
                    onChanged: _q1Text,
                    decoration: new InputDecoration( contentPadding: const EdgeInsets.only(top: 10.0,left:180.0),
                    suffixIcon: FloatingActionButton(
                      onPressed: (() => _controller.clear()),
                      child: const Text(
                        '削除',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:15.0,
                        )
                      )
                    )),
                  ),

                  Text(
                    trueCount.toString() + ' / ' + '3',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                  ),
                      Text(
                        '正解数 / 総問題数',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                ]
            ),
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
  List<double> _accelerateValues = [0,0,0];
  List<StreamSubscription<dynamic>> _streamSubscriptions = <StreamSubscription<dynamic>>[];

  //pop判定(popしすぎないため)
  int _pop = 1;

  //矢印表示
  String arrowImage = '';

  int clearOutput = 0;


  //矢印方向格納
  //矢印方向確定
  //値0:横 値1:縦
  var arrowDirection = Random().nextInt(2);

  void dispose() {//画面切り替え時:加速度データ取得を止める
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  void initState() {//.addで毎回データが入力されるため判定を行うと複数実行される可能性がある
    super.initState();
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        _accelerateValues = <double>[event.x, event.y];
        if(_pop == 1) {
          _accelerateGameJudge();
        }
      });
    }));
  }

  void _accelerateGameJudge() {
    if (arrowDirection == 0) { //画像判定
      arrowImage = 'images/side.PNG';
      if (_accelerateValues[0] > 30 ||
          _accelerateValues[0] < -30) {
          Navigator.of(context).pop();
          _pop = 0;
      }
    }
    else if (arrowDirection == 1) {
      arrowImage = 'images/vertical.PNG';
      if (_accelerateValues[1] > 22 ||
          _accelerateValues[1] < -22) {
        Navigator.of(context).pop();
        _pop = 0;
      }
    }
  }


  Future<bool> _onBackPressed() async {//本体の戻るボタンを押しても戻らない関数
    return false;//でバック用に変更
  }


  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPressed,
    child: Scaffold(
        body: Center(
        child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:5.0),
              ),

              Padding(
                padding: EdgeInsets.only(top:30.0),
              ),
              Text(
                  '矢印の方向に振ろう!',
                style: TextStyle(
                  fontSize: 26.0,
                )
              ),
              Padding(
                padding: EdgeInsets.only(top:5.0),
              ),
              new Image.asset(arrowImage ,width: 150.0, height: 150.0),
              Padding(
                padding: EdgeInsets.only(top:5.0),
              ),
              Text("画面が戻るとクリア",
              style: TextStyle(
                fontSize: 26.0,
              )
              ),
          ]
        ),
        ),
    ),
    );
  }

}
