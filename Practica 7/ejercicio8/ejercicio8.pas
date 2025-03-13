{
  Una entidad bancaria de la ciudad de La Plata solicita realizar un programa destinado a la
  administración de transferencias de dinero entre cuentas bancarias, efectuadas entre los meses de
  Enero y Noviembre del año 2018.
  El banco dispone de una lista de transferencias realizadas entre Enero y Noviembre del 2018. De cada
  transferencia se conoce: número de cuenta origen, DNI de titular de cuenta origen, número de cuenta
  destino, DNI de titular de cuenta destino, fecha, hora, monto y el código del motivo de la
  transferencia (1: alquiler, 2: expensas, 3: facturas, 4: préstamo, 5: seguro, 6: honorarios y 7: varios).
  Esta estructura no posee orden alguno.
  Se pide:
  a)  Generar una nueva estructura que contenga sólo las transferencias a terceros (son aquellas en las
      que las cuentas origen y destino no pertenecen al mismo titular). Esta nueva estructura debe
      estar ordenada por número de cuenta origen.
      Una vez generada la estructura del inciso a), utilizar dicha estructura para:
  b)  Calcular e informar para cada cuenta de origen el monto total transferido a terceros.
  c)  Calcular e informar cuál es el código de motivo que más transferencias a terceros tuvo.
  d)  Calcular e informar la cantidad de transferencias a terceros realizadas en el mes de Junio en las
      cuales el número de cuenta destino posea menos dígitos pares que impares.
}
program ejercicio8;
const
  cantMotivos = 7;
type
  vecMotivos = array[1..cantMotivos] of integer;
  tipoFecha = record
    dia, mes, anio: integer;
  end;
  transf = record
    origen, destino, dniOrigen, dniDestino: longint;
    fecha: tipoFecha;
    monto, hora: real;
    motivo: integer;
  end;
  lista = ^nodo;
  nodo = record
    dato: transf;
    sig: lista;
  end;

procedure inicializarMotivos(var v: vecMotivos);
var
  i: integer;
begin
  for i := 1 to cantMotivos do
    v[i] := 0;
end;

procedure cargarTransferencias(var l: lista);

  procedure leerTrasnferencia(var t: transf);
  begin
    t.fecha.dia := Random(31) + 1;
    t.fecha.mes := Random(12) + 1;
    t.fecha.anio := 2018;
    t.origen := Random(6) + 1;
    t.destino := Random(6) + 1;
    t.hora := Random(24) + 1;
    t.monto := Random(500000) + 1;
    t.motivo := Random(7) + 1;
    t.dniDestino := Random(25000000) + 25000000;
    t.dniOrigen := Random(25000000) + 25000000;
  end;

  procedure agregarAdelante(var l: lista; t: transf);
  var
    nue: lista;
  begin
    new(nue); nue^.dato := t;
    nue^.sig := l;
    l := nue;
  end;

var
  t: transf; i: integer;
begin
  for i := 1 to 10 do begin
    leerTrasnferencia(t);
    agregarAdelante(l, t);
  end;
end;

procedure cargarLista(l1: lista; var l2: lista);

  procedure insertarOrdenado(var l: lista; t: transf);
  var
    act, ant, nue: lista;
  begin
    new(nue); nue^.dato := t;
    ant := l; act := l;
    while (act <> nil) and (act^.dato.origen < t.origen) do begin
      ant := act; act := act^.sig;
    end;
    if (ant = act) then
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;

begin
  while (l1 <> nil) do begin
    if (l1^.dato.origen <> l1^.dato.destino) then
      insertarOrdenado(l2, l1^.dato);
    l1 := l1^.sig;
  end;
end;

procedure recorrerLista(l: lista; var v: vecMotivos);

  function descomponerDestino(num: integer): boolean;
  var
    dig, pares, impares: integer;
  begin
    pares := 0; impares := 0;
    while (num <> 0) do begin
      dig := num MOD 10;
      if (dig MOD 2 = 0) then
        pares := pares + 1
      else
        impares := impares + 1;
      num := num DIV 10;
    end;
    descomponerDestino := (impares > pares);
  end;

var
  total: real; cant, origenAct: integer;
begin
  cant := 0;
  while (l <> nil) do begin
    origenAct := l^.dato.origen; total := 0;
    while (l <> nil) and (l^.dato.origen = origenAct) do begin
      total := total + l^.dato.monto;
      if (l^.dato.fecha.mes = 6) and (descomponerDestino(l^.dato.destino)) then
        cant := cant + 1;
      v[l^.dato.motivo] := v[l^.dato.motivo] + 1;
      l := l^.sig;
    end;
    writeln('El monto total transferido de la cuenta ', origenAct ,' es: ', total:0:2);
  end;
  writeln('La cantidad de transferencias a terceros en junio con un numero de cuenta destino con menos digitos pares que impares es: ', cant);
end;

procedure imprimirMaxMotivo(v: vecMotivos);
var
  i, max, codMax: integer;
begin
  max := -1;
  for i := 1 to cantMotivos do
    if (v[i] > max) then begin
      max := v[i]; codMax := i;
    end;
  writeln('El codigo de motivo que mas transferencias a terceros tubo es: ', codMax);
end;

procedure imprimirTransferencias(l: lista);
begin
  while (l <> nil) do begin
    writeln('Origen: ', l^.dato.origen ,' | Destino: ', l^.dato.destino,' | DNI origen: ', l^.dato.dniOrigen,' | DNI destino: ', l^.dato.dniDestino,' | Monto: ', l^.dato.monto:0:2,' | Fecha: ', l^.dato.fecha.dia,'/',l^.dato.fecha.mes,'/',l^.dato.fecha.anio,' | Hora: ', l^.dato.hora:0:2,' | Motivo: ', l^.dato.motivo);
    l := l^.sig;
  end;
  writeln();
end;

var
  l1, l2: lista; v: vecMotivos;
begin
  Randomize;
  l1 := nil; l2 := nil;
  inicializarMotivos(v);
  cargarTransferencias(l1); // se dispone
  cargarLista(l1, l2);
  writeln('Transferencia que se disponen');
  imprimirTransferencias(l1);
  writeln('Transferencias hechas a terceros');
  imprimirTransferencias(l2);
  recorrerLista(l2, v);
  imprimirMaxMotivo(v);
end.