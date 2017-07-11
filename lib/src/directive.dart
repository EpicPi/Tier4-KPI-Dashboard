class Directive{
  String name;
  String detail;
  num value;
  num maxValue;
  Directive(this.name, this.detail);

  num get percentage => value/maxValue*100 ?? 0;
}