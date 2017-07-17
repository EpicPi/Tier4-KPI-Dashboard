import 'package:angular2/core.dart';

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/src/directive_component/directive_component.dart';
import 'package:kpi_dash/src/models/goal.dart';
import 'package:kpi_dash/src/models/initiative.dart';
import 'package:kpi_dash/src/models/strategy.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';

@Component(
  selector: 'my-init',
  styleUrls: const ['initiative_component.css'],
  templateUrl: 'initiative_component.html',
  directives: const [
    materialDirectives,
    COMMON_DIRECTIVES,
    CORE_DIRECTIVES,
    MaterialExpansionPanel,
    MaterialExpansionPanelSet,
    DirectiveComponent
  ],
  providers: const [
    materialProviders,
  ],
)
class InitiativeComponent {
  @Input()
  Goal goal;

  @Input()
  Strategy strat;

  final FirebaseService fbService;
  InitiativeComponent(this.fbService);
  Initiative selectedInit;

  String inputTextName = "";
  String inputTextDesc = "";

  void add3(Goal goal, Strategy strat) {
    String nameText = inputTextName.trim();
    String descText = inputTextDesc.trim();

    if (nameText.isEmpty) return;
    fbService.addInit(goal, strat, nameText, descText);
  }

  void delete3(Goal goal, Strategy strat, Initiative init) {
    fbService.deleteInit(goal.key, strat.key, init.key);
    strat.initiatives.remove(init);
  }

  void change3Name(Goal goal, Strategy strat, Initiative init) {
    fbService.changeInitName(goal, strat, init);
  }

  void change3Desc(Goal goal, Strategy strat, Initiative init) {
    fbService.changeInitDescription(goal, strat, init);
  }

  void onSelect(Initiative init) {
    selectedInit = init;
  }
}
