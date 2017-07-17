import 'dart:async';
import 'package:kpi_dash/src/models/models.dart';
import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart' as fb;

@Injectable()
class FirebaseService {
  fb.User user;
  List<Goal> goals;
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.Database _fbDatabase;
  fb.DatabaseReference _fbRefGoals;

  FirebaseService() {
    fb.initializeApp(
        apiKey: "AIzaSyAgK7z0NAOG87I1Fgi-5wkA-sJlsW00L44",
        authDomain: "fir-tier-4-kpi-dashboard.firebaseapp.com",
        databaseURL: "https://fir-tier-4-kpi-dashboard.firebaseio.com",
        storageBucket: "fir-tier-4-kpi-dashboard.appspot.com");

    _fbDatabase = fb.database();
    _fbRefGoals = _fbDatabase.ref("goals");
    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
    _fbAuth = fb.auth();
    _fbAuth.onAuthStateChanged.listen(_authChanged);
  }

  Future _authChanged(fb.AuthEvent event) async {
    user = event.user;

    if (user != null) {
      goals = [];
      await _fbRefGoals.limitToLast(60).onChildAdded.listen(_newGoal);
    }
  }

  Future _newGoal(fb.QueryEvent event) async {
    fb.DataSnapshot data = event.snapshot;
    // Value of data from snapshot.
    var val = data.val();
    // Creates a new Goal item. It is possible to retrieve a key from data.
    var item = new Goal(
        val[nameTagText], val[descTagText], [], data.key);
    goals.add(item);

    fb.DatabaseReference fbRefStrat = _fbRefGoals.child(item.key).child("strategies");
    await fbRefStrat.limitToLast(60).onChildAdded.listen((fb.QueryEvent event2) async{
      fb.DataSnapshot data = event2.snapshot;
      // Value of data from snapshot.
      var val = data.val();
      // Creates a new Strategy item. It is possible to retrieve a key from data.
      var strat = new Strategy(
          val[name2TagText], val[desc2TagText], [], data.key);
      item.strategies.add(strat);

      fb.DatabaseReference fbRefInit = fbRefStrat.child(strat.key).child("initiatives");
      await fbRefInit.limitToLast(60).onChildAdded.listen((fb.QueryEvent event3) async{
        fb.DataSnapshot data = event3.snapshot;
        var val = data.val();
        var init = new Initiative(
            val[name3TagText], val[desc3TagText], [], data.key);
        strat.initiatives.add(init);

        fb.DatabaseReference fbRefDir = fbRefInit.child(init.key).child("directives");
        await fbRefDir.limitToLast(60).onChildAdded.listen((fb.QueryEvent event4) async{
          fb.DataSnapshot data = event4.snapshot;
          var val = data.val();
          var dir = new Dir(
              val[name4TagText], val[desc4TagText], val[maxValTagText], [], data.key);
          init.directives.add(dir);

        });
      });
    });

  }

  Future addGoal(String name, String desc) async {
    try {
      Goal g = new Goal(name, desc, []);
      await _fbRefGoals.push(g.toMap(g));
    } catch (error) {
      print(error);
    }
  }

  Future addStrat(Goal goal, String name, String desc) async {
    try {
      Strategy s = new Strategy(name, desc, []);
      await _fbRefGoals.child(goal.key).child("strategies").push(s.toMap(s));
    } catch (error) {
      print(error);
    }
  }

  Future addInit(Goal goal, Strategy strat, String name, String desc) async {
    try {
      Initiative i = new Initiative(name, desc, []);
      await _fbRefGoals
          .child(goal.key)
          .child("strategies")
          .child(strat.key)
          .child("initiatives")
          .push(i.toMap(i));
    } catch (error) {
      print(error);
    }
  }

  Future addDir(Goal goal, Strategy strat, Initiative init, String name,
      String desc, num maxVal) async {
    try {
      Dir d = new Dir(name, desc, maxVal, []);
      await _fbRefGoals
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

  Future changeGoalName(Goal goal) async {
    await _fbRefGoals.child(goal.key).child("name").set(goal.name);
  }

  Future changeGoalDescription(Goal goal) async {
    await _fbRefGoals
        .child(goal.key)
        .child("description")
        .set(goal.description);
  }

  Future changeStratName(Goal goal, Strategy strat) async {
    await _fbRefGoals
        .child(goal.key)
        .child("strategies")
        .child(strat.key)
        .child("name")
        .set(strat.name);
  }

  Future changeStratDescription(Goal goal, Strategy strat) async {
    await _fbRefGoals
        .child(goal.key)
        .child("strategies")
        .child(strat.key)
        .child("description")
        .set(strat.description);
  }

  Future changeInitName(Goal goal, Strategy strat, Initiative init) async {
    await _fbRefGoals
        .child(goal.key)
        .child("strategies")
        .child(strat.key)
        .child("initiatives")
        .child(init.key)
        .child("name")
        .set(init.name);
  }

  Future changeInitDescription(
      Goal goal, Strategy strat, Initiative init) async {
    await _fbRefGoals
        .child(goal.key)
        .child("strategies")
        .child(strat.key)
        .child("initiatives")
        .child(init.key)
        .child("description")
        .set(init.description);
  }

  Future changeDirName(
      Goal goal, Strategy strat, Initiative init, Dir dir) async {
    await _fbRefGoals
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
      Goal goal, Strategy strat, Initiative init, Dir dir) async {
    await _fbRefGoals
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
      Goal goal, Strategy strat, Initiative init, Dir dir) async {
    await _fbRefGoals
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

  Future deleteGoal(String key) async {
    try {
      await _fbRefGoals.child(key).remove();
    } catch (e) {
      print("Error in deleting $key: $e");
    }
  }

  Future deleteStrategy(String key1, String key2) async {
    try {
      await _fbRefGoals.child(key1).child("strategies").child(key2).remove();
    } catch (e) {
      print("Error in deleting $key2: $e");
    }
  }

  Future deleteInit(String key1, String key2, String key3) async {
    try {
      await _fbRefGoals
          .child(key1)
          .child("strategies")
          .child(key2)
          .child("initiatives")
          .child(key3)
          .remove();
    } catch (e) {
      print("Error in deleting $key3: $e");
    }
  }

  Future deleteDir(String key1, String key2, String key3, String key4) async {
    try {
      await _fbRefGoals
          .child(key1)
          .child("strategies")
          .child(key2)
          .child("initiatives")
          .child(key3)
          .child("directives")
          .child(key4)
          .remove();
    } catch (e) {
      print("Error in deleting $key4: $e");
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
