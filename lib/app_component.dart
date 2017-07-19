// Copyright (c) 2017, Piyush. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular2/router.dart';
import 'package:kpi_dash/src/detail_component/detail_component.dart';
import 'package:kpi_dash/src/directive_component/directive_component.dart';
import 'package:kpi_dash/src/goal_component/goal_component.dart';
import 'package:kpi_dash/src/initiative_component/initiative_component.dart';
import 'package:kpi_dash/src/models/year.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';
import 'package:kpi_dash/src/strategy_component/strategy_component.dart';
import 'package:kpi_dash/src/summary_component/summary_component.dart';
import 'package:kpi_dash/src/val_component/val_component.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [
    materialDirectives,
    COMMON_DIRECTIVES,
    CORE_DIRECTIVES,
    DetailComponent,
    GoalComponent,
    StrategyComponent,
    InitiativeComponent,
    DirectiveComponent,
    ValComponent,
    ROUTER_DIRECTIVES,
    MaterialDropdownSelectComponent,
    MaterialSelectComponent,
    MaterialExpansionPanel,
    MaterialExpansionPanelSet,
    NgFor,
    SummaryComponent,
  ],
  providers: const [materialProviders, FirebaseService, ROUTER_PROVIDERS],
)
class AppComponent {
  Year year = null;

  void pickYear(Year y) {
    year = y;
    print(year);
  }

  final FirebaseService fbService;
  AppComponent(this.fbService);
}
