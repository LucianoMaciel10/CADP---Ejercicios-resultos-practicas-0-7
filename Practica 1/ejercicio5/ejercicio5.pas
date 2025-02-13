{
  Modifique el ejercicio anterior para que, luego de leer el número X, se lean a lo sumo 10 números
  reales. La lectura deberá finalizar al ingresar un valor que sea el doble de X, o al leer el décimo
  número, en cuyo caso deberá informarse “No se ha ingresado el doble de X”.
}
program ejercicio5;
const
  fin = 10;
var
  x, y: real;
  i: integer;
begin
  i := 1;
  write('Ingrese valor base: ');readln(x);
  write('Ingrese otro valor: ');readln(y);
  while (x*2 <> y) AND (i < fin) do begin
    i := i + 1;
    write('Ingrese otro valor: ');readln(y);
  end;
  if (i = fin) AND (x*2 <> y) then
    writeln('No se ha ingresado el doble de X')
end.