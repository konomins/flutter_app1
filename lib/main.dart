import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'package:sensors/sensors.dart';
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

  //現在時刻の変数
  String nowTime = '';

  //アラームを鳴らすか止めるかの判定
   var judge = 0;

   //スイッチの切り替え
   List<bool> _active = [false,false,false,false,false];
   //スイッチの表示
   List<String> switchText = ["設定していないよ.","設定していないよ.","設定していないよ."
     ,"設定していないよ.","設定していないよ."];


  void initState() { //現在時刻を取得する関数(1秒ごとに判定)
    Timer.periodic(
      Duration(seconds: 1),
      _onTimer,
    );
    super.initState();
  }


  void _onTimer(Timer timer) {//現在時刻を時、分にフォーマットし、アラームを鳴らす関数
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
      switchText[0] = "設定していないよ";//アラームを止めた後にアラームがならないための処理
    }
    else if (switchText[1] == "設定しているよ" && setTime[1] == nowTime) {
      judge++;
      play();//アラーム再生
      gameSelect(scene);//ゲーム選択
      switchText[1] = "設定していないよ";//アラームを止めた後にアラームがならないための処理
    }
    else if (switchText[2] == "設定しているよ" && setTime[2] == nowTime) {
      judge++;
      play();//アラーム再生
      gameSelect(scene);//ゲーム選択
      switchText[2] = "設定していないよ";//アラームを止めた後にアラームがならないための処理
    }
    else if (switchText[3] == "設定しているよ" && setTime[3] == nowTime) {
      judge++;
      play();//アラーム再生
      gameSelect(scene);//ゲーム選択
      switchText[3] = "設定していないよ";//アラームを止めた後にアラームがならないための処理
    }
    else if (switchText[4] == "設定しているよ" && setTime[4] == nowTime) {
      judge++;
      play();//アラーム再生
      gameSelect(scene);//ゲーム選択
      switchText[4] = "設定していないよ";//アラームを止めた後にアラームがならないための処理
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
        setTime[0] = (DateFormat.Hm()).format(dt);
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
        setTime[1] = (DateFormat.Hm()).format(dt);
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
        setTime[2] = (DateFormat.Hm()).format(dt);
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
        setTime[3] = (DateFormat.Hm()).format(dt);
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
        setTime[4] = (DateFormat.Hm()).format(dt);
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
                      child: new Text(setTime[0],
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
                            switchText[0] = '設定していないよ';
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
                  child: new Text(setTime[1],
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
                        switchText[1] = '設定していないよ';
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
                    child: new Text(setTime[2],
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
                          switchText[2] = '設定していないよ';
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
                    child: new Text(setTime[3],
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
                          switchText[3] = '設定していないよ';
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
                    child: new Text(setTime[4],
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
                          switchText[4] = '設定していないよ';
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


  int q1N1 = Random().nextInt(100);
  int q1N2 = Random().nextInt(10);


  //問2: 2桁+2桁
  int q2N1 = Random().nextInt(100);
  int q2N2 = Random().nextInt(100);

  //問3: 3桁-2桁
  int q3N1 = Random().nextInt(1000);
  int q3N2 = Random().nextInt(100);

  //回答の入力//
  List<String> answerText = ['0','0','0'];

  //回答の判定
  List<String> answerJudge = ['x','x','x'];

  //回答
  List<String> answer = ['','',''];


  //正解個数
  var correctCount = 0;

  //1問目を回答する関数
  void _q1Text(String e) {
    var temp = q1N1 * q1N2;
    String judge = 'x';

    //答え判定
    setState(() {answer[0] = temp.toString();});
    //文字の入力を画面に反映
    setState(() { answerText[0] = e;});
    //入力した回答が正解かの判定
    if (answerText[0] == answer[0]) {
       judge = '〇';
      correctCount++;
    }
    setState(() {answerJudge[0] = judge;});

    if(answerJudge[0] == '〇' && answerJudge[1] == '〇' && answerJudge[2] == '〇'){
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.of(context).pop();
    }

  }

  //2問目を回答する関数
  void _q2Text(String e) {
    String judge = 'x';
    var temp = q2N1 + q2N2;

    setState(() {answer[1] = temp.toString();});

    setState(() { answerText[1] = e;});

    if(answerText[1] == answer[1]){
      judge = '〇';
    }

    setState(() { answerJudge[1] = judge;});

    if(answerJudge[0] == '〇' && answerJudge[1] == '〇' && answerJudge[2] == '〇'){
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.of(context).pop();
    }
  }

  //3問目を回答する関数
  void _q3Text(String e) {
    String judge = 'x';
    var temp = q3N1 - q3N2;

    setState(() {answer[2] = temp.toString();});

    setState(() { answerText[2] = e;});

    if(answerText[2] == answer[2]){
      judge = '〇';
    }

    setState(() { answerJudge[2] = judge;});

    if(answerJudge[0] == '〇' && answerJudge[1] == '〇' && answerJudge[2] == '〇'){
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.of(context).pop();
    }
  }


  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top:5.0),
                  ),
                  Text(
                      '解答欄に答えを入力しよう',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      )
                  ),
                  Text(
                      '3問クリアすると元の画面に戻るよ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
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
                      q1N1.toString() + ' × ' +  q1N2.toString() + ' = ' +
                          answerText[0] +  '    判定: ' + answerJudge[0],
                      style: TextStyle(
                        fontSize: 24.0,
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
                      q2N1.toString() + ' + ' +  q2N2.toString() + ' = ' +
                          answerText[1] + '    判定: ' + answerJudge[1],
                      style: TextStyle(
                        fontSize: 24.0,
                        color:Colors.white,
                      ),
                    ),
                  ),

                  new  TextField(
                    keyboardType: TextInputType.number,
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
                      q3N1.toString() + ' - ' +  q3N2.toString() + ' = ' +
                          answerText[2] + '    判定: ' + answerJudge[2],
                      style: TextStyle(
                        fontSize: 24.0,
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
  List<double> _accelerateValues = [0,0,0];
  List<StreamSubscription<dynamic>> _streamSubscriptions = <StreamSubscription<dynamic>>[];

  //pop判定
  int _pop = 1;

  //最大値と最小値
  double max = 0.0;
  double min = 0.0;


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
        _accelerateValues = <double>[event.x, event.y, event.z];
        if(_pop == 1) {
          _accelerateGameJudge();
        }
      });
    }));
  }

  void _accelerateGameJudge() {
    if(max < _accelerateValues[0]){
      max =_accelerateValues[0];
    }

    if(max < _accelerateValues[1]){
      max = _accelerateValues[1];
    }

    if(min > _accelerateValues[0]) {
      min = _accelerateValues[0];
    }

    if(min > _accelerateValues[1]) {
      min = _accelerateValues[1];
    }

    if (
        _accelerateValues[0] > 13.0 || _accelerateValues[1] > 13.0 ||
        _accelerateValues[0] < -13.0 || _accelerateValues[1] < -13.0
    ) {
      Navigator.of(context).pop();
      _pop = 0;
    }
  }

  Widget build(BuildContext context) {

    final maxS = max.toStringAsFixed(1);
    final minS = min.toStringAsFixed(1);

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
              Text('クリアすると元の画面に戻るよ'
                ,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              new Image.asset('images/GameDescription.PNG',width: 380.0, height:380.0),
              Padding(
                padding: EdgeInsets.only(top:30.0),
              ),
              Text('最大値:  $maxS 最小値:  $minS',
                  style: TextStyle(
                    fontSize: 30.0,
                  )),
          ]
        ),
        ),
    );
  }

}
