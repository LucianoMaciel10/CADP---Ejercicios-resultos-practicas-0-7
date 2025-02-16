{
  Realice un programa que resuelva los siguientes incisos:
  a. Lea nombres de alumnos y los almacene en un vector de a lo sumo 500 elementos. La lectura finaliza
  cuando se lee el nombre ‘ZZZ’, que no debe procesarse.
  b. Lea un nombre y elimine la primera ocurrencia de dicho nombre en el vector.
  c. Lea un nombre y lo inserte en la posición 4 del vector.
  d. Lea un nombre y lo agregue al vector.
  Nota: Realizar todas las validaciones necesarias.
}
program ejercicio2;
const
  dimF = 5; { 500 }
  
type
  vAlumnos = array[1..dimF] of string;

procedure cargarVector(var v: vAlumnos;var dimL: integer);
var
  nom: string;
begin
  write('Ingrese un nombre: ');readln(nom);
  while (dimL < dimF) and (nom <> 'ZZZ') do begin
    dimL := dimL + 1;
    v[dimL] := nom;
    if (dimL < dimF) then begin
      write('Ingrese un nombre: ');readln(nom);
    end;
  end;
end;  

function eliminarNombre(var v: vAlumnos; var dimL: integer; nom: string): boolean;
var
  pos, i: integer;
begin
  pos := 1;
  while (pos <= dimL) and (v[pos] <> nom) do
    pos := pos + 1;
  if (pos <= dimL) then begin
    for i := pos to dimL - 1 do
      v[i] := v[i + 1];
    dimL := dimL - 1;
    writeln('Se elimino correctamente el nombre ', nom);
    eliminarNombre := true;
    exit;
  end
  else
    writeln('No se encontro el nombre ', nom ,' en el vector');
    eliminarNombre := true;
end;

procedure imprimirVector(v: vAlumnos; dimL: integer);
var
  i: integer;
begin
  for i := 1 to dimL do
    write(v[i],' ');
  writeln();
end;

var
  dimL: integer;
  v: vAlumnos;
  nom: string;
begin
  dimL := 0;
  cargarVector(v, dimL);
  imprimirVector(v, dimL);
  write('Ingrese un nombre para eliminarlo del vector: ');readln(nom);
  eliminarNombre(v, dimL, nom);
  imprimirVector(v, dimL);
end.