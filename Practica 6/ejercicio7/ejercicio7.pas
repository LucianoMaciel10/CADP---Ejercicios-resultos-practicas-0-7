{
  El Programa Horizonte 2020 (H2020) de la Unión Europea ha publicado los criterios para financiar
  proyectos de investigación avanzada. Para los proyectos de sondas espaciales vistos en el ejercicio anterior, se
  han determinado los siguientes criterios:
  - sólo se financiarán proyectos cuyo costo de mantenimiento no supere el costo de construcción.
  - no se financiarán proyectos espaciales que analicen ondas de radio, ya que esto puede realizarse desde la
  superficie terrestre con grandes antenas.
  A partir de la información disponible de las sondas espaciales (la lista generada en ejercicio 6), implementar
  un programa que:
  a.  Invoque un módulo que reciba la información de una sonda espacial, y retorne si cumple o no con los
      nuevos criterios H2020.
  b.  Utilizando el módulo desarrollado en a) implemente un módulo que procese la lista de sondas de la ESA y
      retorne dos listados, uno con los proyectos que cumplen con los nuevos criterios y otro con aquellos que no
      los cumplen.
  c.  Invoque a un módulo que reciba una lista de proyectos de sondas espaciales e informe la cantidad y el
      costo total (construcción y mantenimiento) de los proyectos que no serán financiados por H2020. Para ello,
      utilice el módulo realizado en b.
}
program ejercicio7;
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
  if (l = nil) then
    writeln('Lista vacia.');
  while (l <> nil) do begin
    writeln('Nombre: ', l^.dato.nom ,' | Cantidad de meses activo: ', l^.dato.cantMeses:0:2 ,' | Categoria: ', l^.dato.cate ,' | Costo de construccion: ', l^.dato.costoC ,' | Costo de mantenimiento: ', l^.dato.costoM);
    l := l^.sig;
  end;
  writeln();
end;

function cumpleCriterios(s: sonda): boolean;
begin
  cumpleCriterios := ((s.costoM * s.cantMeses) <= s.costoC) and (s.cate <> 1); 
end;

procedure procesarLista(l: lista; var priCumplen, ultCumplen, priNoCumplen, ultNoCumplen: lista);
begin
  while (l <> nil) do begin
    if (cumpleCriterios(l^.dato)) then
      cargarSondas(priCumplen, ultCumplen, l^.dato)
    else 
      cargarSondas(priNoCumplen, ultNoCumplen, l^.dato);
    l := l^.sig;
  end;
end;

procedure infoDeProyectosNoFinanciados(l: lista);
var
  cant: integer;
begin
  cant := 0;
  while (l <> nil) do begin
    cant := cant + 1;
    writeln('Costo total no financiado: ', (l^.dato.costoC + (l^.dato.costoM * l^.dato.cantMeses)):0:2 ,' del proyecto ', l^.dato.nom);
    l := l^.sig;
  end;
  writeln();
  writeln('Cantidad de proyectos no financiados: ', cant);
  writeln();
end;

var
  pri, ult, priCumplen, ultCumplen, priNoCumplen, ultNoCumplen: lista;
  s: sonda;
begin
  pri := nil; priCumplen := nil; priNoCumplen := nil;
  repeat
    leerSonda(s);
    cargarSondas(pri, ult, s);
  until (s.nom = 'GAIA');
  procesarLista(pri, priCumplen, ultCumplen, priNoCumplen, ultNoCumplen);
  writeln('Lista que cumple con los requisitos');
  imprimirLista(priCumplen);
  writeln('Lista que no cumple con los requisitos');
  imprimirLista(priNoCumplen);
  writeln('Informacion sobre los proyectos no financiados');
  infoDeProyectosNoFinanciados(priNoCumplen);
end.