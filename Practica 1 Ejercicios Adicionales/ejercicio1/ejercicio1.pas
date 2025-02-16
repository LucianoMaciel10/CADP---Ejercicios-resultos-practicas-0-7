{
  Realizar un programa que analice las inversiones de las empresas más grandes del país. Para cada
  empresa se lee su código (un número entero), la cantidad de inversiones que tiene, y el monto
  dedicado a cada una de las inversiones. La lectura finaliza al ingresar la empresa con código 100,
  que debe procesarse.
  El programa deberá informar:
  ● Para cada empresa, el monto promedio de sus inversiones
  ● Código de la empresa con mayor monto total invertido
  ● Cantidad de empresas con inversiones de más de $50000
}
program ejercicio1;

var
  cod, codMax, cantInver, cantEmpInverSup50, i: integer;
  monto, prom, totalMax, totalInver: real;
  cumplio: boolean;
begin
  cantEmpInverSup50 := 0; totalMax := -1;
  repeat
    cumplio := false;
    totalInver := 0;
    write('Ingrese un codigo de empresa: ');readln(cod);
    write('Ingrese la cant. de inversiones: ');readln(cantInver);
    writeln('Ingrese el monto de cada inversion: ');
    for i := 1 to cantInver do begin
      readln(monto);
      totalInver := totalInver + monto;
      if (monto > 50000) and not (cumplio) then begin
        cumplio := true;
        cantEmpInverSup50 := cantEmpInverSup50 + 1;
      end;  
    end;
    if (totalInver > totalMax) then begin
      totalMax := totalInver;
      codMax := cod;
    end;
    prom := totalInver / cantInver;
    writeln();
    writeln('Resultado del analisis: Empresa ', cod , ' Monto promedio: ', prom:0:2);
    writeln();
  until (cod = 100);
  writeln('La empresa ', codMax ,' es la que mayor dinero posee invertido ($', totalMax:0:2 ,').');
  writeln('Hay ', cantEmpInverSup50 ,' empresas con inversiones por mas de $50000');
end.