{
  Utilizando el programa del ejercicio 1, realizar los siguientes módulos:
  a. Máximo: recibe la lista como parámetro y retorna el elemento de valor máximo.
  b. Mínimo: recibe la lista como parámetro y retorna el elemento de valor mínimo.
  c. Múltiplos: recibe como parámetros la lista L y un valor entero A, y retorna la cantidad de elementos de la
  lista que son múltiplos de A.
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

function maximo(l: lista): integer;
var
  max: integer;
begin
  max := -1;
  while (l <> nil) do begin
    if (l^.num > max) then
      max := l^.num;
    l := l^.sig;
  end;
  maximo := max;
end;

function minimo(l: lista): integer;
var
  min: integer;
begin
  min := 32767;
  while (l <> nil) do begin
    if (l^.num < min) then
      min := l^.num;
    l := l^.sig;
  end;
  minimo := min;
end;

function multiplos(l: lista; num: integer): integer;
var
  cant: integer;
begin
  cant := 0;
  while (l <> nil) do begin
    if (l^.num MOD num = 0) then
      cant := cant + 1;
    l := l^.sig;
  end;
  multiplos := cant;
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
  writeln('El valor mas grande en la lista es: ', maximo(l));
  writeln('El valor mas chico en la lista es: ', minimo(l));
  write('Ingrese un numero: ');readln(valor);
  writeln('La cantidad de valores que son multiplo de ', valor ,' en la lista es: ', multiplos(l, valor));
end.