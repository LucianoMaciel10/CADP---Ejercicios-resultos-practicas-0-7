{
  a. Indicar qué hace el programa.
  b. Indicar cómo queda conformada la lista si se lee la siguiente secuencia de números: 10 21 13 48 0.
  c. Implementar un módulo que imprima los números enteros guardados en la lista generada.
  d. Implementar un módulo que reciba la lista y un valor, e incremente con ese valor cada dato de la lista.
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
  aux : lista;
begin
  new(aux);
  aux^.num := num;
  aux^.sig := l;
  l := aux;
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
  write('Ingrese un numero para incrementar todos los valores de la lista con ese numero: ');readln(valor);
  incrementarValores(l, valor);
  imprimirLista(l);
end.