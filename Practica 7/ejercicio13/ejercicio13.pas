{
  La tienda de libros Amazon Books está analizando información de algunas editoriales. Para ello,
  Amazon cuenta con una tabla con las 35 áreas temáticas utilizadas para clasificar los libros (Arte y Cultura,
  Historia, Literatura, etc.).
  De cada libro se conoce su título, nombre de la editorial, cantidad de páginas, año de edición, cantidad de
  veces que fue vendido y código del área temática (1..35).
  Realizar un programa que:
  A)  Invoque a un módulo que lea la información de los libros hasta ingresar el título “Relato de un
      náufrago” (que debe procesarse) y devuelva en una estructura de datos adecuada para la
      editorial “Planeta Libros”, con la siguiente información:
      - Nombre de la editorial
      - Año de edición del libro más antiguo
      - Cantidad de libros editados
      - Cantidad total de ventas entre todos los libros
      - Detalle con título, nombre del área temática y cantidad de páginas de todos los libros con más de 250 ventas.
  B)  Invoque a un módulo que reciba la estructura generada en A) e imprima el nombre de la editorial
      y el título de cada libro con más de 250 ventas.
}
program ejercicio13;
const
	FIN = 'Relatos de un naufrago';
	cantAreas = 35;
	EDITORIAL = 'Planeta libros';

type
	vecAreas = array[1..cantAreas] of string;
  libro = record
		titulo, editorial: string;
		codArea, anio, cantVentas, cantPag: integer;
	end;
	detalles = record
		titulo, area: string;
		cantPag: integer;
  end;
	listaL = ^nodoL;
	nodoL = record	
		dato: libro;
		sig: listaL;
	end;
	listaD = ^nodoD;
	nodoD = record
		dato: detalles;
		sig: listaD;
	end;
	resultados = record
		editorial: string;
		detalles: listaD;
		minAnio, cantLibros, totalVentas: integer;
	end;

procedure cargarAreas(var v: vecAreas);
begin
  v[1] := 'Arte y Cultura'; v[2] := 'Historia'; v[3] := 'Literatura'; v[4] := 'Ciencia'; v[5] := 'Tecnología';
  v[6] := 'Filosofía'; v[7] := 'Psicología'; v[8] := 'Sociología'; v[9] := 'Educación'; v[10] := 'Política';
  v[11] := 'Economía'; v[12] := 'Derecho'; v[13] := 'Matemáticas'; v[14] := 'Física'; v[15] := 'Química';
  v[16] := 'Biología'; v[17] := 'Medicina'; v[18] := 'Ingeniería'; v[19] := 'Arquitectura'; v[20] := 'Ecología';
  v[21] := 'Agricultura'; v[22] := 'Gastronomía'; v[23] := 'Deportes'; v[24] := 'Música'; v[25] := 'Cine y TV';
	v[26] := 'Fotografía'; v[27] := 'Turismo'; v[28] := 'Religión'; v[29] := 'Mitología';  v[30] := 'Autoayuda';
  v[31] := 'Fantasía';  v[32] := 'Ciencia Ficción';  v[33] := 'Terror';  v[34] := 'Misterio';  v[35] := 'Aventura';
end;

procedure moduloA(var r: resultados; v: vecAreas);

	procedure cargarLibros(var l: listaL);
	
		procedure leerLibro(var l: libro);
		var
			i, num1, num2: integer;
			caracteres, strRandom: string;
		begin
			caracteres := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
			num1 := Random(100) + 1;
			if (num1 > 65) then
				l.editorial := EDITORIAL
			else begin
				strRandom := '';
				for i := 1 to 6 do
					strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
				l.editorial := strRandom;
			end;
			num2 := Random(100) + 1;
			if (num2 > 95) then
				l.titulo := FIN
			else begin
				strRandom := '';
				for i := 1 to 8 do
					strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
				l.titulo := strRandom;
			end;
			l.cantPag := Random(301) + 50;
			l.anio := Random(116) + 1910;
			l.cantVentas := Random(501) + 50;
			l.codArea := Random(35) + 1;
		end;

		procedure agregarAdelanteL(var l: listaL; li: libro);
		var
			nue: listaL;
		begin
			new(nue); nue^.dato := li; nue^.sig := l; l := nue;
		end;

	var
		li: libro;
	begin
		repeat
			leerLibro(li);
			if (li.editorial = EDITORIAL) then
				agregarAdelanteL(l, li);
		until (li.titulo = FIN);
	end;

	procedure cargarResultados(var r: resultados; l: listaL; v: vecAreas);

		procedure inicializarResultados(var r: resultados);
		begin
			r.cantLibros := 0; r.totalVentas := 0; r.detalles := nil; r.editorial := EDITORIAL; r.minAnio := 32767;
		end;

		procedure agregarAdelanteD(var l: listaD; d: detalles);
		var
			nue: listaD;
		begin
			new(nue); nue^.dato := d; nue^.sig := l; l := nue;
		end;

	var
		d: detalles;
	begin
		inicializarResultados(r);
		while (l <> nil) do begin
			r.totalVentas := r.totalVentas + l^.dato.cantVentas;
			r.cantLibros := r.cantLibros + 1;
			if (l^.dato.anio < r.minAnio) then
				r.minAnio := l^.dato.anio;
			if (l^.dato.cantVentas > 250) then begin
				d.titulo := l^.dato.titulo; d.area := v[l^.dato.codArea]; d.cantPag := l^.dato.cantPag;
				agregarAdelanteD(r.detalles, d);
			end;
			l := l^.sig;
		end;
	end;

	procedure imprimirLibros(l: listaL);
	begin
		writeln();
		writeln('Libros de la editorial ', EDITORIAL);
		while (l <> nil) do begin
			writeln('Tituto: ', l^.dato.titulo,' | Codigo de area: ', l^.dato.codArea,' | Cantidad de ventas: ', l^.dato.cantVentas,' | Anio de edicion: ', l^.dato.anio,' | Paginas: ', l^.dato.cantPag);
			l := l^.sig;
		end;
		writeln();
	end;

var
	l: listaL;
begin
	l := nil;
	cargarLibros(l);
	imprimirLibros(l);
	cargarResultados(r, l, v);
end;

procedure moduloB(l: listaD; editorial: string);
begin
	writeln('Libros con mas de 250 ventas de la editorial ', editorial);
	while (l <> nil) do begin
		writeln(l^.dato.titulo);
		l := l^.sig;
	end;
	writeln();
end;

procedure imprimirResultados(r: resultados);
begin
	writeln('Resultados obtenidos de libros de la editorial ', EDITORIAL);
	writeln('Anio de edicion mas antiguo: ', r.minAnio);
	writeln('Cantidad de libros: ', r.cantLibros);
	writeln('Cantidad total de ventas: ', r.totalVentas);
	// el resultado guardado en r.detalles no lo imprimo porque en el moduloB se imprime parte de sus datos y quedaria raro imprimir aqui la otra parte de sus datos separada o mostrar los datos dos veces
end;

var
  r: resultados; v: vecAreas;
begin
	Randomize();
	cargarAreas(v); // se dispone
	moduloA(r, v);
	moduloB(r.detalles, r.editorial);
	imprimirResultados(r); // no se pide esto en el enunciado pero creo que tendria sentido ver los datos calculados
end.