{
  Realizar un programa que lea 1000 números enteros desde teclado. Informar en pantalla cuáles son
  los dos números mínimos leídos.
  a.  Modifique el ejercicio anterior para que, en vez de leer 1000 números, la lectura finalice al leer
      el número 0, el cual debe procesarse.
  b.  Modifique el ejercicio anterior para que, en vez de leer 1000 números, la lectura finalice al leer
      el número 0, el cual no debe procesarse
}
program ejercicio13;
var
  num, min1, min2, i: integer;
begin
  min1 := 32767; min2 := 32767;
  for i := 1 to 1000 do begin
    read(num);
    if (num < min1) then begin
      min2 := min1;
      min1 := num;
    end
    else
    if (num < min2) then
      min2 := num;
  end;
  write('Los dos numero mas pequenos: ', min1, ' y ', min2);
end.