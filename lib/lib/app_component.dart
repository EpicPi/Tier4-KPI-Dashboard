// Copyright (c) 2017, pranav.khorana. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:kpi_dashboard_attempt_7/src/directive_component/directive_component.dart';
import 'package:kpi_dashboard_attempt_7/src/goal_component/goal_component.dart';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dashboard_attempt_7/src/initiative_component/initiative_component.dart';
import 'package:kpi_dashboard_attempt_7/src/strategy_component/strategy_component.dart';


// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives, COMMON_DIRECTIVES, CORE_DIRECTIVES, GoalComponent, StrategyComponent, InitiativeComponent,
  DirectiveComponent],
  providers: const [materialProviders],
)
class AppComponent{


  AppComponent();


  String title = "Summary";
}

