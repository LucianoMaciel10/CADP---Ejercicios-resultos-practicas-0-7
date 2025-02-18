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
  end
  else begin
    writeln('No se encontro el nombre ', nom ,' en el vector');
    eliminarNombre := false;
  end;
end;

procedure imprimirVector(v: vAlumnos; dimL: integer);
var
  i: integer;
begin
  for i := 1 to dimL do
    write(v[i],' ');
  writeln();
end;

function insertarPos4(var v: vAlumnos; var dimL: integer; nom: string): boolean;
var
  i: integer;
begin
  if (dimL >= 3) and (dimL + 1 <= dimF) then begin
    for i := dimL downto 4 do 
      v[i + 1] := v[i];
    v[4] := nom;
    dimL := dimL + 1;
    insertarPos4 := true;
  end
  else begin
    if (dimL < 3) then
      writeln('No se pudo insertar en la posicion 4 porque el vector tiene menos de 3 elementos')
    else
      writeln('No hay espacio para agregar un nuevo alumno en el vector');
    insertarPos4 := false;
  end;
end;

function agregarAlVector(var v: vAlumnos; var dimL: integer; nom: string): boolean;
begin
  if (dimL < dimF) then begin
    dimL := dimL + 1;
    v[dimL] := nom;
    writeln('Se agrego el nombre ', nom ,' en la posicion ', dimL ,' del vector');
    agregarAlVector := true;
  end
  else begin
    writeln('No hay espacio para agregar un nuevo alumno en el vector');
    agregarAlVector := false;
  end;
end;

var
  dimL: integer;
  v: vAlumnos;
  nom: string;
begin
  dimL := 0;
  cargarVector(v, dimL);
  imprimirVector(v, dimL);
  // write('Ingrese un nombre para eliminarlo del vector: ');readln(nom);
  // eliminarNombre(v, dimL, nom);
  // imprimirVector(v, dimL);
  write('Ingrese un nombre para insertarlo en la posicion 4 del vector: ');readln(nom);
  insertarPos4(v, dimL, nom);
  imprimirVector(v, dimL);
  // write('Ingrese un nombre para agregarlo al vector: ');readln(nom);
  // agregarAlVector(v, dimL, nom);
  // imprimirVector(v, dimL);
end.