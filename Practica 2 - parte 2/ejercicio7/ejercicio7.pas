{
  a. Realizar un módulo que reciba como parámetro un número entero y retorne la cantidad de dígitos que
  posee y la suma de los mismos.
  b. Utilizando el módulo anterior, realizar un programa que lea una secuencia de números e   imprima la
  cantidad total de dígitos leídos. La lectura finaliza al leer un número cuyos dígitos suman exactamente 10, el
  cual debe procesarse.
}
program ejercicio7;

procedure descomposicion(num: longint;var cantDig, sumaDig: integer);
var
  dig: integer;
begin
  while (num <> 0) do begin
    dig := num MOD 10;
    cantDig := cantDig + 1;
    sumaDig := sumaDig + dig;
    num := num DIV 10;
  end;
end;

var
  cantDig, sumaDig: integer;
  num: longint;
begin
  repeat
    cantDig := 0; sumaDig := 0;
    write('Ingrese un numero: ');readln(num);
    descomposicion(num, cantDig, sumaDig);
    writeln('Cantidad de digitos que tiene el numero: ', cantDig);
    writeln('Resultado de sumar todos sus digitos: ', sumaDig);
  until (sumaDig = 10);
end.