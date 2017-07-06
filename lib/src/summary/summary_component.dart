import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'summary',
  styleUrls: const ['summary_component.css'],
  templateUrl: 'summary_component.html',
  directives: const [
    materialDirectives,
    MaterialDropdownSelectComponent,
  ],
  providers: const [materialProviders],
)
class SummaryComponent {}
