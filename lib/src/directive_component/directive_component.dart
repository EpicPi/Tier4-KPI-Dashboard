import 'dart:core';

import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
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

  bool saveDialog = false;
  String message;

  final FirebaseService fbService;

  DirectiveComponent(this.fbService);

  void add(String name, String desc, String m) {
    num max = int.parse(m);
    if (name.isEmpty || desc.isEmpty || max == null || max <= 0) return;
    fbService.addDir(year, goal, strat, init, name, desc, max);

    saveDialog = !fbService.preventAdditional;
    message = "Directive Added";
  }

  void delete(Dir dir) {
    fbService.deleteDir(year.key, goal.key, strat.key, init.key, dir.key);
    init.directives.remove(dir);

    saveDialog = !fbService.preventAdditional;
    message = "Directive Deleted";
  }

  void update(Dir dir, String maxValue) {
    num max = int.parse(maxValue);

    fbService.changeDirName(year, goal, strat, init, dir);
    fbService.changeDirDescription(year, goal, strat, init, dir);
    fbService.changeDirMax(year, goal, strat, init, dir, max);

    saveDialog = !fbService.preventAdditional;
    message = "Edit Saved";
  }
}
