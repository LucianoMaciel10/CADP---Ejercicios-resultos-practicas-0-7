{
  La biblioteca de la Universidad Nacional de La Plata necesita un programa para administrar
  información de préstamos de libros efectuados en marzo de 2020. Para ello, se debe leer la información
  de los préstamos realizados. De cada préstamo se lee: nro. de préstamo, ISBN del libro prestado, nro. de
  socio al que se prestó el libro, día del préstamo (1..31). La información de los préstamos se lee de manera
  ordenada por ISBN y finaliza cuando se ingresa el ISBN -1 (que no debe procesarse).
  Se pide:
  A)  Generar una estructura que contenga, para cada ISBN de libro, la cantidad de veces que fue prestado.
      Esta estructura debe quedar ordenada por ISBN de libro.
  B)  Calcular e informar el día del mes en que se realizaron menos préstamos.
  C)  Calcular e informar el porcentaje de préstamos que poseen nro. de préstamo impar y nro. de socio par.
}
program ejercicio14;
type
  vecDias = array[1..31] of integer;
  prestamo = record
    dia, num, socio, ISBN: integer;
  end;
  cantPrestamo = record
    cant, ISBN: integer;
  end;
  lista1 = ^nodo1;
  nodo1 = record
    dato: prestamo;
    sig: lista1;
  end;
  lista2 = ^nodo2;
  nodo2 = record
    dato: cantPrestamo;
    sig: lista2;
  end;

procedure cargarPrestamos(var l: lista1);

  procedure leerPrestamo(var p: prestamo; j: integer);
  begin
    p.ISBN := j;
    if (j <> -1) then begin
      p.socio := Random(50) + 1;
      p.num := Random(401) + 100;
      p.dia := Random(31) + 1;
    end;
  end;

  procedure agregarAtras(var l: lista1; p: prestamo);
  var
    aux, nue: lista1;
  begin
    new(nue); nue^.dato := p; nue^.sig := nil;
    if (l = nil) then 
      l := nue
    else begin
      aux := l;
      while (aux^.sig <> nil) do
        aux := aux^.sig;
      aux^.sig := nue;
    end;
  end;

var
  p: prestamo;
  num, fin, i, j: integer;
begin
  num := Random(5) + 1; 
  fin := Random(100) + 1;
  j := 0;
  if (fin > 80) then
    j := -1
  else
    j := j + 1;
  if (fin <> -1) then 
    for i := 1 to num do begin
      leerPrestamo(p, j);
      if (p.ISBN = -1) then
        break;
      agregarAtras(l, p);
    end;
  while (p.ISBN <> -1) do begin
    agregarAtras(l, p);
    num := Random(5) + 1;
    fin := Random(100) + 1;
    if (fin > 80) then
      j := -1
    else
      j := j + 1;
    if (fin <> -1)then 
      for i := 1 to num do begin
        leerPrestamo(p, j);
        if (p.ISBN = -1) then
          break;
        agregarAtras(l, p);
      end;
  end;
end;

procedure imprimirPrestamos1(l: lista1);
begin
  writeln();
  writeln('Prestamos de libros');
  while (l <> nil) do begin
    writeln('ISBN: ', l^.dato.ISBN,' | Numero de prestamo: ', l^.dato.num,' | Numero de socio: ', l^.dato.socio,' | Dia del mes: ', l^.dato.dia);
    l := l^.sig;
  end;
  writeln();
end;

procedure recorrerLista(l1: lista1; var l2: lista2);

  procedure inicializarDias(var v: vecDias);
  var
    i: integer;
  begin
    for i := 1 to 31 do
      v[i] := 0;
  end;

  procedure informarMinDia(v: vecDias);
  var
    min, i, minDia: integer;
  begin
    min := 32767;
    for i := 1 to 31 do
      if (v[i] < min) then begin
        min := v[i]; minDia := i;
      end;
    writeln('El dia que menos prestamos se hicieron fue el: ', minDia);
  end;

  procedure agregarAtras(var l: lista2; cp: cantPrestamo);
  var
    aux, nue: lista2;
  begin
    new(nue); nue^.dato := cp; nue^.sig := nil;
    if (l = nil) then
      l := nue
    else begin
      aux := l;
      while (aux^.sig <> nil) do
        aux := aux^.sig;
      aux^.sig := nue;
    end;
  end;

var
  total, ISBNact, cantP, cantImparPar: integer; v: vecDias; cp: cantPrestamo;
begin
  total := 0; cantImparPar := 0; inicializarDias(v);
  while (l1 <> nil) do begin
    ISBNact := l1^.dato.ISBN; cantP := 0;
    while (l1 <> nil) and (ISBNact = l1^.dato.ISBN) do begin
      v[l1^.dato.dia] := v[l1^.dato.dia] + 1;
      cantP := cantP + 1;
      total := total + 1;
      if (l1^.dato.num MOD 2 <> 0) and (l1^.dato.socio MOD 2 = 0) then
        cantImparPar := cantImparPar + 1;
      l1 := l1^.sig;
    end;
    cp.cant := cantP; cp.ISBN := ISBNact;
    agregarAtras(l2, cp);
  end;
  informarMinDia(v);
  if (total > 0) then
    writeln('El ', ((cantImparPar / total)*100):0:2 ,'% de prestamos posee numero de prestamo impar y numero de socio par');
end;

procedure imprimirPrestamos2(l: lista2);
begin
  writeln();
  while (l <> nil) do begin
    writeln('ISBN: ', l^.dato.ISBN,' | Cantidad de prestamos: ', l^.dato.cant);
    l := l^.sig;
  end;
  writeln();
end;

var
  l1: lista1; l2: lista2;
begin
  Randomize;
  l1 := nil; l2 := nil;
  cargarPrestamos(l1);
  imprimirPrestamos1(l1);
  recorrerLista(l1, l2);
  imprimirPrestamos2(l2);
end.