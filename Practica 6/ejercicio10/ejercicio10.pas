{
  Una empresa de sistemas está desarrollando un software para organizar listas de espera de clientes. Su
  funcionamiento es muy sencillo: cuando un cliente ingresa al local, se registra su DNI y se le entrega un
  número (que es el siguiente al último número entregado). El cliente quedará esperando a ser llamado por su
  número, en cuyo caso sale de la lista de espera. Se pide:
  a.  Definir una estructura de datos apropiada para representar la lista de espera de clientes.
  b.  Implementar el módulo RecibirCliente, que recibe como parámetro el DNI del cliente y la lista de clientes
      en espera, asigna un número al cliente y retorna la lista de espera actualizada.
  c.  Implementar el módulo AtenderCliente, que recibe como parámetro la lista de clientes en espera, y retorna
      el número y DNI del cliente a ser atendido y la lista actualizada. El cliente atendido debe eliminarse de la lista
      de espera.
  d.  Implementar un programa que simule la atención de los clientes. En dicho programa, primero llegarán
      todos los clientes juntos, se les dará un número de espera a cada uno de ellos, y luego se los atenderá de a
      uno por vez. El ingreso de clientes se realiza hasta que se lee el DNI 0, que no debe procesarse.
}
program ejercicio10;
type
  cliente = record
    dni, num: longint;
  end;
  lista = ^nodo;
  nodo = record
    dato: cliente; 
    sig: lista;
  end;

procedure recibirCliente(var l: lista; dni: longint);
var
  nue, aux: lista;
begin
  new(nue); nue^.dato.dni := dni; nue^.sig := nil;
  if (l = nil) then begin
    nue^.dato.num := 1;
    l := nue;
  end
  else begin
    aux := l; 
    while (aux^.sig <> nil) do 
      aux := aux^.sig;
    nue^.dato.num := aux^.dato.num + 1;
    aux^.sig := nue;
  end;
end;


procedure atenderClientes(var l: lista);

  procedure atenderCliente(var l: lista;var num, dni: longint);
  var
    act := lista;
  begin
    act := l;
    num := l^.dato.num;
    dni := l^.dato.dni;
    l := l^.sig;
    dispose(act);
  end;

var
  num, dni: longint;
begin
  while (l <> nil) do begin
    atenderCliente(l, num, dni);
    writeln('Cliente numero ', num ,' con DNI: ', dni ,' fue atendido');
  end;
end;

procedure imprimirClientes(l: lista);
begin
  while (l <> nil) do begin
    writeln('Numero: ', l^.dato.num ,' | DNI: ', l^.dato.dni);
    l := l^.sig;
  end;
  writeln();
end;

var
  dni: longint;
  l: lista;
begin
  l := nil; 
  write('Ingrese dni: ');readln(dni);
  while (dni <> 0) do begin
    recibirCliente(l, dni);
    write('Ingrese dni: ');readln(dni);
  end;
  writeln();
  writeln('Clientes en lista de espera');
  imprimirClientes(l);
  atenderClientes(l);
  imprimirClientes(l);
end.