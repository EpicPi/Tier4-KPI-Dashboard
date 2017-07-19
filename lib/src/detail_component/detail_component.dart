import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
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
      MaterialExpansionPanel,
      MaterialExpansionPanelSet,
      MaterialDropdownSelectComponent,
      MaterialSelectComponent,
      NgFor
    ],
    providers: const [
      materialProviders
    ])
class DetailComponent implements OnInit {
  Year year = null;
//      new Year(2015, []);

  num toNum(Year y){
    if (y==null) return null;
    return y.year;
  }

  void pickYear(Year y) {
    year = y;
    print(year);
  }

  Year returnYear(){
    return year;
  }
  var goals;
  final FirebaseService fbService;
  DetailComponent(this.fbService);
  @override
  ngOnInit() {}
}
