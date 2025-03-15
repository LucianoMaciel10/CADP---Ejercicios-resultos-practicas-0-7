{
  Realizar un programa para una empresa productora que necesita organizar 100 eventos culturales. De
  cada evento se dispone la siguiente información: nombre del evento, tipo de evento (1: música, 2: cine, 3: obra de teatro, 4: unipersonal y 5: monólogo), lugar del evento, cantidad máxima de personas permitidas para el evento y costo de la entrada. 
  Se pide:
  1.  Generar una estructura con las ventas de entradas para tales eventos culturales. De cada venta se
      debe guardar: código de venta, número de evento (1..100), DNI del comprador y cantidad de
      entradas adquiridas. La lectura de las ventas finaliza con código de venta -1.
  2.  Una vez leída y almacenada la información de las ventas, calcular e informar:
      a.  El nombre y lugar de los dos eventos que han tenido menos recaudación.
      b.  La cantidad de entradas vendidas cuyo comprador contiene en su DNI más dígitos pares que
          impares y que sean para el evento de tipo “obra de teatro”.
      c.  Si la cantidad de entradas vendidas para el evento número 50 alcanzó la cantidad máxima de personas permitidas.
}
program ejercicio11;
const
  cantEventos = 10; // 100
type
  evento = record
    nom, lugar: string;
    maxPersonas, costo, tipo, cupos: integer;
  end;
  vecEventos = array[1..cantEventos] of evento;
  entrada = record
    cant, numEvento, cod: integer;
    dni: longint;
  end;
  lista = ^nodo;
  nodo = record
    dato: entrada;
    sig: lista;
  end;
  vecRecaudaciones = array[1..cantEventos] of integer;

procedure cargarEventos(var v: vecEventos);

  procedure leerEvento(var e: evento);
  var
    i: integer;
    caracteres, strRandom: string;
  begin
    caracteres := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    e.tipo := Random(5) + 1;
    strRandom := '';
    for i := 1 to 6 do
      strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
    e.lugar := strRandom;
    strRandom := '';
    for i := 1 to 6 do
      strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
    e.nom := strRandom;
    e.maxPersonas := Random(21) + 5;
    e.costo := Random(41) + 10;
    e.cupos := e.maxPersonas; // cupos disponible para comprar del evento
  end;

var
  e: evento; i: integer;
begin
  for i := 1 to cantEventos do begin
    leerEvento(e);
    v[i] := e;
  end;
end;

procedure recorrerLista(l: lista; ve: vecEventos);

  procedure inicializarRecaudaciones(var v: vecRecaudaciones);
  var
    i: integer;
  begin
    for i := 1 to cantEventos do
      v[i] := 0;
  end;

  function descomponerDNI(dni: longint): boolean;
  var
    dig, pares, impares: integer;
  begin
    pares := 0; impares := 0;
    while (dni <> 0) do begin
      dig := dni MOD 10;
      if (dig MOD 2 = 0) then 
        pares := pares + 1
      else
        impares := impares + 1;
      dni := dni DIV 10;
    end;
    descomponerDNI := (pares > impares);
  end;

  procedure informarMinsRecaudaciones(vr: vecRecaudaciones; ve: vecEventos);
  var
    i, min1, min2: integer; minNom1, minNom2, minLugar1, minLugar2: string;
  begin
    min1 := 32767; min2 := 32767; minNom1 := ''; minLugar1 := '';
    for i := 1 to cantEventos do
      if (vr[i] < min1) then begin
        min2 := min1; minNom2 := minNom1; minLugar2 := minLugar1;
        min1 := vr[i]; minNom1 := ve[i].nom; minLugar1 := ve[i].lugar;
      end
      else
        if (vr[i] < min2) then begin
          min2 := vr[i]; minNom2 := ve[i].nom; minLugar2 := ve[i].lugar;
        end;
    writeln('Los dos eventos que menos recaudaciones generaron son: ', minNom1 ,' ', minLugar1 ,' y ', minNom2 ,' ', minLugar2);
  end;

var
  cant: integer;
  vr: vecRecaudaciones;
begin
  inicializarRecaudaciones(vr); cant := 0;
  while (l <> nil) do begin
    vr[l^.dato.numEvento] := vr[l^.dato.numEvento] + (l^.dato.cant * ve[l^.dato.numEvento].costo);
    if (ve[l^.dato.numEvento].tipo = 3) and (descomponerDNI(l^.dato.dni)) then
      cant := cant + l^.dato.cant;
    l := l^.sig;
  end;
  informarMinsRecaudaciones(vr, ve);
  writeln('La cantidad de entradas vendidas de eventos del tipo 3 que sus compradores tienen mas digitos pares que impares en su DNI es: ', cant);
  if (ve[5].cupos = 0) then // 5 referenciando al numero 50
    writeln('El evento numero 50 (5) vendio todas sus entradas')
  else
    writeln('El evento numero 50 (5) no vendio todas sus entradas');
end;

procedure cargarEntradas(var l: lista; var v: vecEventos);

  procedure leerEntrada(var e: entrada; l: lista);
  var
    num: integer;
  begin
    num := Random(300) + 1;
    if (num > 270) and (l <> nil) then
      e.cod := -1
    else begin
      e.cod := Random(32000) + 1;
      e.cant := Random(5) + 1;
      e.numEvento := Random(cantEventos) + 1;
      e.dni := Random(20000000) + 25000000;
    end;
  end;

  procedure agregarAdelante(var l: lista; e: entrada);
  var
    nue: lista;
  begin
    new(nue); nue^.dato := e;
    nue^.sig := l;
    l := nue;
  end;

var
  e: entrada;
begin
  leerEntrada(e, l);
  while (e.cod <> -1) do begin
    if (v[e.numEvento].cupos >= e.cant) then begin
      agregarAdelante(l, e);
      v[e.numEvento].cupos := v[e.numEvento].cupos - e.cant;
    end;
    leerEntrada(e, l);
  end;
end;

procedure imprimirEntradas(l: lista);
begin
  writeln('Entradas');
  while (l <> nil) do begin
    writeln('Codigo: ', l^.dato.cod,' | Cantidad de entradas: ', l^.dato.cant,' | Numero de evento: ', l^.dato.numEvento ,' | DNI: ', l^.dato.dni);
    l := l^.sig;
  end;
  writeln();
end;

procedure imprimirEventos(v: vecEventos);
var
  i: integer;
begin
  for i := 1 to cantEventos do
    writeln('Evento ', i , ': Tipo: ', v[i].tipo,' | Lugar: ', v[i].lugar ,' | Nombre: ', v[i].nom ,' | Capacidad maxima de personas: ', v[i].maxPersonas ,' | Costo: ', v[i].costo ,' | Cupos disponibles: ', v[i].cupos);
  writeln();
end;

var
  l: lista; v: vecEventos;
begin
  Randomize;
  l := nil;
  cargarEventos(v); // se dispone
  writeln();
  writeln('Eventos');
  imprimirEventos(v);
  cargarEntradas(l, v);
  imprimirEntradas(l);
  writeln('Eventos despues de cargar las entradas');
  imprimirEventos(v);
  recorrerLista(l, v);
end.