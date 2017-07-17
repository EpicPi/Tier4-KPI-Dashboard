// Copyright (c) 2017, Piyush. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

import 'package:kpi_dash/src/detail_component/detail_component.dart';
import 'package:kpi_dash/src/goal_component/goal_component.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';
import 'package:kpi_dash/src/summary_component/summary_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives, DetailComponent, GoalComponent],
  providers: const [materialProviders,FirebaseService],
)
class AppComponent{
  var goals;
  final FirebaseService fbService;
  AppComponent(this.fbService);


  String title = "Summary";
}
