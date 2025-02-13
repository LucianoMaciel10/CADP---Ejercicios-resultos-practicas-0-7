{
  Modifique el programa anterior para que el mensaje de salida muestre la suma de ambos
  números:
    a. Utilizando una variable adicional
    b. Sin utilizar una variable adicional
}
program ejercicio2a;
var
  num1, num2, total: integer;
begin
  read(num1);
  read(num2);
  total := num1 + num2;
  writeln('Suma: ', total);
end.  