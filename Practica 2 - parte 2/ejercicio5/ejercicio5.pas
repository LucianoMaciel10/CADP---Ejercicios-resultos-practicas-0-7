{
  a.  Realizar un módulo que reciba un par de números (numA,numB) y retorne si numB es el doble de numA.
  b.  Utilizando el módulo realizado en el inciso a., realizar un programa que lea secuencias de pares de
      números hasta encontrar el par (0,0), e informe la cantidad total de pares de números leídos y la cantidad de
      pares en las que numB es el doble de numA.
      Ejemplo: si se lee la siguiente secuencia: (1,2) (3,4) (9,3) (7,14) (0,0) el programa debe informar los valores
      4 (cantidad de pares leídos) y 2 (cantidad de pares en los que numB es el doble de numA).
}
program ejercicio5;

function esElDoble(numA, numB: integer): boolean;
begin
  esElDoble := numA*2 = numB;
end;

var
  numA, numB, totalPares, totalDobles: integer;
begin
  totalPares := 0; totalDobles := 0;
  write('Ingrese numero a: ');readln(numA);
  write('Ingrese numero b: ');readln(numB);
  while (numA <> 0) and (numB <> 0) do begin
    totalPares := totalPares + 1;
    if (esElDoble(numA, numB)) then
      totalDobles := totalDobles + 1;
    write('Ingrese numero a: ');readln(numA);
    write('Ingrese numero b: ');readln(numB);
  end;
  writeln('El total de pares leidos es: ', totalPares);
  writeln('El total de pares leidos en el que B es el doble de A es: ', totalDobles);
end.