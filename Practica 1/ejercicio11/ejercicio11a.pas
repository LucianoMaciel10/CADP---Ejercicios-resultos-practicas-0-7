{
  Modifique el programa anterior para que, además de informar el mayor número leído, se
  informe el número de orden, dentro de la secuencia, en el que fue leído. Por ejemplo, si se lee la
  misma secuencia:
  3 5 6 2 3 10 98 8 -12 9
  deberá informar: “El mayor número leído fue el 98, en la posición 7”
}
program ejercicio11a;
var
  num, max, i, maxPos: integer;
begin
  max := 0;
  for i := 1 to 10 do begin
    read(num);
    if (num > max) then begin
      max := num;
      maxPos:= i;
    end;
  end;
  write('El mayor numero leido fue el ',max,' en la posicion ', maxPos);
end.