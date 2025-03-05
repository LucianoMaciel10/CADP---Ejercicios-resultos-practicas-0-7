{
  La cátedra de CADP está organizando la cursada para el año 2019. Para ello, dispone de una lista con
  todos los alumnos que cursaron EPA. De cada alumno se conoce su DNI, apellido, nombre y la nota obtenida.
  Escribir un programa que procese la información de alumnos disponible y los distribuya en turnos utilizando
  los siguientes criterios:
  - Los alumnos que obtuvieron al menos 8 en EPA deberán ir a los turnos 1 ó 4.
  - Los alumnos que obtuvieron entre 5 y 8 deberán ir a los turnos 2, 3 ó 5.
  - Los alumnos que no alcanzaron la nota 5 no se les asignará turno en CADP.
  Al finalizar, el programa debe imprimir en pantalla la lista de alumnos para cada turno.
  Nota: La distribución de alumnos debe ser lo más equitativa posible.
}
program ejercicio15;
type
  alumno = record
    dni: longint;
    ape, nom: string;
    nota: integer;
  end;
  lista = ^nodo;
  nodo = record
    dato: alumno;
    sig: lista;
  end;
  vecTurnos = array[1..5] of lista;

function randomString(): string;
var
  i: Integer;
  strRandom, caracteres: string;
begin
  caracteres := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  strRandom := '';
  for i := 1 to 8 do
    strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
  randomString := strRandom;
end;

function randomNumber(): integer;
begin
  randomNumber := Random(10) + 1; 
end;

function randomDNI(): longint;
begin
  randomDNI := Random(30000001) + 20000000; 
end;

procedure insertarAdelante(var l: lista; a: alumno);
var
  nue: lista;
begin
  new(nue); nue^.dato := a; 
  nue^.sig := l;
  l := nue;
end;

procedure cargarLista(var l: lista);

  procedure leerAlumno(var a: alumno);
  begin
    a.nota := randomNumber();
    a.ape := randomString();
    a.nom := randomString();
    a.dni := randomDNI();
  end;

var
  i: integer;
  a: alumno;
begin
  for i := 1 to 30 do begin
    leerAlumno(a);
    insertarAdelante(l, a);
  end;
end;

procedure imprimirLista(l: lista);
begin
  while (l <> nil) do begin
    writeln('DNI: ', l^.dato.dni ,' | Nombre: ', l^.dato.nom ,' | Apellido: ', l^.dato.ape ,' | Nota: ', l^.dato.nota);
    l := l^.sig;
  end;
end;

function espacioDelTurno(l: lista): integer;
var
  cant: integer;
begin
  cant := 0;
  while (l <> nil) do begin
    cant := cant + 1;
    l := l^.sig;
  end;
  espacioDelTurno := cant;
end;

procedure distribuirAlumnos(l: lista; var v: vecTurnos);
begin
  while (l <> nil) do begin
    if (l^.dato.nota >= 8) then
      if (espacioDelTurno(v[1]) < espacioDelTurno(v[4])) then
        insertarAdelante(v[1], l^.dato)
      else
        insertarAdelante(v[4], l^.dato)
    else
      if (l^.dato.nota >= 5) and (l^.dato.nota < 8) then
        if (espacioDelTurno(v[2]) < espacioDelTurno(v[3])) or (espacioDelTurno(v[2]) < espacioDelTurno(v[5])) then
          insertarAdelante(v[2], l^.dato)
        else
          if (espacioDelTurno(v[3]) < espacioDelTurno(v[2])) or (espacioDelTurno(v[3]) < espacioDelTurno(v[5])) then
            insertarAdelante(v[3], l^.dato)
          else
            insertarAdelante(v[5], l^.dato);
    l := l^.sig;
  end;
end;

var
  l: lista;
  i: integer;
  v: vecTurnos;
begin
  Randomize;
  l := nil;
  for i := 1 to 5 do
    v[i] := nil;
  cargarLista(l); { se dispone la lista con los alumnos ya cargados }
  writeln('Todos los alumnos');
  imprimirLista(l);writeln();
  distribuirAlumnos(l, v);
  for i := 1 to 5 do begin
    writeln('Turno ', i);
    imprimirLista(v[i]);
    writeln();
  end;
end.