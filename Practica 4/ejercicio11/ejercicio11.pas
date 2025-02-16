{
  El colectivo de fotógrafos ArgenPics desea conocer los gustos de sus seguidores en las redes sociales. Para
  ello, para cada una de las 200 fotos publicadas en su página de Facebook, cuenta con la siguiente
  información: título de la foto, el autor de la foto, cantidad de Me gusta, cantidad de clics y cantidad de
  comentarios de usuarios. Realizar un programa que lea y almacene esta información. Una vez finalizada la
  lectura, el programa debe procesar los datos e informar:
  a) Título de la foto más vista (la que posee mayor cantidad de clics).
  b) Cantidad total de Me gusta recibidas a las fotos cuyo autor es el fotógrafo “Art Vandelay”.
  c) Cantidad de comentarios recibidos para cada una de las fotos publicadas en esa página.
}
program ejercicio11;
const
  maxFotos = 5;
  
type
  foto = record
    titulo, autor: string;
    cantMG, cantClics, cantComen: integer;
  end;
  vecFotos = array[1..maxFotos] of foto;
  
procedure leerFoto(var f: foto);
begin
  write('Ingrese titulo: ');readln(f.titulo);
  write('Ingrese autor: ');readln(f.autor);
  write('Ingrese cantidad de me gustas: ');readln(f.cantMG);
  write('Ingrese cantidad de clicks: ');readln(f.cantClics);
  write('Ingrese cantidad de comentarios: ');readln(f.cantComen);
  writeln();
end;

procedure cargarVector(var v: vecFotos);
var
  i: integer;
  f: foto;
begin
  for i := 1 to maxFotos do begin
    leerFoto(f);
    v[i] := f;
  end;
end;

function calcularFotoMasVista(v: vecFotos): string;
var
  max, i: integer;
  maxTitulo: string;
begin
  max := -1;
  for i := 1 to maxFotos do 
    if (v[i].cantClics > max) then begin
      max := v[i].cantClics;
      maxTitulo := v[i].titulo;
    end;
  calcularFotoMasVista := maxTitulo;
end;

function cantTotalMGautorArtVandelay(v: vecFotos): integer;
var
  total, i: integer;
begin
  total := 0;
  for i := 1 to maxFotos do
    if (v[i].autor = 'Art Vandelay') then
      total := total + v[i].cantMG;
  cantTotalMGautorArtVandelay := total;
end;

procedure imprimirCantidadDeComentarios(v: vecFotos);
var
  i: integer;
begin
  for i := 1 to maxFotos do
    writeln('La foto de ', v[i].autor ,' tiene ', v[i].cantComen ,' comentarios.');
end;

var
  v: vecFotos;
begin
  cargarVector(v);
  writeln('Foto mas vista: ', calcularFotoMasVista(v));
  writeln('Cantidad total de Me gusta recibidas a las fotos cuyo autor es el fotografo "Art Vandelay": ', cantTotalMGautorArtVandelay(v));
  imprimirCantidadDeComentarios(v);
end.