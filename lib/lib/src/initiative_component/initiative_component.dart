import 'package:angular2/core.dart';

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dashboard_attempt_7/src/directive_component/directive_component.dart';
import 'package:kpi_dashboard_attempt_7/src/models/goal.dart';
import 'package:kpi_dashboard_attempt_7/src/models/initiative.dart';
import 'package:kpi_dashboard_attempt_7/src/models/strategy.dart';
import 'package:kpi_dashboard_attempt_7/src/services/firebase_service.dart';



@Component(
  selector: 'my-init',
  styleUrls: const ['initiative_component.css'],
  templateUrl: 'initiative_component.html',
  directives: const [materialDirectives, COMMON_DIRECTIVES, CORE_DIRECTIVES, MaterialExpansionPanel, MaterialExpansionPanelSet,
  DirectiveComponent],
  providers: const [materialProviders, ],
)

class InitiativeComponent{
  @Input()
  Goal goal;

  @Input()
  Strategy strat;
//  @Input()
//  Strategy strategy;
//  var strategies = [new Strategy("Untitled", "Whatever you want it to be.")];

  final FirebaseService fbService3;
  InitiativeComponent(this.fbService3);
  Initiative selectedInit;


  String inputTextName = "";
  String inputTextDesc = "";


  void add3(Goal goal, Strategy strat) {
    String nameText = inputTextName.trim();
    String descText = inputTextDesc.trim();

    if (nameText.isEmpty) return;
    fbService3.addInit(goal, strat, nameText, descText);
  }

  void delete3(Goal goal, Strategy strat, Initiative init){
    fbService3.deleteInit(goal.key, strat.key, init.key);
    strat.initiatives.remove(init);
  }

  void change3Name(Goal goal, Strategy strat, Initiative init){
    fbService3.changeInitName(goal, strat, init);
  }

  void change3Desc(Goal goal, Strategy strat, Initiative init){
    fbService3.changeInitDescription(goal, strat, init);
  }

  void onSelect(Initiative init){
    selectedInit = init;
  }


}



