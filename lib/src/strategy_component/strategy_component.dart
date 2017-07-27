import 'package:kpi_dash/src/directive_component/directive_component.dart';
import 'package:kpi_dash/src/initiative_component/initiative_component.dart';
import 'package:kpi_dash/src/models/goal.dart';
import 'package:kpi_dash/src/models/strategy.dart';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/src/models/year.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';

@Component(
    selector: 'my-strategy',
    styleUrls: const ['strategy_component.css'],
    templateUrl: 'strategy_component.html',
    directives: const [
      materialDirectives,
      COMMON_DIRECTIVES,
      CORE_DIRECTIVES,
      InitiativeComponent,
    ])
class StrategyComponent {
  @Input()
  Year year;

  @Input()
  Goal goal;

  final FirebaseService fbService;
  StrategyComponent(this.fbService);

  bool saveDialog = false;
  String message;

  void add(String name, String description) {
    if (name.isEmpty || description.isEmpty) return;
    fbService.addStrat(year, goal, name, description);

    saveDialog = !fbService.preventAdditional;
    message = "Strategy Added";
  }

  void delete(Strategy strat) {
    fbService.deleteStrategy(year.key, goal.key, strat.key);
    goal.strategies.remove(strat);

    saveDialog = !fbService.preventAdditional;
    message = "Strategy Deleted";
  }

  void update(Strategy strat) {
    fbService.changeStratName(year, goal, strat);
    fbService.changeStratDescription(year, goal, strat);

    saveDialog = !fbService.preventAdditional;
    message = "Edit Saved";
  }
}
