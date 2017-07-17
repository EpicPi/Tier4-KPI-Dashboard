import 'package:kpi_dash/src/directive_component/directive_component.dart';
import 'package:kpi_dash/src/initiative_component/initiative_component.dart';
import 'package:kpi_dash/src/models/goal.dart';
import 'package:kpi_dash/src/models/strategy.dart';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';


@Component(
  selector: 'my-strategy',
  styleUrls: const ['strategy_component.css'],
  templateUrl: 'strategy_component.html',
  directives: const [materialDirectives, COMMON_DIRECTIVES, CORE_DIRECTIVES, InitiativeComponent,
  DirectiveComponent, MaterialExpansionPanel, MaterialExpansionPanelSet],
  providers: const [materialProviders, ],
)

class StrategyComponent{
  @Input()
   Goal goal;

  final FirebaseService fbService2;
  StrategyComponent(this.fbService2);
  Strategy selectedStrat;



  String inputTextName = "";
  String inputTextDescription = "";

  void add2List(Goal goal){
    String stratName = inputTextName.trim();
    String stratDesc = inputTextDescription.trim();

    goal.strategies.add(new Strategy(stratName, stratDesc, []));
  }

  void add2(Goal goal) {
    String nameText = inputTextName.trim();
    String descText = inputTextDescription.trim();

    if (nameText.isEmpty) return;
    if (descText.isEmpty) return;
    fbService2.addStrat(goal, nameText, descText);
  }

  void delete2(Goal goal, Strategy strat){
    fbService2.deleteStrategy(goal.key, strat.key);
    goal.strategies.remove(strat);
  }
  void change2Name(Goal goal, Strategy strat){
    fbService2.changeStratName(goal, strat);
  }

  void change2Desc(Goal goal, Strategy strat){
    fbService2.changeStratDescription(goal, strat);
  }

  void onSelect(Strategy strat){
    selectedStrat = strat;
  }


}