{
  El Observatorio Astronómico de La Plata ha realizado un relevamiento sobre los distintos objetos
  astronómicos observados durante el año 2015. Los objetos se clasifican en 7 categorías: 1: estrellas,
  2: planetas, 3: satélites, 4: galaxias, 5: asteroides, 6: cometas y 7: nebulosas.
  Al observar un objeto, se registran los siguientes datos: código del objeto, categoría del objeto (1..7),
  nombre del objeto, distancia a la Tierra (medida en años luz), nombre del descubridor y año de su
  descubrimiento.
  A.  Desarrolle un programa que lea y almacene la información de los objetos que han sido
      observados. Dicha información se lee hasta encontrar un objeto con código -1 (el cual no
      debe procesarse). La estructura generada debe mantener el orden en que fueron leídos los
      datos.
  B.  Una vez leídos y almacenados todos los datos, se pide realizar un reporte con la siguiente
      información:
  1.  Los códigos de los dos objetos más lejanos de la tierra que se hayan observado.
  2.  La cantidad de planetas descubiertos por "Galileo Galilei" antes del año 1600.
  3.  La cantidad de objetos observados por cada categoría.
  4.  Los nombres de las estrellas cuyos códigos de objeto poseen más dígitos pares que impares.
}
program ejercicio6;
const
  cantCategorias = 7;
type
  tipoCategoria = 1..cantCategorias;
  objeto = record
    nom, nomDesc: string;
    cod, dist, anio: integer;
    cate: tipoCategoria;
  end;
  lista = ^nodo;
  nodo = record
    dato: objeto;
    sig: lista;
  end;
  vecCategorias = array[tipoCategoria] of integer;

procedure inicializarCategorias(var v: vecCategorias);
var
  i: integer;
begin
  for i := 1 to cantCategorias do
    v[i] := 0;
end;

procedure cargarLista(var pri, ult: lista; var v: vecCategorias);

  procedure leerObjeto(var o: objeto);
  var
    caracteres, strRandom: string;
    i: integer;
  begin
    write('Ingrese codigo: ');readln(o.cod); 
    if (o.cod <> - 1) then begin
      caracteres := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
      write('Ingrese nombre del descubridor: ');readln(o.nomDesc); 
      strRandom := '';
      for i := 1 to 6 do
        strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
      o.nom := strRandom;
      o.anio := Random(301) + 1500;
      o.dist := Random(5001) + 2500;
      o.cate := Random(cantCategorias) + 1;
      writeln();
    end;
  end;

  procedure agregarAtras(var pri, ult: lista; o: objeto);
  var
    nue: lista;
  begin
    new(nue); nue^.dato := o; nue^.sig := nil;
    if (pri = nil) then begin
      pri := nue;
      ult := nue;
    end
    else begin
      ult^.sig := nue;
      ult := nue;
    end;
  end;

var
  o: objeto;
begin
  leerObjeto(o);
  while (o.cod <> -1) do begin
    agregarAtras(pri, ult, o);
    v[o.cate] := v[o.cate] + 1;
    leerObjeto(o);
  end;
end;

procedure recorrerLista(l: lista);

  procedure calcularObjetosMaximos(dist, cod: integer; var max1, max2, codMax1, codMax2: integer);
  begin
    if (dist > max1) then begin
      max2 := max1; codMax2 := codMax1;
      max1 := dist; codMax1 := cod;
    end
    else 
      if (dist > max2) then begin
        max2 := dist; codMax2 := cod;
      end;
  end;

  procedure descomponerCodigo(cod: integer; nom: string);
  var
    dig, num, pares, impares: integer;
  begin
    pares := 0; impares := 0; num := cod;
    while (num <> 0) do begin
      dig := num MOD 10;
      if (dig MOD 2 = 0) then
        pares := pares + 1
      else
        impares := impares + 1;
      num := num DIV 10;
    end;
    if (pares > impares) then
      writeln('El objeto ', nom ,' tiene mas digitos pares que impares en su codigo');
  end;

var
  max1, max2, codMax1, codMax2, cant: integer;
begin
  max1 := -1; max2 := -1; cant := 0;
  while (l <> nil) do begin
    calcularObjetosMaximos(l^.dato.dist, l^.dato.cod, max1, max2, codMax1, codMax2);
    if (l^.dato.nomDesc = 'Galileo Galilei') and (l^.dato.anio > 1600) then
      cant := cant + 1;
    descomponerCodigo(l^.dato.cod, l^.dato.nom);
    l := l^.sig;
  end;
  writeln('Los codigos de los dos objetos que mas distancia hay respecto a la tierra son: ', codMax1 ,' y ', codMax2);
  writeln('La cantidad de objetos descubierto por Galileo Galilei antes del 1600 es: ', cant);
  writeln();
end;

procedure informarCategorias(v: vecCategorias);
var
  i: integer;
begin
  for i := 1 to cantCategorias do
    writeln('Categoria ', i ,': ', v[i]);
end;

procedure imprimirObjetos(l: lista);
begin
  while (l <> nil) do begin
    writeln('Codigo: ', l^.dato.cod ,' | Nombre: ', l^.dato.nom ,' | Nombre del descubridor: ', l^.dato.nomDesc ,' | Distancia de la tierra: ', l^.dato.dist ,' | Anio que se descubrio: ', l^.dato.anio ,' | Categoria: ', l^.dato.cate);
    l := l^.sig;
  end;
  writeln();
end;

var
  pri, ult: lista; v: vecCategorias;
begin
  pri := nil;
  inicializarCategorias(v);
  cargarLista(pri, ult, v);
  imprimirObjetos(pri);
  recorrerLista(pri);
  informarCategorias(v);
end.