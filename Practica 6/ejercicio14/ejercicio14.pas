{
  La oficina de becas y subsidios desea optimizar los distintos tipos de ayuda financiera que se brinda a
  alumnos de la UNLP. Para ello, esta oficina cuenta con un registro detallado de todos los viajes realizados por
  una muestra de 1300 alumnos durante el mes de marzo. De cada viaje se conoce el código de alumno (entre
  1 y 1300), día del mes, Facultad a la que pertenece y medio de transporte (1. colectivo urbano; 2. colectivo
  interurbano; 3. tren universitario; 4. tren Roca; 5. bicicleta). Tener en cuenta que un alumno puede utilizar
  más de un medio de transporte en un mismo día.
  Además, esta oficina cuenta con una tabla con información sobre el precio de cada tipo de viaje.
  Realizar un programa que lea la información de los viajes de los alumnos y los almacene en una estructura de
  datos apropiada. La lectura finaliza al ingresarse el código de alumno -1, que no debe procesarse.
  Una vez finalizada la lectura, informar:
  a. La cantidad de alumnos que realizan más de 6 viajes por día
  b. La cantidad de alumnos que gastan en transporte más de $80 por día
  c. Los dos medios de transporte más utilizados.
  d. La cantidad de alumnos que combinan bicicleta con algún otro medio de transporte.
}
program ejercicio14;
type
  tipoTransporte = 1..5;
  viaje = record
    diaMes, codAlu: integer;
    facu: string;
    trans: tipoTransporte;
  end;
  lista = ^nodo;
  nodo = record
    dato: viaje;
    sig: lista;
  end;
  vecPrecios = array[1..5] of integer;
  vecCantPorTransporte = array[1..5] of integer;

procedure cargarPrecios(var v: vecPrecios); { no es necesario hacerlo en el final }
var
  i: integer;
begin
  Randomize;
  for i := 1 to 5 do
    v[i] := Random(50) + 1; 
end;

procedure cargarViajes(var l: lista;var vcpt: vecCantPorTransporte);

  procedure leerViaje(var v: viaje);
  begin
    write('Ingrese codigo de alumno: ');readln(v.codAlu);
    if (v.codAlu <> -1) then begin
      write('Ingrese dia del mes: ');readln(v.diaMes);
      write('Ingrese tipo de transporte(1-5): ');readln(v.trans);
      write('Ingrese facultad a la que pertenece: ');readln(v.facu);
      writeln();
    end;
  end;

  procedure insertarOrdenado(var l: lista; v: viaje);
  var
    nue, ant, act: lista;
  begin
    new(nue); nue^.dato := v;
    ant := l; act := l;
    while (act <> nil) and (act^.dato.codAlu < v.codAlu) do begin
      ant := act;
      act := act^.sig;
    end;
    if (act = ant) then
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;

var
  v: viaje;
begin
  leerViaje(v);
  while (v.codAlu <> -1) do begin
    vcpt[v.trans] := vcpt[v.trans] + 1;
    insertarOrdenado(l, v);
    leerViaje(v);
  end;
end;

procedure inicializarCantPorTransporte(var v: vecCantPorTransporte);
var
  i: integer;
begin
  for i := 1 to 5 do
    v[i] := 0;
end;

procedure informarIncisoA_B_D(l: lista; vp: vecPrecios);
var
  aluAct, cantDias, diaAct, totalIncisoA, totalIncisoB, totalIncisoD, valor: integer;
  usaBici, usaOtroTrans: boolean;
begin
  totalIncisoA := 0; totalIncisoB := 0; totalIncisoD := 0;
  while (l <> nil) do begin
    usaBici := false; usaOtroTrans := false;
    aluAct := l^.dato.codAlu; diaAct := l^.dato.diaMes; cantDias := 0; valor := 0;
    while (l <> nil) and (l^.dato.codAlu = aluAct) and (l^.dato.diaMes = diaAct) do begin
      cantDias := cantDias + 1; valor := valor + vp[l^.dato.trans];
      if (not usaBici) then
        usaBici := l^.dato.trans = 5;
      if (not usaOtroTrans) then
        usaOtroTrans := l^.dato.trans <> 5;
      l := l^.sig;
    end;
    if (cantDias > 6) then
      totalIncisoA := totalIncisoA + 1;
    if (valor > 80) then
      totalIncisoB := totalIncisoB + 1;
    if (usaBici) and (usaOtroTrans) then
      totalIncisoD := totalIncisoD + 1;
  end;
  writeln('La cantidad de alumnos que realizan mas de 6 viajes por dia es: ', totalIncisoA);
  writeln('La cantidad de alumnos que gastan mas de 80$ por dia es: ', totalIncisoB);
  writeln('La cantidad de alumnos que combinan bicicleta con algun otro medio de transporte es: ', totalIncisoD);
end;

procedure imprimirPrecios(v: vecPrecios);
var
  i: integer;
begin
  writeln('Precios de los transportes');
  for i := 1 to 5 do
    writeln(i,'. ', v[i]);
  writeln();
end;

procedure informarIncisoC(v: vecCantPorTransporte);
var
  i, max1, max2, maxTrans1, maxTrans2: integer;
begin
  max1 := -1; max2 := -1;
  for i := 1 to 5 do
    if (v[i] <> 0) then begin
      if (v[i] > max1) then begin
        max2 := max1;
        maxTrans2 := maxTrans1;
        max1 := v[i];
        maxTrans1 := i;
      end
      else begin
        if (v[i] > max2) then begin
          max2 := v[i];
          maxTrans2 := i;
        end
      end;
    end;
  if (maxTrans2 > 5) then 
    writeln('El medio de transporte mas utilizado es: ', maxTrans1)
  else
    writeln('Los dos medios de transporte mas utilizados son: ', maxTrans1 ,' y ', maxTrans2);
end;

var
  l: lista;
  vp: vecPrecios;
  vcpt: vecCantPorTransporte;
begin
  l := nil;
  cargarPrecios(vp); { se dispone los precios de los viajes }
  imprimirPrecios(vp);
  inicializarCantPorTransporte(vcpt);
  cargarViajes(l, vcpt);
  informarIncisoA_B_D(l, vp);
  informarIncisoC(vcpt);
end.