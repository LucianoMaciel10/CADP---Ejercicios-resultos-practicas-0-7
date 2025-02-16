{
  Se dispone de un vector con 100 números enteros. Implementar los siguientes módulos:
  a)  posicion: dado un número X y el vector de números, retorna la posición del número X en dicho vector,
      o el valor -1 en caso de no encontrarse.
  b)  intercambio: recibe dos valores x e y (entre 1 y 100) y el vector de números, y retorna el mismo vector
      donde se intercambiaron los valores de las posiciones x e y.
  c)  sumaVector: retorna la suma de todos los elementos del vector.
  d)  promedio: devuelve el valor promedio de los elementos del vector.
  e)  elementoMaximo: retorna la posición del mayor elemento del vector
  f)  elementoMinimo: retorna la posicion del menor elemento del vector
}
program ejercicio4;
const
  dimF = 5;

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

function sumaVector(v: numerosV; dimL: integer): integer;
var
  suma, i: integer;
begin
  suma := 0;
  for i := 1 to dimL do 
    suma := suma + v[i];
  sumaVector := suma;
end;

function promedio(v: numerosV; dimL: integer):real;
begin
  promedio := sumaVector(v, dimL) / dimL;
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

var
  v: numerosV;
  dimL, num, pos, x, y: integer;
begin
  dimL := 0;
  cargarVector(v, dimL);
  imprimirVector(v, dimL);
  write('Ingrese un valor para buscarlo en el vector: ');readln(num);
  pos := posicion(v, dimL, num);
  if (pos <> -1) then
    writeln('La posicion en la que se encuentra el numero ', num ,' dentro del vector es: ', pos)
  else
    writeln('El numero ', num ,' no se encontro dentro del vector');
  write('Ingrese el numero X: ');readln(x);
  write('Ingrese el numero Y: ');readln(y);
  intercambio(v, x, y);
  imprimirVector(v, dimL);
  writeln('La suma de todos los valores dentro de el vector es: ', sumaVector(v, dimL));
  writeln('El promedio de todos los valores dentro de el vector es: ', promedio(v, dimL):0:2);
  writeln('El elemento maximo dentro de todos los valores de el vector es: ', elementoMaximo(v, dimL));
  writeln('El elemento minimo dentro de todos los valores de el vector es: ', elementoMinimo(v, dimL));
end.