{
  La compañía Canonical Llt. desea obtener estadísticas acerca del uso de Ubuntu Linux en La Plata. Para
  ello, debe realizar un programa que lea y almacene información sobre las computadoras con este
  sistema operativo (a lo sumo 10.000). De cada computadora se conoce código de computadora, la
  versión de Ubuntu que utilizan (18.04, 17.10, 17.04, etc.), la cantidad de paquetes instalados y la
  cantidad de cuentas de usuario que poseen. La información debe almacenarse ordenada por código de
  computadora de manera ascendente. La lectura finaliza al ingresar el código de computadora -1, que
  no debe procesarse. Una vez almacenados todos los datos, se pide:
  a. Informar la cantidad de computadoras que utilizan las versiones 18.04 o 16.04.
  b. Informar el promedio de cuentas de usuario por computadora.
  c. Informar la versión de Ubuntu de la computadora con mayor cantidad de paquetes instalados.
  d. Eliminar la información de las computadoras con código entre 0 y 500.
}
program ejercicio6;
const
  dimF = 5; { 10.000 }
  
type
  computadora = record
    cod, cantPaque, cantCue: integer;
    ver: real;
  end;
  vecComputadoras = array[1..dimF] of computadora;

procedure leerComputadora(var c: computadora);
begin
  write('Ingrese codigo: ');readln(c.cod);
  if (c.cod <> -1) then begin
    write('Ingrese version: ');readln(c.ver);
    write('Ingrese cantidad de cuentas: ');readln(c.cantCue);
    write('Ingrese cantidad de paquetes: ');readln(c.cantPaque);
    writeln();
  end;
end;

procedure cargarVector(var v: vecComputadoras;var dimL: integer);
var
  c: computadora;
begin
  leerComputadora(c);
  while (dimL < dimF) and (c.cod <> -1) do begin
    dimL := dimL + 1;
    v[dimL] := c;
    if (dimL < dimF) then
      leerComputadora(c);
  end;
end;

function incisoA(v: vecComputadoras; dimL: integer): integer;
var
  cant, i: integer;
  epsilon: real;
begin
  cant := 0;
  epsilon := 0.001; { Margen de error para comparar números reales }

  for i := 1 to dimL do 
    if (abs(v[i].ver - 18.04) < epsilon) or (abs(v[i].ver - 16.04) < epsilon) then
      cant := cant + 1;
  incisoA := cant;
end;

function incisoB(v: vecComputadoras; dimL: integer): real;
var
  totalCuentas, i: integer;
begin
  totalCuentas := 0;
  for i := 1 to dimL do
    totalCuentas := totalCuentas + v[i].cantCue;
  incisoB := totalCuentas / dimL;
end;

function incisoC(v: vecComputadoras; dimL: integer): real;
var
  i, max: integer;
  maxVer: real;
begin
  max := -1;
  for i := 1 to dimL do
    if (v[i].cantPaque > max) then begin
      max := v[i].cantPaque;
      maxVer := v[i].ver;
    end;
  incisoC := maxVer;
end;

procedure incisoD(var v: vecComputadoras; var dimL: integer);
var
  i, pos: integer;
begin
  pos := 1;
  while (pos <= dimL) and (v[pos].cod <= 500) do begin
    if (v[pos].cod >= 0) and (v[pos].cod <= 500) then begin
      for i := pos to dimL - 1 do
        v[i] := v[i + 1];
      dimL := dimL - 1;
    end
    else
      pos := pos + 1;
  end;
end;

procedure imprimirVector(v: vecComputadoras; dimL: integer);
var
  i: integer;
begin
  for i := 1 to dimL do
    writeln('Codigo: ', v[i].cod ,' | Version: ', v[i].ver:0:2 ,' | Cantidad de cuentas: ', v[i].cantCue ,' | Cantidad de paquetes instalados: ', v[i].cantPaque);
  writeln();
end;

var
  dimL: integer;
  v: vecComputadoras;
begin
  dimL := 0;
  cargarVector(v, dimL);
  if (dimL > 0) then begin
    imprimirVector(v, dimL);
    writeln('La cantidad de computadoras que usan la version 18.04 o 16.04 es: ', incisoA(v, dimL));
    writeln();
    writeln('El promedio de cuentas de usuario por computadora es: ', incisoB(v, dimL):0:2);
    writeln();
    writeln('La version con mas paquetes instalados es: ', incisoC(v, dimL):0:2);
    writeln();
    incisoD(v, dimL);
    imprimirVector(v, dimL);
  end;
end.