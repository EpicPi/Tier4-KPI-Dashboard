import 'package:angular2/core.dart';

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/src/directive_component/directive_component.dart';
import 'package:kpi_dash/src/initiative_component/initiative_component.dart';
import 'package:kpi_dash/src/models/goal.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';
import 'package:kpi_dash/src/strategy_component/strategy_component.dart';
import 'package:kpi_dash/src/val_component/val_component.dart';
import 'package:kpi_dash/src/vu_scroll_down.dart';



@Component(
  selector: 'my-goal',
  styleUrls: const ['goal_component.css'],
  templateUrl: 'goal_component.html',
  directives: const [materialDirectives, COMMON_DIRECTIVES, CORE_DIRECTIVES, StrategyComponent, InitiativeComponent,
  DirectiveComponent, VuScrollDown],
  providers: const [materialProviders],

)

class GoalComponent{
//  @Input()
//  Goal goal;
//  @Input()
//  var goals = goal_list;

  final FirebaseService fbService;
  GoalComponent(this.fbService);
  Goal selectedGoal;
  bool b= true;


String inputNameText = "";
String inputDescText= "";

void add() {
  String goalName = inputNameText.trim();
  String goalDesc = inputDescText.trim();

  if (goalName.isEmpty || goalDesc.isEmpty) return;
  fbService.addGoal(goalName, goalDesc);
}

void delete(Goal goal){
  fbService.deleteGoal(goal.key);
  fbService.goals.remove(goal);
}

void changeName(Goal goal){
  fbService.changeGoalName(goal);
}

void changeDesc(Goal goal){
  fbService.changeGoalDescription(goal);
}

  void onSelect(Goal goal){
    selectedGoal = goal;
  }




}



