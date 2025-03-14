{
  Realizar un programa que lea el número de legajo y el promedio de cada alumno de la facultad. La
  lectura finaliza cuando se ingresa el legajo -1, que no debe procesarse.
  Por ejemplo, se lee la siguiente secuencia:
  33423
  8.40
  19003
  6.43
  -1
  En el ejemplo anterior, se leyó el legajo 33422, cuyo promedio fue 8.40, luego se leyó el legajo
  19003, cuyo promedio fue 6.43, y finalmente el legajo -1 (para el cual no es necesario leer un
  promedio).
  Al finalizar la lectura, informar:
  ○ La cantidad de alumnos leída (en el ejemplo anterior, se debería informar 2)
  ○ La cantidad de alumnos cuyo promedio supera 6.5 (en el ejemplo anterior, se debería informar 1)
  ○ El porcentaje de alumnos destacados (alumnos con promedio mayor a 8.5) cuyo legajo sean
    menor al valor 2500 (en el ejemplo anterior se debería informar 0%).
}
program ejercicio6;
const
  fin = -1;
var
  leg, i, promMedio, promAlto: integer; prom: real;
begin
  i := 0;
  promMedio := 0;
  promAlto := 0;
  write('Ingrese legajo del alumno: ');readln(leg);
  while(leg <> fin) do begin
    i := i + 1;
    write('Ingrese promedio del alumno: ');readln(prom);
    if (prom > 6.5) then
      promMedio := promMedio + 1;
    if (prom > 8.5) AND (leg < 2500) then
      promAlto := promAlto + 1;
    write('Ingrese legajo del alumno: ');readln(leg); 
  end;
  if (i <> 0) then begin
    writeln('Cantidad de alumnos leidos: ', i);
    writeln('Cantidad de alumnos leidos: ', i);
    writeln('Cantidad de alumnos cuyo promedio supera 6.5: ', promMedio);
    writeln('Cantidad de alumnos cuyo promedio supera 8.5 y de legajo menor a 2500: ', promAlto/i*100:0:0, '%');
  end; 
end.