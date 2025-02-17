{
  a. Dado un vector de enteros de a lo sumo 500 valores, realice un módulo que reciba dicho vector y un valor
  n y retorne si n se encuentra en el vector o no.
  b. Modifique el módulo del inciso a. considerando ahora que el vector se encuentra ordenado de manera
  ascendente.
}
program ejercicio1;
const
  dimF = 5; { 500 }
  
type
  vNumeros = array[1..dimF] of integer;

procedure cargarVector(var v: vNumeros; var dimL: integer);
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

function busqueda(v: vNumeros; dimL, num: integer): boolean;
var 
  i: integer;
begin
  i := 1;
  while (i <= dimL) and (v[i] <> num) do begin
    writeln(v[i],' = ',num);
    i := i + 1;
  end;
  busqueda := (i <= dimL) and (v[i] = num);
end;

procedure imprimirVector(v: vNumeros; dimL: integer);
var
  i: integer;
begin
  for i := 1 to dimL do
    write(v[i],' ');
  writeln();
end;

function busquedaDicotomica(v: vNumeros; dimL, num: integer): boolean;
var
  pri, ult, medio: integer;
begin
  pri := 1; ult := dimL; medio := (pri + ult) DIV 2;
  while (pri <= ult) and (v[medio] <> num) do begin 
    if (v[medio] > num) then
      ult := medio - 1
    else
      pri := medio + 1;
    medio := (pri + ult) DIV 2;
  end;
  busquedaDicotomica := (pri <= ult) and (v[medio] = num);
end;
  
var
  v: vNumeros;
  dimL, num: integer;
begin
  dimL := 0;
  cargarVector(v, dimL);
  imprimirVector(v, dimL);
  write('Ingrese un valor para buscarlo en el vector: ');readln(num);
  if (busqueda(v, dimL, num)) then
    writeln('El numero ', num ,' esta en el vector')
  else
    writeln('El numero ', num ,' no esta en el vector');
  imprimirVector(v, dimL);
  write('Ingrese un valor para buscarlo en el vector: ');readln(num);
  if (busquedaDicotomica(v, dimL, num)) then
    writeln('El numero ', num ,' esta en el vector')
  else
    writeln('El numero ', num ,' no esta en el vector');
end.