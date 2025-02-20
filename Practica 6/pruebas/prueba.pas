{
  
}
program ejercicio1;
type
  listaN = ^nodo;
  nodo = record
    dato: integer;
    sig: listaN;
  end;

procedure contalElTotal(l: listaN);
var
  sumaTotal: integer;
begin
  sumaTotal := 0;
  while (l <> nil) do begin
    sumaTotal := sumaTotal + l^.dato;
    l := l^.sig;
  end;
  writeln('La suma de todos los elementos en la lista es: ', sumaTotal);
end;

procedure agregarAdelante(var l: listaN; num: integer);
var
  nue: listaN;
begin
  new (nue); nue^.dato := num; nue^.sig := nil;
  if (l = nil) then
    l := nue
  else begin
    nue^.sig := l;
    l := nue;
  end;
end; 

procedure agregarAtrasOpcion2(var pri, ult: listaN; num: integer);
var
  nue: listaN;
begin
  new(nue); nue^.dato := num; nue^.sig := nil;
  if (pri = nil) then begin
    pri := nue; 
    ult := nue;
  end
  else begin
    ult^.sig := nue;
    ult := nue;
  end;
end;

procedure agregarAtras(var l: listaN; num: integer);
var
  nue, aux: listaN;
begin
  new(nue); nue^.dato := num; nue^.sig := nil;
  if (l = nil) then
    l := nue
  else begin
    aux := l;
    while (aux^.sig <> nil) do 
      aux := aux^.sig;
    aux^.sig := nue;
  end;
end;

procedure imprimirLista(l: listaN);
begin
  while (l <> nil) do begin
    writeln(l^.dato);
    l := l^.sig;
  end;
end;

function buscar(l: listaN; num: integer): boolean;
begin
  while (l <> nil) and (l^.dato <> num) do 
    l := l^.sig;
  buscar := (l <> nil) and (l^.dato = num);
end;

procedure eliminar(var l: listaN; num: integer);
var
  act, ant: listaN;
begin
  act := l;
  while (act <> nil) and (act^.dato <> num) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act <> nil) then begin
    if (act = l) then 
      l := l^.sig
    else 
      ant^.sig := act^.sig;
    dispose(act);
  end;
end;

procedure eliminarTodasLasOcurrencias(var l: listaN; num: integer);
var
  act, ant: listaN;
begin
  act := l;
  while (act <> nil) do begin
    act := l;
    while (act <> nil) and (act^.dato <> num) do begin
      ant := act;
      act := act^.sig;
    end;
    if (act <> nil) then begin
      if (act = l) then 
        l := l^.sig
      else 
        ant^.sig := act^.sig;
      dispose(act);
    end;
  end;
end;

procedure insertarOrdenado(var l: listaN; num: integer);
var
  nue, ant, act: listaN;
begin
  new(nue); nue^.dato := num; nue^.sig := nil;
  if (l  = nil) then 
    l := nue
  else begin
    act := l; ant := l;
    while (act <> nil) and (act^.dato < num) do begin
      ant := act;
      act := act^.sig;
    end;
    if (act = l) then begin
      nue^.sig := l;
      l := nue;
    end
    else begin
      ant^.sig := nue;
      nue^.sig := act;
    end;
  end;
end;

var
  l: listaN;
  num: integer;
begin
  l := nil; 
  write('Ingrese un numero: ');readln(num);
  while (num <> -1) do begin
    agregarAtras(l, num);
    write('Ingrese un numero: ');readln(num);
  end;
  imprimirLista(l);
  write('Ingrese un numero para eliminarlo de la lista: ');readln(num);
  eliminarTodasLasOcurrencias(l, num);
  imprimirLista(l);
end.