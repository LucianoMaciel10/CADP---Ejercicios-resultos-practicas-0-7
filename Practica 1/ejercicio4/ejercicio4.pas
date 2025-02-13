{
  Realizar un programa que lea un número real X. Luego, deberá leer números reales hasta que se
  ingrese uno cuyo valor sea exactamente el doble de X (el primer número leído)
}
program ejercicio4;
var
  x, y: real;
begin
  write('Ingrese valor base: ');readln(x);
  write('Ingrese otro valor: ');readln(y);
  while (x*2 <> y) do begin
    write('Ingrese otro valor: ');readln(y);
  end;
end.