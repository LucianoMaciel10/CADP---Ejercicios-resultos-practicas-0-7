{
  Utilizando los módulos implementados en el ejercicio 4, realizar un programa que lea números enteros
  desde teclado (a lo sumo 100) y los almacene en un vector. La carga finaliza al leer el número 0. Al finalizar
  la carga, se debe intercambiar la posición del mayor elemento por la del menor elemento, e informe la
  operación realizada de la siguiente manera: “El elemento máximo ... que se encontraba en la posición ...
  fue intercambiado con el elemento mínimo ... que se encontraba en la posición ...”.
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

function posicion(v: numerosV; dimL, num: integer): integer;
var
  pos: integer;
begin
  pos := 1;
  while (pos <= dimL) and (v[pos] <> num) do
    pos := pos + 1;
  if (pos <= dimL) and (v[pos] = num) then
    posicion := pos
  else
    posicion := -1;
end;

procedure intercambio(var v: numerosV; x, y: integer);
var
  aux: integer;
begin
  aux := v[x];
  v[x] := v[y];
  v[y] := aux;
end;

function elementoMinimo(v: numerosV; dimL: integer): integer;
var
  min, i: integer;
begin
  min := 32767;
  for i := 1 to dimL do 
    if (v[i] < min) then
      min := v[i];
  elementoMinimo := min;
end;

function elementoMaximo(v: numerosV; dimL: integer): integer;
var
  max, i: integer;
begin
  max := -1;
  for i := 1 to dimL do
    if (v[i] > max) then
      max := v[i];
  elementoMaximo := max;
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
  max := elementoMaximo(v, dimL);
  min := elementoMinimo(v, dimL);
  posMax := posicion(v, dimL, max);
  posMin := posicion(v, dimL, min);
  intercambio(v, posMax, posMin);
  writeln('El elemento maximo ', max ,' que se encontraba en la posicion ', posMax ,' fue intercambiado con el elemento minimo ', min ,' que se encontraba en la posicion ', posMin);
  imprimirVector(v, dimL);
end.