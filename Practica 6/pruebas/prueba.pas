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

var
  pri, ult: listaN;
  num: integer;
begin
  pri := nil; 
  write('Ingrese un numero: ');readln(num);
  while (num <> -1) do begin
    agregarAtrasOpcion2(pri, ult, num);
    write('Ingrese un numero: ');readln(num);
  end;
  contalElTotal(pri);
  imprimirLista(pri);
end.