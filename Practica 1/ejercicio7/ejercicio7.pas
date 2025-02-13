{
  Realizar un programa que lea el código, el precio actual y el nuevo precio de los productos de un
  almacén. La lectura finaliza al ingresar el producto con el código 32767, el cual debe procesarse.
  Para cada producto leído, el programa deberá indicar si el nuevo precio del producto supera en un
  10% al precio anterior.
  Por ejemplo:
  ○ Si se ingresa el código 10382, con precio actual 40, y nuevo precio 44, deberá imprimir: “el
    aumento de precio del producto 10382 no supera el 10%”
  ○ Si se ingresa el código 32767, con precio actual 30 y nuevo precio 33,01, deberá imprimir: “el
    aumento de precio del producto 32767 es superior al 10%”
}
program ejercicio7;
const
  fin = 32767;
var
  cod: integer; precio, nuePrecio: real;
begin
  write('Ingrese codigo de producto: ');readln(cod);
  write('Ingrese precio actual: ');readln(precio);
  write('Ingrese precio nuevo: ');readln(nuePrecio);
  if (abs(precio - nuePrecio) > nuePrecio*10/100) then
    writeln('El precio nuevo supera en 10% al precio anterior');
  while(cod <> fin) do begin
    write('Ingrese codigo de producto: ');readln(cod);
    write('Ingrese precio actual: ');readln(precio);
    write('Ingrese precio nuevo: ');readln(nuePrecio);
    if (abs(precio - nuePrecio) > nuePrecio*10/100) then
      writeln('El precio nuevo supera en 10% al precio anterior');
  end;
end.