import 'package:angular2/core.dart';
import 'dart:core';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/src/models/models.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';
import 'dart:html';

@Component(
  selector: 'my-val',
  styleUrls: const ['val_component.css'],
  templateUrl: 'val_component.html',
  directives: const [
    materialDirectives,
    COMMON_DIRECTIVES,
    CORE_DIRECTIVES
  ])
class ValComponent {
  bool saveDialog = false;
  String message;

  @Input()
  Year year;

  final FirebaseService fbService;
  ValComponent(this.fbService);

  var months = const <String>[
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  String month = "January";

  void addValue(Year year, Goal goal, Strategy strat, Initiative init, Dir dir,
      String number) {
    num value = int.parse(number);

    if (value == null) return;

    fbService.addVal(year, goal, strat, init, dir, month, value);
    message = "Value Added";
    saveDialog = !fbService.preventAdditional;
  }

  void changeValue(Year year, Goal goal, Strategy strat, Initiative init,
      Dir dir, Value val, String input) {
    num number = int.parse(input);
    fbService.changeVal(year, goal, strat, init, dir, val, number);
    message = "Edit Saved";
    saveDialog = !fbService.preventAdditional;
  }

  bool contains(Dir dir) {
    return getVal(dir) != null;
  }

  Value getVal(Dir dir) {
    for (Value val in dir.values) {
      if (val.month == month) return val;
    }
    return null;
  }

  num getTotalToDate(Dir dir) {
    int total = 0;
    int monIndex = months.indexOf(month);
    for (Value val in dir.values) {
      if (months.indexOf(val.month) < monIndex) total += val.value;
    }
    return total;
  }
}
