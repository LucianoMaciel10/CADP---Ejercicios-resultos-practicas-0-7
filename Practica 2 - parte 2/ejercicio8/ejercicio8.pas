{
  Realizar un programa modularizado que lea secuencia de números enteros. La lectura finaliza cuando llega
  el número 123456, el cual no debe procesarse. Informar en pantalla para cada número la suma de sus dígitos
  pares y la cantidad de dígitos impares que posee.
}
program ejercicio8;

procedure descomposicion(num: longint;var cantImpar, sumaPares: integer);
var
  dig: integer;
begin
  while (num <> 0) do begin
    dig := num MOD 10;
    if (dig MOD 2 = 0) then
      sumaPares := sumaPares + dig
    else
      cantImpar := cantImpar + 1;
    num := num DIV 10;
  end;
end;

var
  num: longint;
  cantImpar, sumaPares: integer;
begin
  write('Ingrese un numero: ');readln(num);
  while (num <> 123456) do begin
    cantImpar := 0; sumaPares := 0;
    descomposicion(num, cantImpar, sumaPares);
    writeln('Suma total de sus digitos pares: ', sumaPares);
    writeln('Total de digitos impares: ', cantImpar);
    write('Ingrese un numero: ');readln(num);
  end;
end.