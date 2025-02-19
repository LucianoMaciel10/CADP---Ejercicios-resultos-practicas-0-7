{
  Realizar un programa que ocupe 50 KB de memoria en total. Para ello:
  a) El programa debe utilizar sólo memoria estática
  b) El programa debe utilizar el 50% de memoria estática y el 50% de memoria dinámica
  c) El programa debe minimizar tanto como sea posible el uso de la memoria estática (a lo sumo, 4
  bytes)
}
program ejercicio6;
var
  vector: array[1..1024] of string[49];
begin
  writeln(sizeof(vector) DIV 1024,' kilobytes / memoria estatica');
end.