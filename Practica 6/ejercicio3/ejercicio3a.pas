{
  Utilizando el programa del ejercicio 1, realizar los siguientes cambios:
  a. Modificar el módulo armarNodo para que los elementos se guarden en la lista en el orden en que fueron
  ingresados (agregar atrás).
  b. Modificar el módulo armarNodo para que los elementos se guarden en la lista en el orden en que fueron
  ingresados, manteniendo un puntero al último ingresado.
}
program JugamosConListas;
type
  lista = ^nodo;
  nodo = record
    num : integer;
    sig : lista;
  end;

procedure armarNodo(var l: lista; num: integer);
var
  nue, aux : lista;
begin
  new(nue); nue^.num := num; nue^.sig := nil;
  if (l = nil) then
    l := nue
  else begin
    aux := l;
    while (aux^.sig <> nil) do
      aux := aux^.sig;
    aux^.sig := nue;
  end;
end;

procedure imprimirLista(l: lista);
begin
  while (l <> nil) do begin
    writeln(l^.num);
    l := l^.sig;
  end;
end;

procedure incrementarValores(var l: lista; num: integer);
var
  aux: lista;
begin
  aux := l;
  while (aux <> nil) do begin
    aux^.num := aux^.num + num;
    aux := aux^.sig;
  end;
end;

var
  l : lista;
  valor : integer;
begin
  l := nil;
  write('Ingrese un numero: ');readln(valor);
  while (valor <> 0) do begin
    armarNodo(l, valor);
    write('Ingrese un numero: ');readln(valor);
  end;
  imprimirLista(l);
end.