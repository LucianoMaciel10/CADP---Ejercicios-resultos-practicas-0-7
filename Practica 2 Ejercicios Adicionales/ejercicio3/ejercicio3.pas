{
  Realizar un programa modularizado que lea información de 200 productos de un supermercado. De cada
  producto se lee código y precio (cada código es un número entre 1 y 200). Informar en pantalla:
    ● Los códigos de los dos productos más baratos.
    ● La cantidad de productos de más de 16 pesos con código par.
}
program ejercicio3;
const
  cantProductos = 10;

procedure leerProducto (var cod: integer; var precio: real);
begin
  write('Ingrese codigo de producto (1-200): ');readln(cod);
  while (cod < 1) or (cod > 200) do begin
    writeln('Codigo incorrecto, intente denuevo...');
    write('Ingrese codigo de producto (1-200): ');readln(cod);
  end;
  write('Ingrese precio de producto: ');readln(precio);
  writeln();
end;

procedure calcularProductosMasBaratos(cod: integer; precio: real; var codMin1, codMin2: integer;var precioMin1, precioMin2: real);
begin
  if (precio < precioMin1) then begin
    codMin2 := codMin1;
    precioMin2 := precioMin1;
    precioMin1 := precio;
    codMin1 := cod;
  end
  else begin
    if (precio < precioMin2) then begin
      precioMin2 := precio;
      codMin2 := cod;
    end;
  end;
end;

procedure calcularProductosSup16Par(cod: integer; precio: real; var cantSup16CodPar: integer);
begin
  if (cod MOD 2 = 0) and (precio > 16) then
    cantSup16CodPar := cantSup16CodPar + 1;
end;

var
  cod, codMin1, codMin2, cantSup16CodPar, i: integer;
  precio, precioMin1, precioMin2: real;
begin
  precioMin1 := 32767; precioMin2 := 32767; cantSup16CodPar := 0;
  for i := 1 to cantProductos do begin
    leerProducto(cod, precio);
    calcularProductosMasBaratos(cod, precio, codMin1, codMin2, precioMin1, precioMin2);
    calcularProductosSup16Par(cod, precio, cantSup16CodPar);
  end;
  writeln('Los codigos de los dos productos mas baratos son: ', codMin1,' y ', codMin2);
  writeln('La cantidad de productos de mas de 16 pesos con codigo par es: ', cantSup16CodPar);
end.