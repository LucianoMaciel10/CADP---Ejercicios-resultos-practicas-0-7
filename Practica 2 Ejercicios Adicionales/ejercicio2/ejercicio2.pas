{
  Realice un programa modularizado que lea 10 pares de números (X,Y) e informe, para cada par de
  números, la suma y el producto de todos los números entre X e Y.
  Por ejemplo, dado el par (3,6), debe informar:
  “La suma es 18“ (obtenido de calcular 3+4+5+6)
  “El producto es 360“ (obtenido de calcular 3*4*5*6)
}
program ejercicio2;

function calcularSuma(x, y: integer):integer;
var
  suma, i: integer;
begin
  suma := 0;
  for i := x to y do 
    suma := suma + i;
  calcularSuma := suma;
end;

function calcularProducto(x, y: integer): longint;
var
  producto: longint; 
  i: integer;
begin
  producto := x;
  for i := x to y do begin
    if (i <> x) then
      producto := producto * i;
  end;
  calcularProducto := producto;
end;

var
  x, y: integer;
begin
  write('Ingrese el numero X: '); readln(x);
  write('Ingrese el numero Y: '); readln(y);
  writeln('La suma es: ', calcularSuma(x, y));
  writeln('El producto es: ', calcularProducto(x, y));
end.