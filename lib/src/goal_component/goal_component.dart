import 'package:angular2/core.dart';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
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
    ])
class GoalComponent {
  final FirebaseService fbService;
  GoalComponent(this.fbService);

  bool saveDialog = false;
  bool preventAdditional = false;
  String message;

  bool showPrevent = true;

  bool admin = false;
  @Input()
  Year year;

  void add(Year year, String name, String desc) {
    if (name.isEmpty || desc.isEmpty) return;
    fbService.addGoal(year, name, desc);
    saveDialog = !fbService.preventAdditional;
    message = "Goal Added";
    showPrevent = true;
  }

  void delete(Year year, Goal goal) {
    fbService.deleteGoal(year.key, goal.key);
    year.goals.remove(goal);
    saveDialog = !fbService.preventAdditional;
    message = "Goal Deleted";
    showPrevent = true;
  }

  void updateGoal(Year year, Goal goal) {
    fbService.changeGoalDescription(year, goal, goal.description);
    fbService.changeGoalName(year, goal, goal.name);
    message = "Edit Saved";
    saveDialog = !fbService.preventAdditional;
    showPrevent = true;
  }

  void setPassword(String s, String s2) {
    saveDialog = true;
    showPrevent = false;
    if (s == s2 && !s.trim().isEmpty) {
      message = "Password Saved";
      fbService.changePass(s);
    } else {
      message = "No Match!";
    }
  }

  void setAdminPass(String s, String s2) {
    saveDialog = true;
    if (s == s2 && !s.trim().isEmpty) {
      message = "Admin Password Saved";
      fbService.changeKey(s);
    } else {
      message = "No Match!";
    }
  }

  void checkPass(String pass) {
    if (pass == fbService.key)
      admin = true;
    else {
      message = "Incorrect Password";
      saveDialog = true;
    }
  }
}
