{
  Una productora nacional realiza un casting de personas para la selección de actores extras de una
  nueva película, para ello se debe leer y almacenar la información de las personas que desean
  participar de dicho casting. De cada persona se lee: DNI, apellido y nombre, edad y el código de
  género de actuación que prefiere (1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror). La lectura
  finaliza cuando llega una persona con DNI 33555444, la cual debe procesarse.
  Una vez finalizada la lectura de todas las personas, se pide:
  a.  Informar la cantidad de personas cuyo DNI contiene más dígitos pares que impares.
  b.  Informar los dos códigos de género más elegidos.
  c.  Realizar un módulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede no
      existir. Invocar dicho módulo en el programa principal.
}
program ejercicio1;
const
  fin = 33555444;
type
  tipoGenero = 1..5;
  persona = record
    dni: longint;
    nom, ape: string;
    edad: integer;
    genero: tipoGenero;
  end;
  lista = ^nodo;
  nodo = record
    dato: persona;
    sig: lista;
  end;
  vecGeneros = array[1..5] of integer;

procedure cargarLista(var l: lista);

  procedure leerPersona(var p: persona);
  begin
    write('Ingrese dni: ');readln(p.dni);
    write('Ingrese genero: ');readln(p.genero);
    write('Ingrese edad: ');readln(p.edad);
    write('Ingrese nombre: ');readln(p.nom);
    write('Ingrese apellido: ');readln(p.ape);
    writeln();
  end;

  procedure agregarAdelante(var l: lista; p: persona);
  var
    nue: lista;
  begin
    new(nue); nue^.dato := p;
    nue^.sig := l;
    l := nue;
  end;
  
var
  p: persona;
begin
  repeat
    leerPersona(p);
    agregarAdelante(l, p);
  until (l^.dato.dni = fin);
end;

procedure inicializarGeneros(var v: vecGeneros);
var
  i: integer;
begin
  for i := 1 to 5 do
    v[i] := 0;
end;

procedure informarIncisosAyB(l: lista; v: vecGeneros);

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

  procedure calcularGenerosMaximos(v: vecGeneros; var genMax1, genMax2: integer);
  var
    i, max1, max2: integer;
  begin
    max1 := -1; max2 := -1;
    for i := 1 to 5 do
      if (v[i] > max1) then begin
        max2 := max1;
        genMax2 := genMax1;
        max1 := v[i];
        genMax1 := i;
      end
      else
        if (v[i] > max2) then begin
          max2 := v[i];
          genMax2 := i;
        end;
  end;

var
  cantDNImasPares, genMax1, genMax2: integer;
begin
  cantDNImasPares := 0;
  while (l <> nil) do begin
    if (descomponerDNI(l^.dato.dni)) then
      cantDNImasPares := cantDNImasPares + 1;
    v[l^.dato.genero] := v[l^.dato.genero] + 1;
    l := l^.sig;
  end;
  calcularGenerosMaximos(v, genMax1, genMax2);
  writeln('La cantidad de personas con mas digitos pares que impares en su DNI es: ', cantDNImasPares);
  if (genMax2 = 0) then
    writeln('El genero mas elegido es: ', genMax1)
  else
    writeln('Los dos generos mas elegidos son: ', genMax1 ,' y ', genMax2);
end;

procedure eliminarDNI(var l: lista; dni: longint);
var
  ant, act: lista;
begin
  act := l;
  while (act <> nil) and (act^.dato.dni <> dni) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act <> nil) then begin
    if (act = l) then
      l := l^.sig
    else
      ant^.sig := act^.sig;
    dispose(act);
  end;
end;

procedure imprimirLista(l: lista);
begin
  while (l <> nil) do begin
    writeln('DNI: ', l^.dato.dni);
    l := l^.sig;
  end;
  writeln();
end;

var
  l: lista;
  v: vecGeneros;
  dni: longint;
begin
  l := nil;
  inicializarGeneros(v);
  cargarLista(l);
  imprimirLista(l);
  informarIncisosAyB(l, v);
  write('Ingrese un dni para eliminarlo de la lista: ');readln(dni);
  eliminarDNI(l, dni);
  imprimirLista(l);
end.