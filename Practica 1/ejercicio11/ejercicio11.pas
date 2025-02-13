{
  Realice un programa que lea 10 números e informe cuál fue el mayor número leído. Por ejemplo, si
  se lee la secuencia:
  3 5 6 2 3 10 98 8 -12 9
  deberá informar: “El mayor número leído fue el 98”  
}
program ejercicio11;
var
  num, max, i: integer;
begin
  max := 0;
  for i := 1 to 10 do begin
    read(num);
    if (num > max) then
      max := num;
  end;
  write('El mayor numero leido fue el ',max);
end.