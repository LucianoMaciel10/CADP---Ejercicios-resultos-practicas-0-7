{
  El registro civil de La Plata ha solicitado un programa para analizar la distribución de casamientos durante el año
  2019. Para ello, cuenta con información de las fechas de todos los casamientos realizados durante ese año.
  a)  Analizar y definir un tipo de dato adecuado para almacenar la información de la fecha de cada casamiento.
  b)  Implementar un módulo que lea una fecha desde teclado y la retorne en un parámetro cuyo tipo es el definido
      en el inciso a).
  c)  Implementar un programa que lea la fecha de todos los casamientos realizados en 2019. La lectura finaliza al
      ingresar el año 2020, que no debe procesarse, e informe la cantidad de casamientos realizados durante los
      meses de verano (enero, febrero y marzo) y la cantidad de casamientos realizados en los primeros 10 días de
      cada mes. Nota: utilizar el módulo realizado en b) para la lectura de fecha.
}
program ejercicio2;
type
casamiento = record
  dia, mes, ano: integer;
end;

procedure leerCasamiento(var cas: casamiento);
begin
  write('Ingrese ano: ');readln(cas.ano);
  if (cas.ano = 2019) then begin
    write('Ingrese dia: ');readln(cas.dia);
    write('Ingrese mes: ');readln(cas.mes);
    writeln();
  end;
end;

var
  cas: casamiento;
  cantCasVer, cantCasPri10Dias: integer;
begin
  cantCasPri10Dias := 0; cantCasVer := 0;
  leerCasamiento(cas); 
  while (cas.ano = 2019) do begin
    if (cas.dia <= 10) then
      cantCasPri10Dias := cantCasPri10Dias + 1;
    if (cas.mes = 1) or (cas.mes = 2) or (cas.mes = 3) then
      cantCasVer := cantCasVer + 1;
    leerCasamiento(cas);
  end;
  writeln('Cantidad de casamientos hechos en verano: ', cantCasVer);
  writeln('Cantidad de casamientos hechos en los primeros 10 dias de cualquier mes: ', cantCasPri10Dias);
end.