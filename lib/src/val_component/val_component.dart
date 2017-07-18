import 'package:angular2/core.dart';
import 'dart:core';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/src/models/directive.dart';
import 'package:kpi_dash/src/models/goal.dart';
import 'package:kpi_dash/src/models/initiative.dart';
import 'package:kpi_dash/src/models/strategy.dart';
import 'package:kpi_dash/src/models/value.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';


@Component(
  selector: 'my-val',
  styleUrls: const ['val_component.css'],
  templateUrl: 'val_component.html',
  directives: const [materialDirectives, COMMON_DIRECTIVES, CORE_DIRECTIVES,
  MaterialExpansionPanel, MaterialExpansionPanelSet,
  DisplayNameRendererDirective,
  MaterialCheckboxComponent,
  MaterialDropdownSelectComponent,
  MaterialSelectComponent,
  MaterialSelectItemComponent,],
  providers: const [materialProviders],
)

class ValComponent {


  var years = const <num>[
    2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025, 2026,
    2027, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035, 2036, 2037,
    2038, 2039, 2040, 2041, 2042, 2043, 2044, 2045, 2046, 2047, 2048,
    2049, 2050, 2051, 2052, 2053, 2054, 2055, 2056, 2057, 2058, 2059,
    2060,
  ];

  var months = const <String>[
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];


  final FirebaseService fbService5;

  ValComponent(this.fbService5);
  String month = null;
  num year = null;


  Value selectedVal;

  

  void pickYear(num y) {
    year = y;
    print(year);
  }

  void pickMonth(String m) {
    month = m;
    print (month);
  }



  num inputVal = 0;
  void addValue(Goal goal, Strategy strat, Initiative init, Dir dir,) {
    num value = inputVal;

    if (value == null) return;

    fbService5.addVal(goal, strat, init, dir, month, year, value);
  }

  void deleteValue(Goal goal, Strategy strat, Initiative init, Dir dir, Value val){
    fbService5.deleteVal(goal.key, strat.key, init.key, dir.key, val.key);
    dir.values.remove(val);
  }

  void changeValue(Goal goal, Strategy strat, Initiative init, Dir dir, Value val){
    fbService5.changeVal(goal, strat, init, dir, val);
  }

  void onSelect(Value val){
    selectedVal = val;
  }


}