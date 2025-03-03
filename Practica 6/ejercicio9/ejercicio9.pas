{
  Utilizando el programa del ejercicio 1, realizar los siguientes módulos:
  a.  EstáOrdenada: recibe la lista como parámetro y retorna true si la misma se encuentra ordenada, o false en
      caso contrario.
  b.  Eliminar: recibe como parámetros la lista y un valor entero, y elimina dicho valor de la lista (si existe). Nota:
      la lista podría no estar ordenada.
  c.  Sublista: recibe como parámetros la lista L y dos valores enteros A y B, y retorna una nueva lista con todos
      los elementos de la lista L mayores que A y menores que B.
  d.  Modifique el módulo Sublista del inciso anterior, suponiendo que la lista L se encuentra ordenada de
      manera ascendente.
  e.  Modifique el módulo Sublista del inciso anterior, suponiendo que la lista L se encuentra ordenada de
      manera descendente.
}
program JugamosConListas;
type
  lista = ^nodo;
  nodo = record
    num : integer;
    sig : lista;
  end;

procedure agregarAdelante(var l: lista; num: integer);
var
  aux : lista;
begin
  new(aux);
  aux^.num := num;
  aux^.sig := l;
  l := aux;
end;

procedure insertarOrdenado(var l: lista; num: integer);
var
  act, ant, nue: lista;
begin
  new(nue); nue^.num := num; 
  act := l; ant := l;
  while (act <> nil) and (act^.num < num) do begin
    ant := act;                                    
    act := act^.sig;  
  end;
  if (act = ant) then 
    l := nue
  else 
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure imprimirLista(l: lista);
begin
  while (l <> nil) do begin
    writeln(l^.num);
    l := l^.sig;
  end;
end;

function estaOrdenada(l: lista): boolean;
var
  sig: lista;
begin
  sig := l^.sig;
  while (sig <> nil) and (l^.num <= sig^.num) do begin
    l := l^.sig;
    sig := l^.sig;
  end; 
  estaOrdenada := (sig = nil);
end;

procedure eliminar(var l: lista; num: integer);
var
  act, ant: lista;
begin
  act := l;
  if (l^.num = num) then begin
    l := l^.sig;
    dispose(act);
  end
  else begin
    if (estaOrdenada(l)) then begin
      while (act <> nil) and (act^.num < num) do begin
        ant := act;
        act := act^.sig;
      end;
    end
    else begin
      while (act <> nil) and (act^.num <> num) do begin
        ant := act;
        act := act^.sig;
      end;
    end;
    if (act <> nil) and (act^.num = num) then begin
      ant^.sig := act^.sig;
      dispose(act);
    end;
  end;
end;

procedure Sublista(l: lista; var nueL: lista; a, b: integer);
begin
  while (l <> nil) and (l^.num > a) do begin { (> a) si sabes que la lista esta ordenada de mayor a menor }
    if (l^.num > a) and (l^.num < b) then    { (< b) si sabes que la lista esta ordenada de menor a mayor }
      agregarAdelante(nueL, l^.num);
    l := l^.sig;
  end;
end;

var
  l, nueL: lista;
  valor, a, b: integer;
begin
  l := nil; nueL := nil;
  write('Ingrese un numero: ');readln(valor);
  while (valor <> 0) do begin
    insertarOrdenado(l, valor);
    write('Ingrese un numero: ');readln(valor);
  end;
  imprimirLista(l);
  if (estaOrdenada(l)) then
    writeln('La lista esta ordenada')
  else
    writeln('La lista no esta ordenada');
  write('Ingrese un numero para eliminarlo de la lista: ');readln(valor);
  eliminar(l, valor);
  imprimirLista(l);
  write('Ingrese el valor A: ');readln(a);
  write('Ingrese el valor B: ');readln(b);
  Sublista(l, nueL, a, b);
  writeln('Lista con valores mayores que ', a ,' y menores que ', b ,' segun los valores de la lista anterior');
  imprimirLista(nueL);
end.