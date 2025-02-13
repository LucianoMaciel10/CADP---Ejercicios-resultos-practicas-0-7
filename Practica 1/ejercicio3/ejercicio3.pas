{
  Realizar un programa que lea 3 números enteros y los imprima en orden descendente.
  Por ejemplo, si se ingresan los valores 4, -10 y 12, deberá imprimir:
    12 4 -10
}
program Ejercicio3;
var
  num1, num2, num3: integer;
begin
  read(num1);
  read(num2);
  read(num3);

  { Compara los números y los imprime en orden descendente }
  if (num1 >= num2) and (num1 >= num3) then
  begin
    write(num1, ' ');
    if (num2 >= num3) then
      writeln(num2, ' ', num3)
    else
      writeln(num3, ' ', num2);
  end
  else if (num2 >= num1) and (num2 >= num3) then
  begin
    write(num2, ' ');
    if (num1 >= num3) then
      writeln(num1, ' ', num3)
    else
      writeln(num3, ' ', num1);
  end
  else
  begin
    write(num3, ' ');
    if (num1 >= num2) then
      writeln(num1, ' ', num2)
    else
      writeln(num2, ' ', num1);
  end;
end.
