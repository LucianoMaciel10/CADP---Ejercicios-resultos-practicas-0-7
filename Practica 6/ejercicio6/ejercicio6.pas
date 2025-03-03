{
  La Agencia Espacial Europea (ESA) está realizando un relevamiento de todas las sondas espaciales lanzadas
  al espacio en la última década. De cada sonda se conoce su nombre, duración estimada de la misión
  (cantidad de meses que permanecerá activa), el costo de construcción, el costo de mantenimiento mensual y
  rango del espectro electromagnético sobre el que realizará estudios. Dicho rango se divide en 7 categorías:
      1. radio; 2. microondas; 3.infrarrojo; 4. luz visible; 5. ultravioleta; 6. rayos X; 7. rayos gamma
  Realizar un programa que lea y almacene la información de todas las sondas espaciales. La lectura finaliza al
  ingresar la sonda llamada “GAIA”, que debe procesarse.
  Una vez finalizada la lectura, informar:
  a. El nombre de la sonda más costosa (considerando su costo de construcción y de mantenimiento).
  b. La cantidad de sondas que realizarán estudios en cada rango del espectro electromagnético.
  c. La cantidad de sondas cuya duración estimada supera la duración promedio de todas las sondas.
  d. El nombre de las sondas cuyo costo de construcción supera el costo promedio entre todas las sondas.
  Nota: para resolver los incisos a), b), c) y d), la lista debe recorrerse la menor cantidad de veces posible
}
program ejercicio6;
type
  categorias = 1..7;
  sonda = record 
    cate: categorias;
    nom: string;
    cantMeses: real;
    costoC, costoM: integer;
  end;
  lista = ^nodo;
  nodo = record
    dato: sonda;
    sig: lista;
  end;
  vCategorias = array[categorias] of integer;

procedure leerSonda(var s: sonda);
begin
  write('Ingresar nombre (Fin = GAIA): ');readln(s.nom);
  write('Ingresar categoria (1-7): '); readln(s.cate);
  write('Ingresar costo de construccion: ');readln(s.costoC);
  write('Ingresar costo de mantenimiento: ');readln(s.costoM);
  write('Ingresar cantidad de meses activo: ');readln(s.cantMeses);
  writeln();
end;

procedure cargarSondas(var pri, ult: lista; s: sonda);
var
  nue: lista;
begin
  new (nue); nue^.dato := s; nue^.sig := nil;
  if (pri = nil) then begin
    pri := nue;
    ult := nue;
  end
  else begin
    ult^.sig := nue;
    ult := nue;
  end;
end;

procedure imprimirLista(l: lista);
begin
  while (l <> nil) do begin
    writeln('Nombre: ', l^.dato.nom ,' | Cantidad de meses activo: ', l^.dato.cantMeses:0:2 ,' | Categoria: ', l^.dato.cate ,' | Costo de construccion: ', l^.dato.costoC ,' | Costo de mantenimiento: ', l^.dato.costoM);
    l := l^.sig;
  end;
  writeln();
end;


procedure inicializarCategorias(var v: vCategorias);
var
  i: integer;
begin
  for i := 1 to 7 do
    v[i] := 0;
end;

procedure imprimirVector(v: vCategorias); 
var
  i: integer;
begin
  for i := 1 to 7 do 
    if (v[i] > 0) then
      writeln('Cantidad de sondas de la categoria ', i ,': ', v[i]);
  writeln();
end;

procedure calcularMaxSonda(nom: string; costoTotal: real;var max: real;var maxNom: string);
begin
  if (costoTotal > max) then begin
    max := costoTotal;
    maxNom := nom;
  end;
end;

procedure incisoCyD(l: lista;var duracionPromedio, costoConstPromedio: real;var cantSupDuraProm: integer);
begin
  while (l <> nil) do begin
    if (l^.dato.cantMeses > duracionPromedio) then
      cantSupDuraProm := cantSupDuraProm + 1;
    if (l^.dato.costoC > costoConstPromedio) then
      writeln(l^.dato.nom ,' supera el costo de construccion promedio de todas las sondas');
    l := l^.sig;
  end;
  writeln();
end;

procedure recorrerLista(l: lista; var maxNom: string; var v: vCategorias; var duracionPromedio, costoConstPromedio: real);
var
  totalMeses, max, costoTotal: real;
  cantSondas, totalCostoConst: integer;
begin
  max := -1; cantSondas := 0; totalMeses := 0; totalCostoConst := 0;
  while (l <> nil) do begin
    totalCostoConst := totalCostoConst + l^.dato.costoC;
    totalMeses := totalMeses + l^.dato.cantMeses;
    cantSondas := cantSondas + 1;
    v[l^.dato.cate] := v[l^.dato.cate] + 1;
    costoTotal := l^.dato.costoC + (l^.dato.costoM * l^.dato.cantMeses);
    calcularMaxSonda(l^.dato.nom, costoTotal, max, maxNom);
    l := l^.sig;
  end;
  duracionPromedio := totalMeses / cantSondas;
  costoConstPromedio := totalCostoConst / cantSondas;
end;

var
  pri, ult: lista;
  s: sonda;
  v: vCategorias;
  maxNom: string;
  duracionPromedio, costoConstPromedio: real;
  cantSupDuraProm: integer;
begin
  pri := nil; cantSupDuraProm := 0;
  inicializarCategorias(v);
  repeat
    leerSonda(s);
    cargarSondas(pri, ult, s);
  until (s.nom = 'GAIA');
  imprimirLista(pri);
  recorrerLista(pri, maxNom, v, duracionPromedio, costoConstPromedio);
  writeln('La sonda mas costosa es: ', maxNom); writeln();
  imprimirVector(v);
  incisoCyD(pri, duracionPromedio, costoConstPromedio, cantSupDuraProm);
  writeln('La cantidad de sondas que superan el promedio de tiempo estimado de duracion es: ', cantSupDuraProm); writeln();
end.