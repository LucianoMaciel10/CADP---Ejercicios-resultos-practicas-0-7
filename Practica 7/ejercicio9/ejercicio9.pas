{
  Un cine posee la lista de películas que proyectará durante el mes de Febrero. De cada película se
  tiene: código de película, título de la película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélica, 7: documental y 8: terror) y puntaje promedio otorgado por las críticas. Dicha estructura no posee orden alguno.
  Se pide:
  a)  Actualizar (en la lista que se dispone) el puntaje promedio otorgado por las críticas. Para ello se
      debe leer desde teclado las críticas que han realizado críticos de cine, de cada crítica se lee: DNI
      del crítico, apellido y nombre del crítico, código de película y el puntaje otorgado. La lectura
      finaliza cuando se lee el código de película -1 y la información viene ordenada por código de
      película.
  b)  Informar el código de género que más puntaje obtuvo entre todas las críticas.
  c)  Informar el apellido y nombre de aquellos críticos que posean la misma cantidad de dígitos pares que impares en su DNI.
  d)  Realizar un módulo que elimine de la lista que se dispone una película cuyo código se recibe
      como parámetro (el mismo puede no existir).
}
program ejercicio9;
const
  cantGeneros = 8;
type
  vecGeneros = array[1..cantGeneros] of integer;
  peli = record
    gen, cod: integer;
    titulo: string;
    prom: real;
  end;
  critica = record
    codPeli, puntaje: integer;
    nom, ape: string;
    dni: longint;
  end;
  listaPelis = ^nodoP;
  nodoP = record
    dato: peli;
    sig: listaPelis;
  end;
  listaCriticas = ^nodoC;
  nodoC = record
    dato: critica;
    sig: listaCriticas;
  end;

procedure inicializarGeneros(var v: vecGeneros);
var
  i: integer;
begin
  for i := 1 to cantGeneros do
    v[i] := 0;
end;

procedure cargarPeliculas(var l: listaPelis);
  
  procedure agregarAdelante(var l: listaPelis; p: peli);
  var
    nue: listaPelis;
  begin
    new(nue); nue^.dato := p;
    nue^.sig := l;
    l := nue;
  end;

  procedure leerPelicula(var p: peli);
  var
    caracteres, strRandom: string;
    i: integer;
  begin
    caracteres := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    strRandom := '';
    for i := 1 to 8 do
      strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
    p.titulo := strRandom;
    p.cod := Random(501) + 1;
    p.prom := 0;
    p.gen := Random(8) + 1;
  end;

var
  i: integer; p: peli;
begin
  for i := 1 to 10 do begin
    leerPelicula(p);
    agregarAdelante(l, p);
  end;
end;

procedure cargarCriticas(var l: listaCriticas);

  procedure leerCritica(var c: critica);
  var
    caracteres, strRandom: string;
    i: integer;
  begin
    write('Ingrese codigo de pelicula: ');readln(c.codPeli);
    if (c.codPeli <> -1) then begin
      caracteres := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
      strRandom := '';
      for i := 1 to 6 do
        strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
      c.ape := strRandom;
      strRandom := '';
      for i := 1 to 6 do
        strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
      c.nom := strRandom;
      c.dni := Random(25000000) + 25000000;
      c.puntaje := Random(10) + 1;
    end;
  end;

  procedure agregarAtras(var l: listaCriticas; c: critica);
  var
    aux, nue: listaCriticas;
  begin
    new(nue); nue^.dato := c; nue^.sig := nil;
    if (l = nil) then
      l := nue
    else begin
      aux := l;
      while (aux^.sig <> nil) do
        aux := aux^.sig;
      aux^.sig := nue;
    end;
  end;

var
  c: critica;
begin
  leerCritica(c);
  while (c.codPeli <> -1) do begin
    agregarAtras(l, c);
    leerCritica(c);
  end;
  writeln();
end;

procedure imprimirPeliculas(l: listaPelis);
begin
  while (l <> nil) do begin
    writeln('Codigo de pelicula: ', l^.dato.cod ,' | Titulo: ', l^.dato.titulo ,' | Promedio de puntaje: ', l^.dato.prom:0:2 ,' | Genero: ', l^.dato.gen);
    l := l^.sig;
  end;
  writeln();
end;

procedure actualizarPromedios(var lp: listaPelis; lc: listaCriticas; var v: vecGeneros);
var
  peliAct, cant: integer; total: real; auxP: listaPelis; auxC: listaCriticas;
begin
  auxP := lp;
  while (auxP <> nil) do begin
    peliAct := auxP^.dato.cod; cant := 0; total := 0;
    auxC := lc;
    while (auxC <> nil) and (auxC^.dato.codPeli <> peliAct) do
      auxC := auxC^.sig;
    while (auxC <> nil) and (auxC^.dato.codPeli = peliAct) do begin
      cant := cant + 1;
      total := total + auxC^.dato.puntaje;
      v[auxP^.dato.gen] := v[auxP^.dato.gen] + auxC^.dato.puntaje;
      auxC := auxC^.sig;
    end;
    if (cant > 0) then
      auxP^.dato.prom := total / cant;
    auxP := auxP^.sig;
  end;
end;

procedure informarMaxGenero(v: vecGeneros);
var
  i, max, genMax: integer;
begin
  max := -1;
  for i := 1 to cantGeneros do begin
    if (v[i] > max) then begin
      max := v[i]; genMax := i;
    end;
    writeln('Genero ', i ,': ', v[i]);
  end;
  writeln('El genero que mas puntaje obtuvo es: ', genMax);writeln();
end;

procedure recorrerLista(l: listaCriticas);
var
  dig, pares, impares: integer; num: longint;
begin
  while (l <> nil) do begin
    num := l^.dato.dni; pares := 0; impares := 0;
    while (num <> 0) do begin
      dig := num MOD 10;
      if (dig MOD 2 = 0) then
        pares := pares + 1
      else
        impares := impares + 1;
      num := num DIV 10;
    end;
    if (pares = impares) then
      writeln('El critico ', l^.dato.nom ,' ', l^.dato.ape ,' tiene misma cantidad de digitos pares e impares en su DNI'); 
    l := l^.sig;
  end;
  writeln();
end;

procedure eliminarPelicula(var l: listaPelis; cod: integer);
var
  act, ant: listaPelis;
begin
  act := l;
  while (act <> nil) and (act^.dato.cod <> cod) do begin
    ant := act; act := act^.sig;
  end;
  if (act <> nil) then begin
    if (act = l) then
      l := l^.sig
    else
      ant^.sig := act^.sig;
    dispose(act);
  end;
end;

procedure imprimirCriticas(l: listaCriticas);
begin
  while (l <> nil) do begin
    writeln('Codigo de pelicula: ', l^.dato.codPeli,' | Apellido: ', l^.dato.ape ,' | Nombre: ', l^.dato.nom ,' | DNI: ', l^.dato.dni ,' | Puntaje: ', l^.dato.puntaje);
    l := l^.sig;
  end;
  writeln();
end;

var
  lp: listaPelis; lc: listaCriticas; v: vecGeneros; cod: integer;
begin
  Randomize;
  lp := nil; lc := nil;
  inicializarGeneros(v);
  cargarPeliculas(lp); // se dispone
  imprimirPeliculas(lp);
  cargarCriticas(lc);
  imprimirCriticas(lc);
  actualizarPromedios(lp, lc, v);
  informarMaxGenero(v);
  recorrerLista(lc);
  write('Ingrese un codigo de pelicula para eliminar: ');readln(cod);
  eliminarPelicula(lp, cod);
  imprimirPeliculas(lp);
end.