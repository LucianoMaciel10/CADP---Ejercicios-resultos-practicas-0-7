{
  Realizar un programa que ocupe 50 KB de memoria en total. Para ello:
  a) El programa debe utilizar sólo memoria estática
  b) El programa debe utilizar el 50% de memoria estática y el 50% de memoria dinámica
  c) El programa debe minimizar tanto como sea posible el uso de la memoria estática (a lo sumo, 4
  bytes)
}
program ejercicio6;
type
  vec1 = array[1..512] of string[49];
  vec2 = array[1..512] of string[48];
var
  v: vec2;
  vec3: array[1..254] of integer;
  p: ^vec1;
begin
  writeln((sizeof(v) + sizeof(vec3) + sizeof(p)) DIV 1024,' kilobytes / memoria estatica');
  new(p);
  writeln((sizeof(p^) ) DIV 1024,' kilobytes / memoria dinamica');
end.

