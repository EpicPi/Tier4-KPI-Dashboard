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
    DirectiveComponent,
    MaterialExpansionPanel,
    MaterialExpansionPanelSet,
    AutoDismissDirective,
    AutoFocusDirective,
    ModalComponent,
  ],
  providers: const [
    materialProviders,
  ],
)
class StrategyComponent {
  @Input()
  Year year;

  @Input()
  Goal goal;

  final FirebaseService fbService2;
  StrategyComponent(this.fbService2);

  bool saveDialog = false;
  bool preventAdditional = false;
  String message;

  void add(Year year, Goal goal, String name, String description) {
    if (name.isEmpty||description.isEmpty) return;
    fbService2.addStrat(year, goal, name, description);
    saveDialog = !preventAdditional;
    message = "Strategy Added";
  }

  void delete(Year year, Goal goal, Strategy strat) {
    fbService2.deleteStrategy(year.key, goal.key, strat.key);
    goal.strategies.remove(strat);
    saveDialog = !preventAdditional;
    message = "Strategy Deleted";
  }

  void update(Year year, Goal goal,Strategy strat)
  {
    fbService2.changeStratName(year, goal, strat);
    fbService2.changeStratDescription(year, goal, strat);
    saveDialog = !preventAdditional;
    message = "Edit Saved";
  }

}
