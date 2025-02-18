{
  Una empresa de transporte de caudales desea optimizar el servicio que brinda a sus clientes. Para ello,
  cuenta con información sobre todos los viajes realizados durante el mes de marzo. De cada viaje se cuenta
  con la siguiente información: día del mes (de 1 a 31), monto de dinero transportado y distancia recorrida
  por el camión (medida en kilómetros).
  a.  Realizar un programa que lea y almacene la información de los viajes (a lo sumo 200). La lectura finaliza
      cuando se ingresa una distancia recorrida igual a 0 km, que no debe procesarse.
  b.  Realizar un módulo que reciba el vector generado en a) e informe:
        - El monto promedio transportado de los viajes realizados
        - La distancia recorrida y el día del mes en que se realizó el viaje que transportó menos dinero.
        - La cantidad de viajes realizados cada día del mes.
  c.  Realizar un módulo que reciba el vector generado en a) y elimine todos los viajes cuya distancia
      recorrida sea igual a 100 km.
      Nota: para realizar el inciso b, el vector debe recorrerse una única vez.
}
program ejercicio3;
const
  dimF = 200;
  maxDias = 31;

type
  rangoDias = 1..maxDias;
  viaje = record
    dia: rangoDias;
    monto, dist: integer;
  end;
  vecViajes = array[1..dimF] of viaje;
  vecViajesPorDia = array[rangoDias] of integer;

procedure leerViaje(var v: viaje);
begin
  write('Ingresar distancia recorrida: ');readln(v.dist);
  if (v.dist <> 0) then begin
    write('Ingresar dia del mes: ');readln(v.dia);
    write('Ingresar monto transportado: ');readln(v.monto);
    writeln();
  end;
end;
  
procedure cargarVector(var vec: vecViajes;var dimL: integer);
var
  via: viaje;
begin
  leerViaje(via);
  while (dimL < dimF) and (via.dist <> 0) do begin
    dimL := dimL + 1;
    vec[dimL] := via;
    leerViaje(via);
  end;
end;

procedure imprimirCantViajesPorDia(v: vecViajesPorDia);
var
  i: integer;
begin
  for i := 1 to maxDias do
    if (v[i] > 0) then
      writeln('El dia ', i ,' se hicieron ', v[i] ,' viajes');
  writeln();
end;

procedure imprimirViajes(v: vecViajes; dimL: integer);
var
  i: integer;
begin
  for i := 1 to dimL do begin
    writeln('Dia: ', v[i].dia,'| Distancia: ', v[i].dist, '| Monto: ', v[i].monto);
    writeln();
  end;
end;

procedure ejercicioB(v: vecViajes; dimL: integer; var vVporD: vecViajesPorDia);
var
  montoTotal, i, min, distMin: integer;
  diaMin: rangoDias;
begin
  montoTotal := 0; min := 32767;
  for i := 1 to dimL do begin
    vVporD[v[i].dia] := vVporD[v[i].dia] + 1;
    montoTotal := montoTotal + v[i].monto;
    if (v[i].monto < min) then begin
      min := v[i].monto;
      distMin := v[i].dist;
      diaMin := v[i].dia;
    end;
  end;
  writeln();
  writeln('El monto promedio transportado de los viajes realizados es: ', (montoTotal / dimL):0:2);
  writeln('La distancia recorrida y el dia del mes en que se realizo el viaje que transporto menos dinero: ', distMin,' ', diaMin);
  writeln();
  imprimirCantViajesPorDia(vVporD);
end;

procedure inicializarViajesPorDia(var v: vecViajesPorDia);
var
  i: integer;
begin
  for i := 1 to maxDias do
    v[i] := 0;
end;

procedure eliminarViajesDist100(var v: vecViajes;var dimL: integer);
var
  pos, i: integer;
begin
  pos := 1;
  while (pos <= dimL) do begin
    while (pos <= dimL) and (v[pos].dist <> 100) do
      pos := pos + 1;
    if (pos <= dimL) and (v[pos].dist = 100) then begin
      for i := pos to dimL - 1 do 
        v[i] := v[i + 1];
      dimL := dimL - 1;
    end;
  end;
end;

var
  dimL: integer;
  v: vecViajes;
  vVporD: vecViajesPorDia;
begin
  dimL := 0;
  cargarVector(v, dimL);
  inicializarViajesPorDia(vVporD);
  ejercicioB(v, dimL, vVporD);
  writeln('Viajes antes de eliminar los que tienen distancia igual a 100');
  imprimirViajes(v, dimL);
  eliminarViajesDist100(v, dimL);
  writeln('Viajes despues de eliminar los que tienen distancia igual a 100');
  imprimirViajes(v, dimL);
end.