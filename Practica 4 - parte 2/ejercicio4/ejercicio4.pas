{
  Una cátedra dispone de información de sus alumnos (a lo sumo 1000). De cada alumno se conoce nro de
  alumno, apellido y nombre y cantidad de asistencias a clase. Dicha información se encuentra ordenada por
  nro de alumno de manera ascendente. Se pide:
  a.  Un módulo que retorne la posición del alumno con un nro de alumno recibido por parámetro. El
      alumno seguro existe.
  b.  Un módulo que reciba un alumno y lo inserte en el vector.
  c.  Un módulo que reciba la posición de un alumno dentro del vector y lo elimine.
  d.  Un módulo que reciba un nro de alumno y elimine dicho alumno del vector
  e.  Un módulo que elimine del vector todos los alumnos con cantidad de asistencias en 0.
  Nota: Realizar el programa principal que invoque los módulos desarrollados en los incisos previos con datos
  leídos de teclado.
}
program ejercicio4;
const
  dimF = 5; { 1000 }
  
type
  alumno = record
    num, asist: integer;
    ape, nom: string;
  end;
  vecAlumnos = array[1..dimF] of alumno;

procedure leerAlumno(var a: alumno);
begin
  write('Ingrese numero de alumno: ');readln(a.num);
  if (a.num <> 0) then begin
    write('Ingrese nombre: ');readln(a.nom);
    write('Ingrese apellido: ');readln(a.ape);
    write('Ingrese cantidad de asistencias a clase: ');readln(a.asist);
    writeln();
  end;
end;
  
procedure cargarVector(var v: vecAlumnos;var dimL: integer);
var
  a: alumno;
begin
  leerAlumno(a);
  while (dimL < dimF) and (a.num <> 0)  do begin { el ejercicio no menciona ninguna condicion de fin y dice a lo sumo 1000, por lo que dimL realmente siempre va a ser dimF, para las pruebas puse mi propia condicion de fin (a.num <> 0) }
    dimL := dimL + 1;
    v[dimL] := a;
    if (dimL < dimF) then
      leerAlumno(a);
  end;
end;

function buscarAlumno(v: vecAlumnos; diml, num: integer): integer;
var
  pos: integer;
begin
  pos := 1;
  while (v[pos].num <> num) do
    pos := pos + 1;
  buscarAlumno := pos; { ya que seguro existe, no preguntamos que pos <= dimL y que v[pos].num = num }
end;

function agregarAlumno(var v: vecAlumnos; var dimL: integer; a: alumno): boolean;
begin
  if (dimL + 1 < dimF) then begin
    dimL := dimL + 1;
    v[dimL] := a;
    agregarAlumno := true;
  end
  else
    agregarAlumno := false;
end;

function eliminarPorPosicion(var v: vecAlumnos; var dimL: integer; pos: integer): boolean;
var
  i: integer;
begin
  if (pos > 1) and (pos <= dimL) then begin
    for i := pos to dimL - 1 do
      v[i] := v[i + 1];
    dimL := dimL - 1;
    eliminarPorPosicion := true;
  end
  else
    eliminarPorPosicion := false;
end;

function eliminarPorNumeroDeAlumno(var v: vecAlumnos; var dimL: integer; num: integer): boolean;
var
  i, pos: integer;
begin
  pos := 1;
  while (pos <= dimL) and (v[pos].num <> num) do
    pos := pos + 1;
  if (pos <= dimL) and (v[pos].num = num) then begin
    for i := pos to dimL - 1 do
      v[i] := v[i + 1];
    dimL := dimL - 1;
    eliminarPorNumeroDeAlumno := true;
  end
  else  
    eliminarPorNumeroDeAlumno := false;
end;

procedure imprimirVector(v: vecAlumnos; dimL: integer);
var
  i: integer;
begin
  for i := 1 to dimL do
    writeln('Numero de alumno: ', v[i].num ,' | Nombre: ', v[i].nom ,' | Apellido: ', v[i].ape ,' | Cantidad de asistencias a clase: ', v[i].asist);
  writeln();
end;

procedure eliminarAlumnosAsist0(var v: vecAlumnos;var dimL: integer);
var
  pos, i: integer;
begin
  pos := 1;
  while (pos <= dimL) do begin
    while (pos <= dimL) and (v[pos].asist <> 0) do
      pos := pos + 1;
    if (pos <= dimL) and (v[pos].asist = 0) then begin
      for i := pos to dimL - 1 do
        v[i] := v[i + 1]; 
      dimL := dimL - 1;
    end;
  end; 
end;

var
  dimL, num: integer;
  v: vecAlumnos;
  a: alumno;
begin
  dimL := 0;
  cargarVector(v, dimL);
  imprimirVector(v, dimL);

  write('Ingrese numero de alumno para buscarlo en el vector: ');readln(num);
  writeln('El alumno se encontraba en la posicion ', buscarAlumno(v, dimL, num) , ' del vector');
  writeln();

  writeln('Lectura de un nuevo alumno para agregarlo al vector');
  leerAlumno(a);
  if (agregarAlumno(v, dimL, a)) then begin
    writeln('El alumno ', a.num ,' fue agregado exitosamente');
    imprimirVector(v, dimL);
  end
  else begin
    writeln('No hay espacio disponible para agregar un nuevo alumno en el vector');
    writeln();
  end;

  write('Ingrese una posicion para eliminar el alumno en esa posicion dentro del vector: ');readln(num);
  if (eliminarPorPosicion(v, dimL, num)) then begin
    writeln('El alumno que se encontraba en la posicion ', num ,' fue eliminado exitosamente');
    imprimirVector(v, dimL);
  end
  else begin
    writeln('La posicion ingresada no corresponde a una posicion valida en el vector');
    writeln();
  end;
  
  write('Ingrese un numero de alumno para eliminarlo del vector: ');readln(num);
  if (eliminarPorNumeroDeAlumno(v, dimL, num)) then begin
    writeln('El alumno con el numero ', num ,' fue eliminado exitosamente');
    imprimirVector(v, dimL);
  end
  else begin
    writeln('El numero de alumno ingresado no existe dentro del vector');
    writeln();
  end;

  eliminarAlumnosAsist0(v, dimL);
  writeln('Vector despues de eliminar todos los alumnos con cantidad de asistencias en 0');
  imprimirVector(v, dimL);
end.