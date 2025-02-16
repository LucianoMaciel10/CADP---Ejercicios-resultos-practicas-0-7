{
  Realizar un programa que lea información de autos que están a la venta en una concesionaria. De cada auto se lee:
  marca, modelo y precio. La lectura finaliza cuando se ingresa la marca “ZZZ” que no debe procesarse. La
  información se ingresa ordenada por marca. Se pide calcular e informar:
  a. El precio promedio por marca.
  b. Marca y modelo del auto más caro.
}
program ejercicio5;
type
  auto = record
    marca: string;
    modelo: integer;
    precio: real;
  end;

procedure leerAuto(var a: auto);
begin
  write('Ingrese marca: ');readln(a.marca);
  if (a.marca <> 'ZZZ') then begin
    write('Ingrese modelo: ');readln(a.modelo);
    write('Ingrese precio: ');readln(a.precio);
    writeln('');
  end;
end;

procedure calcularAutoMasCaro(a: auto;var marcaMax: string;var modeloMax:integer;var precioMax: real);
begin
  if (a.precio > precioMax) then begin
    precioMax := a.precio;
    marcaMax := a.marca;
    modeloMax := a.modelo;
  end;
end;

var
  a: auto;
  precioTotalMarcaAct, precioMax: real;
  marcaAct, marcaMax: string;
  cantAutoMarcaAct, modeloMax: integer;
begin
  precioMax := -1;
  leerAuto(a);
  while (a.marca <> 'ZZZ') do begin
    marcaAct := a.marca; cantAutoMarcaAct := 0; precioTotalMarcaAct := 0;
    while (marcaAct = a.marca) do begin
      precioTotalMarcaAct := precioTotalMarcaAct + a.precio;
      cantAutoMarcaAct := cantAutoMarcaAct + 1;
      calcularAutoMasCaro(a, marcaMax, modeloMax, precioMax);
      leerAuto(a);
    end;
    writeln('Precio promedio de la marca ', marcaAct,': ', (precioTotalMarcaAct / cantAutoMarcaAct):0:2);
  end;
  if (marcaMax <> '') then
    writeln('El auto mas caro es: ', marcaMax ,' ', modeloMax);
end.