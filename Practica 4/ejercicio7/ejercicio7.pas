{
  Realizar un programa que lea números enteros desde teclado hasta que se ingrese el valor -1 (que no
  debe procesarse) e informe:
  a. la cantidad de ocurrencias de cada dígito procesado.
  b. el dígito más leído.
  c. los dígitos que no tuvieron ocurrencias.
  Por ejemplo, si la secuencia que se lee es: 63 34 99 94 96 -1, el programa deberá informar:
    Número 3: 2 veces
    Número 4: 2 veces
    Número 6: 2 veces
    Número 9: 4 veces
    El dígito más leído fue el 9.
    Los dígitos que no tuvieron ocurrencias son: 0, 1, 2, 5, 7, 8
}
program ejercicio7;
type
  numerosV = array[0..9] of integer;
  
procedure inicializarVector(var v: numerosV);
var
  i: integer;
begin
  for i := 0 to 9 do
    v[i] := 0;
end;

procedure descomponerNumeroYcargarVector(var v: numerosV; num: integer);
var
  dig: integer;
begin
  while (num <> 0) do begin
    dig := num MOD 10;
    v[dig] := v[dig] + 1;
    num := num DIV 10;
  end;
end;

procedure cargarVector(var v: numerosV);
var
  num: integer;
begin
  write('Ingrese un numero: ');readln(num);
  while (num <> -1) do begin
    descomponerNumeroYcargarVector(v, num);
    write('Ingrese un numero: ');readln(num);
  end;
end;

procedure imprimirOcurrenciasPorDigito(v: numerosV);
var
  i: integer;
begin
  for i := 0 to 9 do
    if (v[i] > 0) then
      writeln('Numero ', i ,': ', v[i] ,' veces');
end;

function elementoMaximo(v: numerosV): integer;
var
  max, maxDig, i: integer;
begin
  max := -1;
  for i := 0 to 9 do
    if (v[i] > max) then begin
      max := v[i];
      maxDig := i;
    end;
  elementoMaximo := maxDig;
end;

procedure imprimirDigitosSinOcurrencias(v: numerosV);
var 
  i: integer;
begin
  write('Los digitos que no tuvieron ocurrencias son: ');
  for i := 0 to 9 do
    if (v[i] = 0) then
      write(i,' ');
end;

var
  v: numerosV;
begin
  inicializarVector(v);
  cargarVector(v);
  imprimirOcurrenciasPorDigito(v);
  writeln('El numero con mas ocurrencias fue el ', elementoMaximo(v));
  imprimirDigitosSinOcurrencias(v);
end.