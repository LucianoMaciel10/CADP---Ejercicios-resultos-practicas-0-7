{
  Realizar un programa que lea información de 200 productos de un supermercado. De cada producto
  se lee código y precio (cada código es un número entre 1 y 200). Informar en pantalla:
  - Los códigos de los dos productos más baratos.
  - La cantidad de productos de más de 16 pesos con código par.
}
program ejercicio15;
var
  cod, minCod1, minCod2, i, prodSup16par: integer; precio, minPrecio1, minPrecio2: real;
begin
  minPrecio1 := 32767; minPrecio2 := 32767; prodSup16par := 0;
  for i := 1 to 5 do begin
    write('Ingrese codigo: ');readln(cod);
    while (cod > 200) and (cod < 1) do begin
      writeln('El codigo de producto no puede ser menor que 1 ni mayor que 200, pruebe nuevamente.');
      write('Ingrese codigo: ');readln(cod);
    end;
    write('Ingrese precio: ');readln(precio);
    if (precio > 16) and (cod MOD 2 = 0) then
      prodSup16par := prodSup16par + 1;
    if (precio < minPrecio1) then begin
      minPrecio2 := minPrecio1;
      minPrecio1 := precio;
      minCod2 := minCod1;
      minCod1 := cod;
    end
    else begin
      if (precio < minPrecio2) then begin
        minPrecio2 := precio;
        minCod2 := cod;
      end;
    end;
  end;
  writeln('Productos mas baratos: ', minCod1, ' y ', minCod2);
  writeln('Productos con codigo par y precio mayor a 16: ', prodSup16par);
end.