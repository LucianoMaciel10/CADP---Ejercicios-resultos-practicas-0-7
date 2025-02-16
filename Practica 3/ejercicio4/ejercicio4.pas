{
  Una compañía de telefonía celular debe realizar la facturación mensual de sus 9300 clientes con planes de
  consumo ilimitados (clientes que pagan por lo que consumen). Para cada cliente se conoce su código de cliente y
  cantidad de líneas a su nombre. De cada línea se tiene el número de teléfono, la cantidad de minutos consumidos
  y la cantidad de MB consumidos en el mes. Se pide implementar un programa que lea los datos de los clientes de
  la compañía e informe el monto total a facturar para cada uno. Para ello, se requiere:
  a. Realizar un módulo que lea la información de una línea de teléfono.
  b.  Realizar un módulo que reciba los datos de un cliente, lea la información de todas sus líneas (utilizando el
      módulo desarrollado en el inciso a. ) y retorne la cantidad total de minutos y la cantidad total de MB a facturar
      del cliente.
  Nota: para realizar los cálculos tener en cuenta que cada minuto cuesta $3,40 y cada MB consumido cuesta $1,35.
}
program ejercicio4;
const
  cantClientes = 9300;
  costoMinu = 3.40;
  costoMB = 1.35;

type
  cliente = record
    cod, cantLineas: integer;
  end;
  linea = record
    num, cantMinu, cantMB: integer;
  end;

procedure leerCliente(var cli: cliente);
begin
  writeln('Lectura de cliente');
  write('Ingrese codigo: ');readln(cli.cod);
  write('Ingrese cantidad de lineas: ');readln(cli.cantLineas);
  writeln();
end;

procedure leerLinea(var l: linea);
begin
  write('Ingrese el numero: ');readln(l.num);
  write('Ingrese cantidad de minutos usada: ');readln(l.cantMinu);
  write('Ingrese cantidad de MB usados: ');readln(l.cantMB);
  writeln();
end;

procedure leerLineasYfacturacionDelCliente(cli: cliente;var totalMinu, totalMB: integer);
var
  i: integer;
  l: linea;
begin
  writeln('Lectura de lineas del cliente ', cli.cod);
  for i := 1 to cli.cantLineas do begin
    leerLinea(l);
    totalMinu := totalMinu + l.cantMinu;
    totalMB := totalMB + l.cantMB;
  end;
end;

var
  i, totalMinu, totalMB: integer;
  cli: cliente;
begin
  writeln('Lectura de clientes de una compania de telefonia celular');
  for i := 1 to cantClientes do begin
    totalMB := 0; totalMinu := 0;
    leerCliente(cli);
    leerLineasYfacturacionDelCliente(cli, totalMinu, totalMB);
    writeln('Cliente ', cli.cod ,', usar la linea ', totalMinu ,' minutos, debe pagar: $', (totalMinu * costoMinu):0:2);
    writeln('Cliente ', cli.cod ,', por usar ', totalMB ,' MB, debe pagar: $', (totalMB * costoMB):0:2);
    writeln();
  end;
end.