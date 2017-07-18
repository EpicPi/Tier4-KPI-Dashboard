import 'package:angular2/core.dart';

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/src/directive_component/directive_component.dart';
import 'package:kpi_dash/src/initiative_component/initiative_component.dart';
import 'package:kpi_dash/src/models/goal.dart';
import 'package:kpi_dash/src/models/year.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';
import 'package:kpi_dash/src/strategy_component/strategy_component.dart';
import 'package:kpi_dash/src/vu_scroll_down.dart';

@Component(
  selector: 'my-goal',
  styleUrls: const ['goal_component.css'],
  templateUrl: 'goal_component.html',
  directives: const [
    materialDirectives,
    COMMON_DIRECTIVES,
    CORE_DIRECTIVES,
    StrategyComponent,
    InitiativeComponent,
    DirectiveComponent,
    MaterialExpansionPanel,
    MaterialExpansionPanelSet,
    MaterialDropdownSelectComponent,
    MaterialSelectComponent,
  ],
  providers: const [materialProviders],
)
class GoalComponent {


  final FirebaseService fbService;
  GoalComponent(this.fbService);
  Goal selectedGoal;
  bool b = true;

  String inputNameText = "";
  String inputDescText = "";

  Year year = new Year(2015, []);

  num toNum(Year y){
    return y.year;
  }

  void pickYear(Year y) {
    year = y;
    print(year);
  }

  Year returnYear(){
    return year;
  }

  void add(Year year) {
    String goalName = inputNameText.trim();
    String goalDesc = inputDescText.trim();

    if (goalName.isEmpty || goalDesc.isEmpty) return;
    fbService.addGoal(year, goalName, goalDesc);
  }

  void delete(Year year, Goal goal) {
    fbService.deleteGoal(year.key, goal.key);
    year.goals.remove(goal);
  }

  void changeName(Year year, Goal goal) {
    fbService.changeGoalName(year, goal);
  }

  void changeDesc(Year year, Goal goal) {
    fbService.changeGoalDescription(year, goal);
  }

  void onSelect(Goal goal) {
    selectedGoal = goal;
  }
}
