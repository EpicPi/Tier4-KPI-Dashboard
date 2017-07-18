import 'package:angular2/core.dart';
import 'dart:core';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/src/models/models.dart';
import 'package:kpi_dash/src/models/year.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';

@Component(
  selector: 'my-dir',
  styleUrls: const ['directive_component.css'],
  templateUrl: 'directive_component.html',
  directives: const [
    materialDirectives,
    COMMON_DIRECTIVES,
    CORE_DIRECTIVES,
    MaterialExpansionPanel,
    MaterialExpansionPanelSet
  ],
  providers: const [materialProviders],
)
class DirectiveComponent {
  @Input()
  Year year;

  @Input()
  Goal goal;

  @Input()
  Strategy strat;

  @Input()
  Initiative init;
  //

  final FirebaseService fbService4;
  DirectiveComponent(this.fbService4);
  Dir selectedDir;

  String inputTextName = "";
  String inputTextDescription = "";
  num inputMax = null;

  void add4(Year year, Goal goal, Strategy strat, Initiative init) {
    String name2Text = inputTextName.trim();
    String desc2Text = inputTextDescription.trim();
    num max = inputMax;

    if (name2Text.isEmpty) return;
    if (desc2Text.isEmpty) return;
    if (max == null) return;

    fbService4.addDir(year, goal, strat, init, name2Text, desc2Text, max);
  }

  void delete4(Goal goal, Strategy strat, Initiative init, Dir dir) {
    fbService4.deleteDir(year.key, goal.key, strat.key, init.key, dir.key);
    init.directives.remove(dir);
  }

  void change4Name(Year year, Goal goal, Strategy strat, Initiative init, Dir dir) {
    fbService4.changeDirName(year, goal, strat, init, dir);
  }

  void change4Desc(Year year, Goal goal, Strategy strat, Initiative init, Dir dir) {
    fbService4.changeDirDescription(year, goal, strat, init, dir);
  }

  void changeMax(Year year, Goal goal, Strategy strat, Initiative init, Dir dir) {
    fbService4.changeDirMax(year, goal, strat, init, dir);
  }

  void onSelect(Dir dir) {
    selectedDir = dir;
  }
}
