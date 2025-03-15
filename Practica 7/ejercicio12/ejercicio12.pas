{
  El centro de deportes Fortaco’s quiere procesar la información de los 4 tipos de suscripciones que
  ofrece: 1)Musculación, 2)Spinning, 3)Cross Fit, 4)Todas las clases. Para ello, el centro dispone de una tabla
  con información sobre el costo mensual de cada tipo de suscripción.
  Realizar un programa que lea y almacene la información de los clientes del centro. De cada cliente se
  conoce el nombre, DNI, edad y tipo de suscripción contratada (valor entre 1 y 4). Cada cliente tiene una
  sola suscripción. La lectura finaliza cuando se lee el cliente con DNI 0, el cual no debe procesarse.
  Una vez almacenados todos los datos, procesar la estructura de datos generada, calcular e informar:
  - La ganancia total de Fortaco’s
  - Las 2 suscripciones con más clientes.
  - Genere una lista con nombre y DNI de los clientes de más de 40 años que están suscritos a
  CrossFit o a Todas las clases. Esta lista debe estar ordenada por DNI.
}
program ejercicio12;
const
  cantSuscri = 4;
type
  vecSuscri = array[1..cantSuscri] of integer;
  vecPrecios = array[1..cantSuscri] of integer;
  cliente = record
    nom: string;
    edad: integer;
    dni: longint;
    tipo: integer;
  end;
  lista = ^nodo;
  nodo = record
    dato: cliente;
    sig: lista;
  end;
  cliente40 = record
    nom: string;
    dni: longint;
  end;
  lista40 = ^nodo40;
  nodo40 = record
    dato: cliente40;
    sig: lista40;
  end;

procedure cargarPrecios(var v: vecPrecios);
var
  i, precio, total: integer;
begin
  total := 0;
  for i := 1 to cantSuscri do begin
    precio := Random(201) + 100;
    if (i <> cantSuscri) then begin
      total := total + precio;
      v[i] := precio;
    end
    else
      v[i] := total;  // en la ultima posicion siempre esta la suscripcion a todo y vale el total de todos los demas
  end;
end;

procedure cargarClientes(var l: lista);

  procedure leerCliente(var c: cliente);
  var
    caracteres, strRandom: string;
    i, num: integer;
  begin
    num := Random(300) + 1;
    if (num > 280) then
      c.dni := 0
    else
      c.dni := Random(20000000) + 25000000;
    if (c.dni <> 0) then begin
      caracteres := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
      strRandom := '';
      for i := 1 to 6 do
        strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
      c.nom := strRandom;
      c.edad := Random(63) + 18; // 18-80
      c.tipo := Random(4) + 1;
    end;
  end;

  procedure agregarAdelante(var l: lista; c: cliente);
  var
    nue: lista;
  begin
    new(nue); nue^.dato := c;
    nue^.sig := l;
    l := nue;
  end;

var
  c: cliente;
begin
  leerCliente(c);
  while (c.dni <> 0) do begin
    agregarAdelante(l, c);
    leerCliente(c);
  end;
end;

procedure recorrerLista(l1: lista; var l2: lista40; vp: vecPrecios);

  procedure inicializarSuscripciones(var v: vecSuscri);
  var
    i: integer;
  begin
    for i := 1 to cantSuscri do
      v[i] := 0;
  end;

  procedure insertarOrdenado(var l: lista40; nom: string; dni: longint);
  var
    ant, act, nue: lista40; c: cliente40;
  begin
    c.nom := nom; c.dni := dni;
    new(nue); nue^.dato := c;
    act := l; ant := l;
    while (act <> nil) and (act^.dato.dni < dni) do begin
      ant := act; act := act^.sig;
    end;
    if (act = ant) then 
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;

  procedure informarMaxSuscripciones(v: vecSuscri);
  var
    i, max1, max2, maxSuscri1, maxSuscri2: integer;
  begin
    max1 := -1; max2 := -1; maxSuscri1 := 0;
    for i := 1 to cantSuscri do
      if (v[i] > max1) then begin
        max2 := max1; maxSuscri2 := maxSuscri1;
        max1 := v[i]; maxSuscri1 := i;
      end
      else
        if (v[i] > max2) then begin
          max2 := v[i]; maxSuscri2 := i;
        end;
    writeln('Las dos tipos de suscripciones con mas clientes son: ', maxSuscri1 ,' y ', maxSuscri2);
  end;

var
  vs: vecSuscri; total: integer;
begin
  total := 0;
  inicializarSuscripciones(vs);
  while (l1 <> nil) do begin
    total := total + vp[l1^.dato.tipo];
    vs[l1^.dato.tipo] := vs[l1^.dato.tipo] + 1;
    if (l1^.dato.edad > 40) and ((l1^.dato.tipo = 3) or (l1^.dato.tipo = 4)) then
      insertarOrdenado(l2, l1^.dato.nom, l1^.dato.dni);
    l1 := l1^.sig;
  end;
  writeln('La ganancia total de Fortaco es: ', total);
  informarMaxSuscripciones(vs);
end;

procedure imprimirPrecios(v: vecPrecios);
var
  i: integer;
begin
  writeln();
  writeln('Precio de cada suscripcion');
  for i := 1 to cantSuscri do
    writeln('Tipo ', i ,': ', v[i]);
end;

procedure imprimirClientes(l: lista);
begin
  writeln();
  writeln('Clientes');
  while (l <> nil) do begin
    writeln('Nombre: ', l^.dato.nom,' | Edad: ', l^.dato.edad,' | DNI: ', l^.dato.dni ,' | Tipo: ', l^.dato.tipo);
    l := l^.sig;
  end;
  writeln();
end;

procedure imprimirClientes40(l: lista40);
begin
  writeln();
  writeln('Clientes con mas de 40 anios inscriptos en Crossfit (3) o todas las clases (4)');
  while (l <> nil) do begin
    writeln('Nombre: ', l^.dato.nom,' | DNI: ', l^.dato.dni);
    l := l^.sig;
  end;
  writeln();
end;

var
  l1: lista; l2: lista40; v: vecPrecios;
begin
  Randomize();
  l1 := nil; l2 := nil;
  cargarPrecios(v); // se dispone
  imprimirPrecios(v);
  cargarClientes(l1);
  imprimirClientes(l1);
  recorrerLista(l1, l2, v);
  imprimirClientes40(l2);
end.