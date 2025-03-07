{
  Una maternidad dispone información sobre sus pacientes. De cada una se conoce: nombre, apellido y
  peso registrado el primer día de cada semana de embarazo (a lo sumo 42). La maternidad necesita un
  programa que analice esta información, determine e informe:
  a. Para cada embarazada, la semana con mayor aumento de peso.
  b. El aumento de peso total de cada embarazada durante el embarazo.
}
program ejercicio4;
const
  dimF = 42;
type
  vecPesos = array[1..dimF] of real;
  paciente = record
    ape, nom: string;
    pesos: vecPesos;
    dimL: integer;
  end;
  lista = ^nodo;
  nodo = record
    dato: paciente;
    sig: lista;
  end;

procedure cargarPacientes(var l: lista);

  procedure leerPaciente(var p: paciente);

    procedure ordenarVector(var v: vecPesos; dimL: integer);
    var
      item: real;
      i, j, p: integer;
    begin
      for i := 1 to dimL - 1 do begin
        p := i;
        for j := i + 1 to dimL do
          if (v[j] < v[p]) then
            p := j;
        item := v[p];
        v[p] := v[i];
        v[i] := item;
      end;
    end;

  var 
    i, semanas: integer;
    caracteres, strRandom: string;
  begin
    caracteres := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    strRandom := '';
    for i := 1 to 6 do
      strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
    p.nom := strRandom;
    strRandom := '';
    for i := 1 to 6 do
      strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
    p.ape := strRandom;
    semanas := Random(6) + 37; // semanas que estubo embarazada 37-42
    for i := 1 to semanas do
      p.pesos[i] := Random(36) + 60;
    p.dimL := semanas;
    ordenarVector(p.pesos, semanas);
  end;

  procedure agregarAdelante(var l: lista; p: paciente);
  var
    nue: lista;
  begin
    new(nue); nue^.dato := p;
    nue^.sig := l;
    l := nue;
  end;

var
  i: integer;
  p: paciente;
begin
  for i := 1 to 5 do begin
    leerPaciente(p);
    agregarAdelante(l, p);
  end;
end;

procedure informarIncisoAyB(l: lista);

  procedure calcularSemanaMax(v: vecPesos; dimL: integer; var max: real; var semanaMax: integer);
  var
    i: integer;
  begin
    for i := 1 to dimL do begin
      if (v[i + 1] - v[i] > max) then  begin
        max := v[i + 1] - v[i];
        semanaMax := i + 1;
      end;
    end;
  end;

var
  max: real; semanaMax: integer;
begin
  while (l <> nil) do begin
    max := -1;
    calcularSemanaMax(l^.dato.pesos, l^.dato.dimL, max, semanaMax);
    writeln('La paciente ', l^.dato.nom ,' ', l^.dato.ape ,' subio ', max:0:2 ,'KG en la semana: ', semanaMax);
    writeln('La paciente ', l^.dato.nom ,' ', l^.dato.ape ,' subio un total de ', (l^.dato.pesos[l^.dato.dimL] - l^.dato.pesos[1]):0:2 ,'KG durante su embarazo');
    l := l^.sig;
  end;
end;

procedure imprimirPacientes(l: lista);
var
  i: integer;
begin
  while (l <> nil) do begin
    writeln('Nombre: ', l^.dato.nom ,' | Apellido: ', l^.dato.ape);
    writeln('Peso del primer dia de cada semana durante el embarazo');
    for i := 1 to l^.dato.dimL do
      writeln('Semana: ', i ,': ', l^.dato.pesos[i]:0:2);
    writeln();
    l := l^.sig;
  end;
  writeln();
end;

var
  l: lista;
begin
  Randomize;
  l := nil;
  cargarPacientes(l); // se dispone
  imprimirPacientes(l);
  informarIncisoAyB(l);
end.