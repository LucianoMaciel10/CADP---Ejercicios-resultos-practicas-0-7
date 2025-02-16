{
  Se dispone de un vector con números enteros, de dimensión física dimF y dimensión lógica dimL.
  a)  Realizar un módulo que imprima el vector desde la primera posición hasta la última.
  b)  Realizar un módulo que imprima el vector desde la última posición hasta la primera.
  c)  Realizar un módulo que imprima el vector desde la mitad (dimL DIV 2) hacia la primera posición, y
      desde la mitad más uno hacia la última posición.
  d)  Realizar un módulo que reciba el vector, una posición X y otra posición Y, e imprima el vector desde la
      posición X hasta la Y. Asuma que tanto X como Y son menores o igual a la dimensión lógica. Y considere
      que, dependiendo de los valores de X e Y, podría ser necesario recorrer hacia adelante o hacia atrás.
  e)  Utilizando el módulo implementado en el inciso anterior, vuelva a realizar los incisos a, b y c.
}
program ejercicio3;
const
  dimF = 10;

type
  numerosV = array[1..dimF] of integer;

procedure imprimirVectorSegunXeY(v: numerosV; x, y: integer);
var
  i: integer;
begin
  if (x < y) then 
    for i := x to y do
      write(v[i],' ')
  else
    for i := x downto y do
      write(v[i],' ');
end;

procedure cargarVector(var v: numerosV;var dimL: integer);
var
  num: integer;
begin
  write('Ingrese un valor: ');readln(num);
  while (dimL < dimF) and (num <> 0) do begin
    dimL := dimL + 1;
    v[dimL] := num;
    if (dimL < dimF) then begin
      write('Ingrese un valor: ');readln(num);
    end;
  end;
end;

procedure imprimirVector(v: numerosV; dimL: integer);
begin
  writeln('Imprimir vector normal');
  imprimirVectorSegunXeY(v, 1, dimL);
  writeln();
end;

procedure imprimirVectorAlrevez(v: numerosV; dimL: integer);
begin
  writeln('Imprimir vector al revez');
  imprimirVectorSegunXeY(v, dimL, 1);
  writeln();
end;

procedure imprimirVectorPorPartes(v: numerosV; dimL: integer);
var
  mitad: integer;
begin
  writeln('Imprimir vector por partes');
  writeln('Primera parte');
  mitad := dimL DIV 2;
  imprimirVectorSegunXeY(v, mitad, 1);
  writeln();
  writeln('Segunda parte');
  mitad := (dimL DIV 2) + 1;
  imprimirVectorSegunXeY(v, mitad, dimL);
  writeln();
end;

var
  dimL, x, y: integer;
  v: numerosV;
begin
  dimL := 0;
  cargarVector(v, dimL);
  imprimirVector(v, dimL);
  imprimirVectorAlrevez(v, dimL);
  imprimirVectorPorPartes(v, dimL);
  write('Ingrese posicion X: ');readln(x);
  write('Ingrese posicion Y: ');readln(y);
  imprimirVectorSegunXeY(v, x, y);
end.