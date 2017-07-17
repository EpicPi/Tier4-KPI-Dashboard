import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'package:kpi_dash/src/services/firebase_service.dart';

@Component(
  selector: 'detail',
  templateUrl: 'detail_component.html',
  styleUrls: const['detail_component.css'],
  directives: const[
    materialDirectives,
    MaterialExpansionPanel,
    MaterialExpansionPanelSet,
    NgFor],
  providers: const[materialProviders]
)
class DetailComponent implements OnInit{
  var goals;
  final FirebaseService fbService;
  DetailComponent(this.fbService);
  @override
  ngOnInit() {
  }

}