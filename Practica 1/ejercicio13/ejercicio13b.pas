{
  Realizar un programa que lea 1000 números enteros desde teclado. Informar en pantalla cuáles son
  los dos números mínimos leídos.
  a.  Modifique el ejercicio anterior para que, en vez de leer 1000 números, la lectura finalice al leer
      el número 0, el cual debe procesarse.
  b.  Modifique el ejercicio anterior para que, en vez de leer 1000 números, la lectura finalice al leer
      el número 0, el cual no debe procesarse
}
program ejercicio13b;
var
  num, min1, min2: integer;
begin
  min1 := 32767; min2 := 32767;
  read(num);
  while(num <> 0) do begin
    if (num < min1) then begin
      min2 := min1;
      min1 := num;
    end
    else
    if (num < min2) then
      min2 := num;
    read(num);
  end;
  if (min1 <> 32767) and (min2 <> 32767) then 
    write('Los dos numero mas pequenos: ', min1, ' y ', min2);
end.