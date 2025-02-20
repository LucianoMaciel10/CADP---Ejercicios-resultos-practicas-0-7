{
  Utilizando el programa del ejercicio 1, modificar el módulo armarNodo para que los elementos de la lista
  queden ordenados de manera ascendente (insertar ordenado).
}
program JugamosConListas;
type
  lista = ^nodo;
  nodo = record
    num : integer;
    sig : lista;
  end;

procedure insertarOrdenado(var l: lista; num: integer);
var
  ant, act, nue: lista;
begin
  new(nue); nue^.num := num; nue^.sig := nil;
  if (l = nil) then { si la lista esta vacia }
    l := nue
  else begin
    act := l; ant := l;
    while (act <> nil) and (act^.num < num) do begin { buscar posicion }
      ant := act;
      act := act^.sig;
    end;
    if (act = l) then begin { insertar primero }
      nue^.sig := l;
      l := nue;
    end
    else begin { insertar ultimo o en el medio }
      ant^.sig := nue;
      nue^.sig := act;
    end;
  end;
end;

procedure imprimirLista(l: lista);
begin
  while (l <> nil) do begin
    writeln(l^.num);
    l := l^.sig;
  end;
end;

var
  l : lista;
  valor : integer;
begin
  l := nil;
  write('Ingrese un numero: ');readln(valor);
  while (valor <> 0) do begin
    insertarOrdenado(l, valor);
    write('Ingrese un numero: ');readln(valor);
  end;
  imprimirLista(l);
end.