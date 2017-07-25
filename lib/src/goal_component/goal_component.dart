import 'package:angular2/core.dart';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/src/directive_component/directive_component.dart';
import 'package:kpi_dash/src/initiative_component/initiative_component.dart';
import 'package:kpi_dash/src/models/models.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';
import 'package:kpi_dash/src/strategy_component/strategy_component.dart';

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
    MaterialListComponent,
    MaterialListItemComponent,
    AutoDismissDirective,
    AutoFocusDirective,
    MaterialButtonComponent,
    MaterialDialogComponent,
    ModalComponent,
  ],
  providers: const [materialProviders],
)
class GoalComponent {

  final FirebaseService fbService;
  GoalComponent(this.fbService);

  bool saveDialog = false;
  bool preventAdditional = false;

  String inputNameText = "";
  String inputDescText = "";

  @Input()
  Year year;


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

  void updateGoal(Year year, Goal goal)
  {
    fbService.changeGoalDescription(year, goal);
    fbService.changeGoalName(year, goal);
    saveDialog = !preventAdditional;
  }

  String password = "";

  void setPassword(String s){
    fbService.changePass(s);
  }
}
