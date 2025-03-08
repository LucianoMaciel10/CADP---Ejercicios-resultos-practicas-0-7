{
  Una empresa de transporte de cargas dispone de la información de su flota compuesta por 100
  camiones. De cada camión se tiene: patente, año de fabricación y capacidad (peso máximo en
  toneladas que puede transportar).
  Realizar un programa que lea y almacene la información de los viajes realizados por la empresa. De
  cada viaje se lee: código de viaje, código del camión que lo realizó (1..100), distancia en kilómetros
  recorrida, ciudad de destino, año en que se realizó el viaje y DNI del chofer. La lectura finaliza cuando
  se lee el código de viaje -1.
  Una vez leída y almacenada la información, se pide:
  1.  Informar la patente del camión que más kilómetros recorridos posee y la patente del camión que
      menos kilómetros recorridos posee.
  2.  Informar la cantidad de viajes que se han realizado en camiones con capacidad mayor a 30,5
      toneladas y que posean una antigüedad mayor a 5 años al momento de realizar el viaje (año en
      que se realizó el viaje).
  3.  Informar los códigos de los viajes realizados por choferes cuyo DNI tenga sólo dígitos impares.
  Nota: Los códigos de viaje no se repiten.
}
program ejercicio5;
const
  cantCamiones = 10; // 100
  
type
  tipoCamion = 1..cantCamiones;
  camion = record
    patente: string;
    capacidad: real;
    anioFab: integer;
  end;
  viaje = record
    anio, cod, distancia: integer;
    codCamion: tipoCamion;
    destino: string;
    dni: longint;
  end;
  vecCamiones = array[tipoCamion] of camion;
  lista = ^nodo;
  nodo = record
    dato: viaje;
    sig: lista;
  end;

procedure cargarCamiones(var v: vecCamiones);

  procedure leerCamion(var c: camion);
  var
    caracteres, strRandom: string;
    i: integer;
  begin
    caracteres := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    strRandom := '';
    for i := 1 to 6 do
      strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
    c.patente := strRandom;
    c.capacidad := (Random(61) + 20) + Random * 0.9;
    c.anioFab := Random(21) + 2015;
  end;

var
  i: integer; c: camion;
begin
  for i := 1 to cantCamiones do begin
    leerCamion(c);
    v[i] := c;
  end;
  writeln('Se cargaron los datos de ', cantCamiones ,' camiones');
end;

procedure cargarViajes(var l: lista);
// simulacion de cargar una cantidad aleatoria de viajes para hacer pruebas automaticas
  procedure insertarOrdenado(var l: lista; v: viaje);
  var
    ant, act, nue: lista;
  begin
    new(nue); nue^.dato := v;
    ant := l; act := l;
    while (act <> nil) and (act^.dato.codCamion <> v.cod) do begin
      ant := act; act := act^.sig;
    end;
    if (ant = act) then
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;

var
  caracteres, strRandom: string;
  i, j, randomNumber: integer;
  v: viaje;
begin
  randomNumber := Random(31) + 1;
  for i := 1 to randomNumber do begin
    v.cod := i;
    caracteres := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    strRandom := '';
    for j := 1 to 6 do
      strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
    v.DNI := Random(15000000) + 25000000;
    v.destino := strRandom; 
    v.codCamion := Random(cantCamiones) + 1; 
    v.distancia := Random(35) + 15;
    v.anio := Random(11) + 2025;
    insertarOrdenado(l, v);
  end;
  writeln('Se cargaron datos de ', randomNumber ,' viajes!');
end;

procedure recorrerLista(l: lista; v: vecCamiones);

  procedure calcularMaxMin(distancia: integer; patente: string; var max, min: integer; var maxPatente, minPatente: string);
  begin
    if (distancia > max) then begin
      max := distancia; maxPatente := patente;
    end;
    if (distancia < min) then begin
      min := distancia; minPatente := patente;
    end;
  end;

  procedure descomponerDNI(cod: integer; dni: longint);
  var
    seguir: boolean;
    num, dig: integer;
  begin
    num := dni; seguir := true;
    while (num <> 0) and (seguir) do begin
      dig := num MOD 10;
      if (dig MOD 2 <> 0) then
        seguir := false;
      num := num DIV 10;
    end;
    if (seguir) then
      writeln('El chofer del viaje ', cod ,' tiene solo digitos impares en su DNI');
  end;

var
  max, min, cant, codAct, totalDistancia: integer; maxPatente, minPatente: string;
begin
  max := -1; min := 32767; cant := 0;
  while (l <> nil) do begin
    codAct := l^.dato.codCamion; totalDistancia := 0;
    while (l <> nil) and (codAct = l^.dato.codCamion) do begin
      totalDistancia := totalDistancia + l^.dato.distancia;
      if (v[l^.dato.codCamion].capacidad > 30.5) and ((l^.dato.anio - v[l^.dato.codCamion].anioFab) > 5) then
        cant := cant + 1;
      descomponerDNI(l^.dato.cod, l^.dato.dni);
      l := l^.sig;
    end;
    calcularMaxMin(totalDistancia, v[codAct].patente, max, min, maxPatente, minPatente);
  end;
  writeln('La patente del camion con menos KM recorridos es: ', minPatente);
  writeln('La patente del camion con mas KM recorridos es: ', maxPatente);
  writeln('Cantidad de camiones con capacidad mayor a 30,5 y con mas de 5 anios de antiguedad: ', cant);
end;

procedure imprimirCamiones(v: vecCamiones);
var
  i: integer;
begin
  writeln('Camiones');
  for i := 1 to cantCamiones do
    writeln(i,'. ', 'Patente: ', v[i].patente , ' | Capacidad: ', v[i].capacidad:0:2 , ' | Anio de fabricacion: ', v[i].anioFab);
  writeln();
end;

procedure imprimirViajes(l: lista);
begin
  writeln('Viajes');
  while (l <> nil) do begin
    writeln('Codigo de camion: ', l^.dato.codCamion ,' | Codigo de viaje: ', l^.dato.cod ,' | Distancia: ', l^.dato.distancia ,' | Anio del viaje: ', l^.dato.anio ,' | Destino: ', l^.dato.destino ,' | DNI: ', l^.dato.dni);
    l := l^.sig;
  end;
  writeln();
end;

var
  l: lista; v: vecCamiones;
begin
  Randomize;
  l := nil;
  cargarCamiones(v); // en el inciso esto se dispone
  cargarViajes(l);
  imprimirCamiones(v);
  imprimirViajes(l);
  recorrerLista(l, v);
end.