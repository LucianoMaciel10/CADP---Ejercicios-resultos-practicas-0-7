{
  Realizar un programa modularizado que lea datos de 100 productos de una tienda de ropa. Para cada
  producto debe leer el precio, código y tipo (pantalón, remera, camisa, medias, campera, etc.). Informar:
  ● Código de los dos productos más baratos.
  ● Código del producto de tipo “pantalón” más caro.
  ● Precio promedio.
}
program ejercicio6;
const
  cantProd = 5;

procedure leerProducto(var precio: real; var codigo: integer; var tipo: string);
begin
  write('Ingrese codigo: ');readln(codigo);
  write('Ingrese tipo: ');readln(tipo);
  write('Ingrese precio: ');readln(precio);
  writeln();
end;

procedure actualizarMasBaratos(precio: real; codigo: integer;var precioMin1, precioMin2: real;var codMin1, codMin2: integer);
begin
  if (precio < precioMin1) then begin
    precioMin2 := precioMin1;
    codMin2 := codMin1;
    precioMin1 := precio;
    codMin1 := codigo;
  end
  else begin
    if (precio < precioMin2) then begin
      precioMin2 := precio;
      codMin2 := codigo;
    end;
  end;
end;

procedure actualizarPantalonMasCaro(codigo :integer; precio: real;var precioPantMax:real;var codPantMax: integer);
begin
  if (precio > precioPantMax) then begin
    precioPantMax := precio;
    codPantMax := codigo
  end;
end;

var
  precio, precioMin1, precioMin2, precioPantMax, totalPrecios: real;
  codigo, codMin1, codMin2, codPantMax, i: integer;
  tipo: string;
begin
  precioMin1 := 32767; precioMin2 := 32767; precioPantMax := -1; totalPrecios := 0;
  for i := 1 to cantProd do begin
    leerProducto(precio, codigo, tipo);
    actualizarMasBaratos(precio, codigo, precioMin1, precioMin2, codMin1, codMin2);
    if (tipo = 'pantalon') or (tipo = 'Pantalon') then
      actualizarPantalonMasCaro(codigo, precio, precioPantMax, codPantMax);
    totalPrecios := totalPrecios + precio;
  end;
  writeln('Codigo de los dos productos mas baratos: ', codMin1,' y ', codMin2);
  writeln('Codigo de el pantalon mas caro: ', codPantMax);
  writeln('Precio promedio de los productos: ', totalPrecios/cantProd:0:2);
end.