import 'dart:html';
import 'package:angular2/angular2.dart';

@Component(
    selector: "progress-bar",
    templateUrl: "bar_component.html",
    styleUrls: const ["bar_component.css"],
    directives: const [],
    providers: const [])
class Bar implements AfterContentInit, AfterViewInit {
  @Input()
  num value = 0;
  @Input()
  num maxValue = 0;

  @ViewChild('theCanvas')
  ElementRef canvas;
  CanvasElement canvasElement;

  void draw() {}

  @override
  ngAfterContentInit() {
    draw();
  }
  @override
  ngAfterViewInit() {
    canvasElement = canvas.nativeElement;
  }
}
