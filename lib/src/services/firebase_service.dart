import 'dart:async';
import 'package:kpi_dash/src/models/models.dart';
import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:kpi_dash/src/models/year.dart';

@Injectable()
class FirebaseService {
  fb.User user;
  fb.DatabaseReference _fbRefYears;
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.Database _fbDatabase;
  List<Year> years;
  String password;
  fb.DatabaseReference fbPass;

  FirebaseService(){
    fb.initializeApp(
        apiKey: "AIzaSyAGY9I2J49szDBu3VJZY14WnC6xWMJOta4",
        authDomain: "fir-kpi-dashboard.firebaseapp.com",
        databaseURL: "https://fir-kpi-dashboard.firebaseio.com",
        storageBucket: "fir-kpi-dashboard.appspot.com");

    _fbDatabase = fb.database();
    fbPass = _fbDatabase.ref("pass");
    _fbRefYears = _fbDatabase.ref("years");
    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
   _fbAuth = fb.auth();
    password = "";
    initPass();
    years = [];
    initYears();
  }

  Future initPass() async
  {
    await fbPass.limitToLast(20).onChildAdded.listen(_newPass);

  }

  Future initYears() async
  {
    await _fbRefYears.limitToLast(20).onChildAdded.listen(_newYear);
  }

//  Future _authChanged(fb.AuthEvent event) async {
//    user = event.user;
//
//    if (user != null) {
//
//      await _fbRefYears.limitToLast(20).onChildAdded.listen(_newYear);
//    }
//  }

  Future _newPass (fb.QueryEvent ev) async{
    fb.DataSnapshot data = ev.snapshot;
    var val = data.val();
    var item = val.toString();
    password = item;
  }

  Future _newYear(fb.QueryEvent e) async{
    fb.DataSnapshot data = e.snapshot;
    // Value of data from snapshot.
    var val = data.val();
    // Creates a new Goal item. It is possible to retrieve a key from data.
    var item = new Year(
        val[yearTagText], [], data.key);
    years.add(item);
    fb.DatabaseReference fbRefGoals = _fbRefYears.child(item.key).child("goals");
    await fbRefGoals.limitToLast(60).onChildAdded.listen((fb.QueryEvent event) async {
      fb.DataSnapshot data = event.snapshot;
      // Value of data from snapshot.
      var val = data.val();
      // Creates a new Goal item. It is possible to retrieve a key from data.
      var g = new Goal(
          val[nameTagText], val[descTagText], [], data.key);
      item.goals.add(g);

      fb.DatabaseReference fbRefStrat = fbRefGoals.child(g.key).child(
          "strategies");
      await fbRefStrat
          .limitToLast(60)
          .onChildAdded
          .listen((fb.QueryEvent event2) async {
        fb.DataSnapshot data = event2.snapshot;
        // Value of data from snapshot.
        var val = data.val();
        // Creates a new Strategy item. It is possible to retrieve a key from data.
        var strat = new Strategy(
            val[name2TagText], val[desc2TagText], [], data.key);
        g.strategies.add(strat);

        fb.DatabaseReference fbRefInit = fbRefStrat.child(strat.key).child(
            "initiatives");
        await fbRefInit
            .limitToLast(60)
            .onChildAdded
            .listen((fb.QueryEvent event3) async {
          fb.DataSnapshot data = event3.snapshot;
          var val = data.val();
          var init = new Initiative(
              val[name3TagText], val[desc3TagText], [], data.key);
          strat.initiatives.add(init);

          fb.DatabaseReference fbRefDir = fbRefInit.child(init.key).child(
              "directives");
          await fbRefDir
              .limitToLast(60)
              .onChildAdded
              .listen((fb.QueryEvent event4) async {
            fb.DataSnapshot data = event4.snapshot;
            var val = data.val();
            var dir = new Dir(
                val[name4TagText], val[desc4TagText], val[maxValTagText], [],
                data.key);
            init.directives.add(dir);

            fb.DatabaseReference fbRefVal = fbRefDir.child(dir.key).child(
                "values");
            await fbRefVal
                .limitToLast(60)
                .onChildAdded
                .listen((fb.QueryEvent event5) async {
              fb.DataSnapshot data = event5.snapshot;
              var val = data.val();
              var v = new Value(
                  val[monthTagText], val[valTagText],
                  data.key);
              dir.values.add(v);
            });
          });
        });
      });
    });
  }




  Future addGoal(Year year, String name, String desc) async {
    try {
      Goal g = new Goal(name, desc, []);
      await _fbRefYears.child(year.key).child("goals").push(g.toMap(g));
    } catch (error) {
      print(error);
    }
  }

  Future addStrat(Year year, Goal goal, String name, String desc) async {
    try {
      Strategy s = new Strategy(name, desc, []);
      await _fbRefYears.child(year.key).child("goals").child(goal.key).child("strategies").push(s.toMap(s));
    } catch (error) {
      print(error);
    }
  }

  Future addInit(Year year, Goal goal, Strategy strat, String name, String desc) async {
    try {
      Initiative i = new Initiative(name, desc, []);
      await _fbRefYears
          .child(year.key)
          .child("goals")
          .child(goal.key)
          .child("strategies")
          .child(strat.key)
          .child("initiatives")
          .push(i.toMap(i));
    } catch (error) {
      print(error);
    }
  }

  Future addDir(Year year, Goal goal, Strategy strat, Initiative init, String name,
      String desc, num maxVal) async {
    try {
      Dir d = new Dir(name, desc, maxVal, []);
      await _fbRefYears
          .child(year.key)
          .child("goals")
          .child(goal.key)
          .child("strategies")
          .child(strat.key)
          .child("initiatives")
          .child(init.key)
          .child("directives")
          .push(d.toMap(d));
    } catch (error) {
      print(error);
    }
  }

  Future addVal(Year year,Goal goal, Strategy strat, Initiative init, Dir dir,
      String month, num v) async{
    try{
      Value val = new Value(month, v);
      for(int i=0; i<dir.values.length; i++){
        if(month==dir.values[i].month)
          return;
      }
      await _fbRefYears.child(year.key).child("goals").child(goal.key).child("strategies").
      child(strat.key).child("initiatives").child(init.key).
      child("directives").child(dir.key).child("values").push(val.toMap(val));
    }
    catch (error) {
      print(error);
    }
  }

  Future changeGoalName(Year year, Goal goal, String name) async {
    await _fbRefYears
        .child(year.key)
        .child("goals")
        .child(goal.key)
        .child("name")
        .set(name);
  }

  Future changeGoalDescription(Year year, Goal goal, String desc) async {
    await _fbRefYears
        .child(year.key)
        .child("goals")
        .child(goal.key)
        .child("description")
        .set(desc);
  }

  Future changeStratName(Year year, Goal goal, Strategy strat) async {
    await _fbRefYears
        .child(year.key)
        .child("goals")
        .child(goal.key)
        .child("strategies")
        .child(strat.key)
        .child("name")
        .set(strat.name);
  }

  Future changeStratDescription(Year year, Goal goal, Strategy strat) async {
    await _fbRefYears
        .child(year.key)
        .child("goals")
        .child(goal.key)
        .child("strategies")
        .child(strat.key)
        .child("description")
        .set(strat.description);
  }

  Future changeInitName(Year year, Goal goal, Strategy strat, Initiative init) async {
    await _fbRefYears
        .child(year.key)
        .child("goals")
        .child(goal.key)
        .child("strategies")
        .child(strat.key)
        .child("initiatives")
        .child(init.key)
        .child("name")
        .set(init.name);
  }

  Future changeInitDescription(
      Year year, Goal goal, Strategy strat, Initiative init) async {
    await _fbRefYears
        .child(year.key)
        .child("goals")
        .child(goal.key)
        .child("strategies")
        .child(strat.key)
        .child("initiatives")
        .child(init.key)
        .child("description")
        .set(init.description);
  }

  Future changeDirName(
      Year year, Goal goal, Strategy strat, Initiative init, Dir dir) async {
    await _fbRefYears
        .child(year.key)
        .child("goals")
        .child(goal.key)
        .child("strategies")
        .child(strat.key)
        .child("initiatives")
        .child(init.key)
        .child("directives")
        .child(dir.key)
        .child("name")
        .set(dir.name);
  }

  Future changeDirDescription(
      Year year, Goal goal, Strategy strat, Initiative init, Dir dir) async {
    await _fbRefYears
        .child(year.key)
        .child("goals")
        .child(goal.key)
        .child("strategies")
        .child(strat.key)
        .child("initiatives")
        .child(init.key)
        .child("directives")
        .child(dir.key)
        .child("description")
        .set(dir.description);
  }

  Future changeDirMax(
      Year year, Goal goal, Strategy strat, Initiative init, Dir dir) async {
    await _fbRefYears
        .child(year.key)
        .child("goals")
        .child(goal.key)
        .child("strategies")
        .child(strat.key)
        .child("initiatives")
        .child(init.key)
        .child("directives")
        .child(dir.key)
        .child("max value")
        .set(dir.maxValue);
  }

  Future changeVal(Year year, Goal goal, Strategy strat, Initiative init, Dir dir, Value val) async {
    await _fbRefYears
        .child(year.key)
        .child("goals")
        .child(goal.key)
        .child("strategies")
        .child(strat.key)
        .child("initiatives")
        .child(init.key)
        .child("directives")
        .child(dir.key)
        .child("values")
        .child(val.key)
        .child("value")
        .set(val.value);
  }

  Future changePass(String s) async {
    await fbPass.child("password").set(s);
  }

  Future deleteGoal(String key1, String key2) async {
    try {
      await _fbRefYears.child(key1).child("goals").child(key2).remove();
    } catch (e) {
      print("Error in deleting $key2: $e");
    }
  }

  Future deleteStrategy(String key1, String key2, String key3) async {
    try {
      await _fbRefYears.child(key1).child("goals").child(key2).child("strategies").child(key3).remove();
    } catch (e) {
      print("Error in deleting $key3: $e");
    }
  }

  Future deleteInit(String key1, String key2, String key3, String key4) async {
    try {
      await _fbRefYears
          .child(key1)
          .child("goals")
          .child(key2)
          .child("strategies")
          .child(key3)
          .child("initiatives")
          .child(key4)
          .remove();
    } catch (e) {
      print("Error in deleting $key4: $e");
    }
  }

  Future deleteDir(String key1, String key2, String key3, String key4, key5) async {
    try {
      await _fbRefYears
          .child(key1)
          .child("goals")
          .child(key2)
          .child("strategies")
          .child(key3)
          .child("initiatives")
          .child(key4)
          .child("directives")
          .child(key5)
          .remove();
    } catch (e) {
      print("Error in deleting $key5: $e");
    }
  }

  Future deleteVal(String key1, String key2, String key3, String key4, String key5, String key6) async {
    try {
      await _fbRefYears
          .child(key1)
          .child("goals")
          .child(key2)
          .child("strategies")
          .child(key3)
          .child("initiatives")
          .child(key4)
          .child("directives")
          .child(key5)
          .child("values")
          .child(key6)
          .remove();
    } catch (e) {
      print("Error in deleting $key6: $e");
    }
  }

  Future signIn() async {
    try {
      await _fbAuth.signInWithPopup(_fbGoogleAuthProvider);
    } catch (error) {
      print("%runtimeType::login() --$error");
    }
  }

  void signOut() {
    _fbAuth.signOut();
  }
}
