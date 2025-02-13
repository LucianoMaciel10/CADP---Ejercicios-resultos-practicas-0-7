{
  Realizar un programa que lea 10 números enteros e informe la suma total de los números leídos.
  a. Modifique el ejercicio 1 para que además informe la cantidad de números mayores a 5
}
program ejercicio10;
var
  num, total, cantSup5, i: integer;
begin
  total := 0;
  cantSup5 := 0;
  for i := 1 to 10 do begin
    read(num);
    if (num > 5) then
      cantSup5 := cantSup5 + 1;
    total := total + num;
  end;
  writeln('Suma total: ', total);
  writeln('Cantidad de numeros mayores a 5: ', cantSup5);
end.