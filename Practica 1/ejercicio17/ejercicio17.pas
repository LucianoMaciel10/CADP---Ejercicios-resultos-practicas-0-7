{
  Un local de ropa desea analizar las ventas realizadas en el último mes. Para ello se lee por cada día
  del mes, los montos de las ventas realizadas. La lectura de montos para cada día finaliza cuando se
  lee el monto 0. Se asume un mes de 31 días. Informar la cantidad de ventas por cada día, y el monto
  total acumulado en ventas de todo el mes.
  a)  Modifique el ejercicio anterior para que además informe el día en el que se realizó la
      mayor cantidad de ventas.
}
program ejercicio17;
var
  monto, totalMes, totalDia : real; 
  i :integer;
begin
  totalMes := 0; 
  for i := 1 to 31 do begin
    totalDia := 0;
    writeln('-----------------------');
    writeln('-------- Dia ', i , ' --------');
    writeln('-----------------------');
    write('Ingrese un monto: ');readln(monto);
    while (monto <> 0) do begin
      totalDia := totalDia + monto;
      write('Ingrese un monto: ');readln(monto);
    end;
    writeln('-----------------------------');
    writeln('Monto total de las ventas el dia ', i, ': ', totalDia:0:2);
    writeln('-----------------------------');
    writeln('');
    totalMes := totalMes + totalDia;
  end;
  writeln('Monto total de ventas en el mes: ', totalMes:0:2);
end.