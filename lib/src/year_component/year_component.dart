import 'package:angular2/core.dart';

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/src/directive_component/directive_component.dart';
import 'package:kpi_dash/src/goal_component/goal_component.dart';
import 'package:kpi_dash/src/initiative_component/initiative_component.dart';
import 'package:kpi_dash/src/models/goal.dart';
import 'package:kpi_dash/src/models/year.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';
import 'package:kpi_dash/src/strategy_component/strategy_component.dart';



@Component(
  selector: 'my-year',
  styleUrls: const ['year_component.css'],
  templateUrl: 'year_component.html',
  directives: const [GoalComponent, StrategyComponent,
  InitiativeComponent, DirectiveComponent,materialDirectives,
  COMMON_DIRECTIVES, CORE_DIRECTIVES,
  MaterialExpansionPanel, MaterialExpansionPanelSet,
  DisplayNameRendererDirective,
  MaterialCheckboxComponent,
  MaterialDropdownSelectComponent,
  MaterialSelectComponent,
  MaterialSelectItemComponent,],
  providers: const [materialProviders],
)

class YearComponent {




  final FirebaseService fbService;

  YearComponent(this.fbService);
  Year year;

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

}