{
  Implementar un programa que lea y almacene información de clientes de una empresa aseguradora
  automotriz. De cada cliente se lee: código de cliente, DNI, apellido, nombre, código de póliza
  contratada (1..6) y monto básico que abona mensualmente. La lectura finaliza cuando llega el cliente
  con código 1122, el cual debe procesarse.
  La empresa dispone de una tabla donde guarda un valor que representa un monto adicional que el
  cliente debe abonar en la liquidación mensual de su seguro, de acuerdo al código de póliza que tiene
  contratada.
  Una vez finalizada la lectura de todos los clientes, se pide:
  a.  Informar para cada cliente DNI, apellido, nombre y el monto completo que paga mensualmente
      por su seguro automotriz (monto básico + monto adicional).
  b.  Informar apellido y nombre de aquellos clientes cuyo DNI contiene al menos dos dígitos 9.
  c.  Realizar un módulo que reciba un código de cliente, lo busque (seguro existe) y lo elimine de la estructura.
}
program ejercicio2;
const
  fin = 1122;
type
  tipoPoliza = 1..6;
  cliente = record
    dni: longint;
    ape, nom: string;
    monto, cod: integer;
    poliza: tipoPoliza;
  end;
  vecMontos = array[tipoPoliza] of integer;
  lista = ^nodo;
  nodo = record
    dato: cliente;
    sig: lista;
  end;

procedure cargarMontosAdicionales(var v: vecMontos);
var
  i: integer;
begin
  for i := 1 to 6 do
    v[i] := Random(101) + 100;
end;

procedure cargarLista(var l: lista);

  procedure leerCliente(var c: cliente);
  begin
    write('Ingrese codigo: ');readln(c.cod);
    write('Ingrese codigo de poliza contratada: ');readln(c.poliza);
    write('Ingrese monto basico: ');readln(c.monto);
    write('Ingrese dni: ');readln(c.dni);
    write('Ingrese nombre: ');readln(c.nom);
    write('Ingrese aprellido: ');readln(c.ape);
    writeln();
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
  repeat
    leerCliente(c);
    agregarAdelante(l, c);
  until (c.cod = fin);
end;

procedure informarIncisosAyB(l: lista; v: vecMontos);

  function contieneDosNueves(dni: longint): boolean;
  var
    dig, cant: integer;
  begin
    cant := 0;
    while (dni <> 0) do begin
      dig := dni MOD 10;
      if (dig = 9) then
        cant := cant + 1;
      dni := dni DIV 10;
    end;
    contieneDosNueves := (cant >= 2);
  end;

begin
  while (l <> nil) do begin
    writeln('DNI: ', l^.dato.dni ,' | Apellido: ', l^.dato.ape ,' | Nombre: ', l^.dato.nom ,' | Monto total mensual a pagar: ', l^.dato.monto + v[l^.dato.poliza]);
    if (contieneDosNueves(l^.dato.dni)) then
      writeln('EL cliente ', l^.dato.ape ,' ', l^.dato.nom ,' tiene almenos dos digitos nueve en su DNI');
    l := l^.sig;
  end;
  writeln();
end;

procedure eliminarCliente(var l: lista; cod: integer);
var
  ant, act: lista;
begin
  act := l;
  while (act^.dato.cod <> cod) do begin // porque seguro existe
    ant := act;
    act := act^.sig;
  end;
  if (act = l) then
    l := l^.sig
  else
    ant^.sig := act^.sig;
  dispose(act);
end;

procedure imprimirMontosAdicionales(v: vecMontos);
var
  i: integer;
begin
  for i := 1 to 6 do
    writeln(i,'. ', v[i],'$');
  writeln();
end;

var
  l: lista;
  cod: integer;
  v: vecMontos;
begin
  Randomize;
  l := nil;
  cargarMontosAdicionales(v);
  cargarLista(l);
  imprimirMontosAdicionales(v);
  informarIncisosAyB(l, v);
  write('Ingrese un codigo de cliente para eliminarlo: ');readln(cod);
  eliminarCliente(l, cod);
  informarIncisosAyB(l, v);
end.