{
  Una remisería dispone de información acerca de los viajes realizados durante el mes de mayo de
  2020. De cada viaje se conoce: número de viaje, código de auto, dirección de origen, dirección de
  destino y kilómetros recorridos durante el viaje. Esta información se encuentra ordenada por código
  de auto y para un mismo código de auto pueden existir 1 o más viajes. Se pide:
  a. Informar los dos códigos de auto que más kilómetros recorrieron.
  b. Generar una lista nueva con los viajes de más de 5 kilómetros recorridos, ordenada por número de viaje.
}
program ejercicio3;
type  
  viaje = record
    num, codAuto, km: integer;
    origen, destino: string;
  end;
  lista = ^nodo;
  nodo = record
    dato: viaje;
    sig: lista;
  end;

procedure cargarLista(var l: lista);

  procedure leerViaje(var v: viaje);
  begin
    v.num := Random(30000) + 1;
    v.km := Random(10) + 1; 
    v.codAuto := Random(5) + 1;
  end;

  procedure insertarOrdenado(var l: lista; v: viaje);
  var
    ant, act, nue: lista;
  begin
    new(nue); nue^.dato := v;
    ant := l; act := l;
    while (act <> nil) and (act^.dato.codAuto < v.codAuto) do begin
      ant := act;
      act := act^.sig;
    end;
    if (ant = act) then
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;

var
  i: integer;
  v: viaje;
begin
  for i := 1 to 10 do begin
    leerViaje(v);
    insertarOrdenado(l, v);
  end;
end;

procedure incisosAyB(l1: lista; var l2: lista);

  procedure calcularMaxAutos(cantKm, codAct: integer; var max1, max2, codMax1, codMax2: integer);
  begin
    if (cantKm > max1) then begin
      max2 := max1; codMax2 := codMax1;
      max1 := cantKm; codMax1 := codAct;
    end
    else
      if (cantKm > max2) then  begin
        max2 := cantKm; codMax2 := codAct;
      end;
  end;

  procedure insertarOrdenado(var l: lista; v: viaje);
  var
    ant, act, nue: lista;
  begin
    new(nue); nue^.dato := v;
    ant := l; act := l;
    while (act <> nil) and (act^.dato.num < v.num) do begin
      ant := act;
      act := act^.sig;
    end;
    if (ant = act) then
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;

var
  codAct, max1, max2, codMax1, codMax2, cantKm: integer;
begin
  max1 := -1; max2 := -1;
  while (l1 <> nil) do begin
    codAct := l1^.dato.codAuto; cantKm := 0;
    while (l1 <> nil) and (l1^.dato.codAuto = codAct) do begin
      cantKm := cantKm + l1^.dato.km;
      if (l1^.dato.km > 5) then
        insertarOrdenado(l2, l1^.dato);
      l1 := l1^.sig;
    end;
    calcularMaxAutos(cantKm, codAct, max1, max2, codMax1, codMax2);
  end;
  writeln('Los dos autos con mas km recorridos son: ', codMax1 ,' y ', codMax2);writeln();
end;

procedure imprimirLista(l: lista);
begin
  while (l <> nil) do begin
    writeln('Numero de viaje: ', l^.dato.num ,' | Codigo de auto: ', l^.dato.codAuto ,' | Km recorridos: ', l^.dato.km);
    l := l^.sig;
  end;
  writeln();
end;

var
  l1, l2: lista;
begin
  Randomize;
  l1 := nil; l2 := nil;
  cargarLista(l1); // se dispone
  writeln('Lista 1');
  imprimirLista(l1);
  incisosAyB(l1, l2);
  writeln('Lista 2');
  imprimirLista(l2);
end.