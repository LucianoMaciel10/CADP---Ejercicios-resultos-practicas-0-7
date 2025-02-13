{
  Realizar un programa que lea 2 números enteros desde teclado e informe en pantalla cuál de los
  dos números es el mayor. Si son iguales debe informar en pantalla lo siguiente: “Los números leídos
  son iguales”
}
program ejercicio1;
var
  num1, num2: integer;
begin
  read(num1);
  read(num2);
  if (num1 > num2) then
    write('Numero ', num1, ' es mayor que ', num2)
  else 
  if (num2 > num1) then 
    write('Numero ', num2, ' es mayor que ', num1)
  else
    write('Numero ', num1, ' y ', num2, ' son iguales');
end.