{
  Realizar un programa que lea números enteros desde teclado. La lectura debe finalizar cuando se
  ingrese el número 100, el cual debe procesarse. Informar en pantalla:
  ◦ El número máximo leído.
  ◦ El número mínimo leído.
  ◦ La suma total de los números leídos.
}
program ejercicio14;
var
  num, max, min, total: integer;
begin
  max := -1; min := 32767; total := 0;
  repeat
    read(num);
    if (num > max) then
      max := num;
    if (num < min) then
      min := num;
    total := total + num;
  until (num = 100);
  writeln('Numero mas chico: ', min);
  writeln('Numero mas grande: ', max);
  writeln('Suma total: ', total);
end.