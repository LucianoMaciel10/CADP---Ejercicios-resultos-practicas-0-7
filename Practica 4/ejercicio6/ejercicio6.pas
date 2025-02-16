{
  Dado que en la solución anterior se recorre dos veces el vector (una para calcular el elemento máximo y
  otra para el mínimo), implementar un único módulo que recorra una única vez el vector y devuelva ambas
  posiciones.
}
program ejercicio5;
const
  dimF = 10;
  
type
  numerosV = array[1..dimF] of integer;

procedure imprimirVector(v: numerosV; dimL: integer);
var
  i: integer;
begin
  for i := 1 to dimL do
    write(v[i],' ');
  writeln();
end;

procedure intercambio(var v: numerosV; x, y: integer);
var
  aux: integer;
begin
  aux := v[x];
  v[x] := v[y];
  v[y] := aux;
end;

procedure elementoMinimoYmaximo(v: numerosV; dimL: integer; var min, max, posMax, posMin: integer);
var
  i: integer;
begin
  min := 32767; max := -1;
  for i := 1 to dimL do begin
    if (v[i] < min) then begin
      min := v[i];
      posMin := i;
    end;
    if (v[i] > max) then begin
      max := v[i];
      posMax := i;
    end;
  end;
end;

procedure cargarVector(var v: numerosV;var dimL: integer);
var
  num: integer;
begin
  write('Ingrese un numero: ');readln(num);
  while (dimL < dimF) and (num <> 0) do begin
    dimL := dimL + 1;
    v[dimL] := num;
    if (dimL < dimF) then begin
      write('Ingrese un numero: ');readln(num);
    end;
  end;
end;
  
var
  v: numerosV;
  dimL, max, min, posMax, posMin: integer;
begin
  cargarVector(v, dimL);
  imprimirVector(v, dimL);
  elementoMinimoYmaximo(v, dimL, min, max, posMax, posMin);
  intercambio(v, posMax, posMin);
  writeln('El elemento maximo ', max ,' que se encontraba en la posicion ', posMax ,' fue intercambiado con el elemento minimo ', min ,' que se encontraba en la posicion ', posMin);
  imprimirVector(v, dimL);
end.