{
  Responda: ¿cuánta memoria en total ocupa el programa al ejecutarse? Considere tanto variables estáticas
  como dinámicas, parámetros y variables locales de los módulos.
  a) Hasta la sentencia de la línea 18
  b) Hasta la sentencia de la línea 20
  c) Hasta la sentencia de la línea 23
  d) Hasta la sentencia de la línea 11
  e) Hasta la sentencia de la línea 25
}
program memoria;
type
  datos = array [1..20] of integer;
  punt = ^datos;

procedure procesarDatos(v : datos; var v2 : datos);
var
  i, j : integer; { 4 bytes }
begin
  for i := 1 to 20 do
    v2[21 - i] := v[i]; 
end;

var
  vect : datos; { 40 bytes }
  pvect : punt; { 4 bytes }
  i : integer; { 2 bytes }
begin
  for i:= 1 to 20 do
    vect[i] := i; { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20] }
  new(pvect); { 40 bytes de memoria dinamica }
  for i:= 20 downto 1 do
    pvect^[i] := 0; { [20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1] }
  procesarDatos(pvect^, vect);
  writeln('fin');
end.

