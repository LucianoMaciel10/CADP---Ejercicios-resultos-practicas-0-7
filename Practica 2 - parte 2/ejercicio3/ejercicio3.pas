{
  Encontrar los 6 errores que existen en el siguiente programa. Utilizar los comentarios entre llaves como guía,
  indicar en qué línea se encuentra cada error y en qué consiste:
}
program ejercicio5;
{ suma los números entre a y b, y retorna el resultado en c }
procedure sumar(a, b, c : integer) { falta var en el parametro c }
var
  suma : integer;
begin
  for i := a to b do { no existe la variable 'i' }
    suma := suma + i; { Suma no esta inicialziada }
  c := c + suma;
end;

var
  result : integer;
begin
  result := 0;
  readln(a); readln(b); { no existen las variables 'a' y 'b' }
  sumar(a, b, 0); { el llamado a el modulo con estos parametros da erro ya que no existen las variables, y 0 no puede ser el parametro que va a guardar el valor, deberia ser result }
  write('La suma total es ',result); { la variable result no fue modificada por lo que siempre da 0 }
  { averigua si el resultado final estuvo entre 10 y 30}
  ok := (result >= 10) or (result <= 30); { al usar un or, si el numero es mas grande que 10 ya devulve true, por mas que no sea menor que 30 }
  if (not ok) then
    write ('La suma no quedó entre 10 y 30');
end.