{
  Realizar un programa que lea y almacene la información de productos de un supermercado. De cada
  producto se lee: código, descripción, stock actual, stock mínimo y precio. La lectura finaliza cuando se ingresa
  el código -1, que no debe procesarse. Una vez leída y almacenada toda la información, calcular e informar:
  a. Porcentaje de productos con stock actual por debajo de su stock mínimo.
  b. Descripción de aquellos productos con código compuesto por al menos tres dígitos pares.
  c. Código de los dos productos más económicos.
}
program ejercicio5;
type
  producto = record
    cod, stockAct, stockMin: integer;
    descri: string;
    precio: real;
  end;
  listaP = ^nodo;
  nodo = record
    dato: producto;
    sig: listaP
  end;

procedure leerProducto(var p: producto);
begin
  write('Ingrese codigo: ');readln(p.cod);
  if (p.cod <> -1) then begin
    write('Ingrese precio: ');readln(p.precio);
    write('Ingrese stock actual: ');readln(p.stockAct);
    write('Ingrese stock minimo: ');readln(p.stockMin);
    write('Ingrese descripcion: ');readln(p.descri);
    writeln();
  end;
end;

procedure agregarAtras(var pri, ult: listaP; p: producto);
var
  nue: listaP;
begin
  new (nue); nue^.dato := p; nue^.sig := nil;
  if (pri = nil) then begin
    pri := nue;
    ult := nue;
  end
  else begin
    ult^.sig := nue;
    ult := nue;
  end;
end;

procedure imprimirLista(l: listaP);
begin
  while (l <> nil) do begin
    writeln('Codigo: ', l^.dato.cod ,' | Precio: ', l^.dato.precio:0:2 ,' | Stock actual: ', l^.dato.stockAct ,' | Stock minimo: ', l^.dato.stockMin,' | Descripcion: ', l^.dato.descri);
    l := l^.sig;
  end;
end;

function incisoA(l: listaP): real;
var
  cant, total: integer;
begin
  cant := 0; total := 0;
  while (l <> nil) do begin
    total := total + 1;
    if (l^.dato.stockAct < l^.dato.stockMin) then
      cant := cant + 1;
    l := l^.sig;
  end;
  incisoA := (cant / total) * 100;
end;

procedure incisoB(l: listaP);
var
  dig, num, pares: integer;
begin
  while (l <> nil) do begin
    pares := 0; num := l^.dato.cod;
    while (num <> 0) do begin
      dig := num MOD 10;
      if (dig MOD 2 = 0) then
        pares := pares + 1;
      num := num DIV 10;
    end;
    if (pares >= 3) then
      writeln(l^.dato.descri, ' tiene al menos 3 digitos pares en su codigo');
    l := l^.sig;
  end;
end;

procedure incisoC(l: listaP;var codMin1, codMin2: integer);
var
  min1, min2: real;
begin
  min1 := 32767; min2 := 32767; 
  while (l <> nil) do begin
    if (l^.dato.precio < min1) then begin
      min2 := min1;
      codMin2 := codMin1;
      min1 := l^.dato.precio;
      codMin1 := l^.dato.cod;
    end
    else begin
      if (l^.dato.precio < min2) then begin
        min2 := l^.dato.precio;
        codMin2 := l^.dato.cod;
      end;
    end;
    l := l^.sig;
  end;
end;

var
  pri, ult: listaP;
  p: producto;
  codMin1, codMin2: integer;
begin
  pri := nil;
  leerProducto(p);
  while (p.cod <> -1) do begin
    agregarAtras(pri, ult, p);
    leerProducto(p);
  end;
  if (pri <> nil) then begin
    imprimirLista(pri);
    writeln('El porcentaje de productos que tienen stock actual por debajo del stock minimo es: ', incisoA(pri):0:2,'%');
    incisoB(pri);
    incisoC(pri, codMin1, codMin2);
    writeln('Los codigos de los dos productos mas baratos son: ', codMin1,' y ', codMin2);
  end;
end.