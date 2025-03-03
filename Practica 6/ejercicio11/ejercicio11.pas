{
  La Facultad de Informática debe seleccionar los 10 egresados con mejor promedio a los que la UNLP les
  entregará el premio Joaquín V. González. De cada egresado se conoce su número de alumno, apellido y el
  promedio obtenido durante toda su carrera.
  Implementar un programa que:
  a.  Lea la información de todos los egresados, hasta ingresar el código 0, el cual no debe procesarse.
  b.  Una vez ingresada la información de los egresados, informe el apellido y número de alumno de los
      egresados que recibirán el premio. La información debe imprimirse ordenada según el promedio del egresado
      (de mayor a menor).
}
program ejercicio11;
const
  cantMejores = 10;

type
  egresado = record
    num: integer;
    ape: string;
    prom: real;
  end;
  lista = ^nodo;
  nodo = record
    dato: egresado;
    sig: lista;
  end;
  mejoresPromedios = array[1..cantMejores] of egresado;

procedure leerEgresado(var e: egresado);
begin
  write('Ingrese numero: ');readln(e.num);
  if (e.num <> 0) then begin
    write('Ingrese apellido: ');readln(e.ape);
    write('Ingrese promedio: ');readln(e.prom);
    writeln();
  end;
end;

procedure cargarLista(var l: lista; e: egresado); // insertar ordenado por promedio del egresado
var
  nue, ant, act: lista;
begin
  new(nue); nue^.dato := e; nue^.sig := nil;
  if (l = nil) then
    l := nue
  else begin
    ant := l; act := l;
    while (act <> nil) and (act^.dato.prom > e.prom) do begin
      ant := act;
      act := act^.sig;
    end;
    if (ant = act) then
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;
end;

procedure imprimirLista(l: lista);
begin
  while (l <> nil) do begin
    writeln('Numero: ', l^.dato.num ,' | Apellido: ', l^.dato.ape ,' | Promedio: ', l^.dato.prom:0:2);
    l := l^.sig;
  end;
  writeln();
end;


procedure obtenerMejoresPromedios(l: lista;var v: mejoresPromedios);
var
  i: integer;
begin
  for i := 1 to cantMejores do begin
    if (l <> nil) then begin
      v[i] := l^.dato;
      l := l^.sig;
    end; 
  end;
end;

procedure imprimirPromedios(v: mejoresPromedios);
var
  i: integer;
begin
  writeln('Los ', cantMejores ,' mejores promedios');
  for i := 1 to cantMejores do
    writeln(i,'. ', v[i].ape,' ', v[i].num);
end;

var
  l: lista;
  e: egresado;
  v: mejoresPromedios;
begin
  l := nil;
  leerEgresado(e);
  while (e.num <> 0) do begin
    cargarLista(l, e);
    leerEgresado(e);
  end;
  writeln();
  imprimirLista(l);
  obtenerMejoresPromedios(l, v);
  imprimirPromedios(v);
end.