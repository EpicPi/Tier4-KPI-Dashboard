import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/material_progress/green_material_progress.dart';
import 'package:kpi_dash/material_progress/red_material_progress.dart';
import 'package:kpi_dash/material_progress/yellow_material_progress.dart';
import 'package:kpi_dash/src/models/models.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';

@Component(
    selector: 'detail',
    templateUrl: 'detail_component.html',
    styleUrls: const [
      'detail_component.css'
    ],
    directives: const [
      materialDirectives,
      COMMON_DIRECTIVES,
      CORE_DIRECTIVES,
      RedMaterialProgressComponent,
      GreenMaterialProgressComponent,
      YellowMaterialProgressComponent
    ])
class DetailComponent{
  @Input()
  Year year;

  final FirebaseService fbService;
  DetailComponent(this.fbService);
}