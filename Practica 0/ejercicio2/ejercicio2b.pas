{
  Modifique el programa anterior para que el mensaje de salida muestre la suma de ambos
  números:
    a. Utilizando una variable adicional
    b. Sin utilizar una variable adicional
}
program ejercicio2b;
var
  num1, num2: integer;
begin
  read(num1);
  read(num2);
  writeln('Suma: ', num1 +  num2)
end.