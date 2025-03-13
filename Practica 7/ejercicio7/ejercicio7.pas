{
  La Facultad de Informática desea procesar la información de los alumnos que finalizaron la carrera de
  Analista Programador Universitario. Para ello se deberá leer la información de cada alumno, a saber:
  número de alumno, apellido, nombres, dirección de correo electrónico, año de ingreso, año de egreso
  y las notas obtenidas en cada una de las 24 materias que aprobó (los aplazos no se registran).
  1.  Realizar un módulo que lea y almacene la información de los alumnos hasta que se ingrese el
      alumno con número de alumno -1, el cual no debe procesarse. Las 24 notas correspondientes a
      cada alumno deben quedar ordenadas de forma descendente.
  2.  Una vez leída y almacenada la información del inciso 1, se solicita calcular e informar:
      a.  El promedio de notas obtenido por cada alumno.
      b.  La cantidad de alumnos ingresantes 2012 cuyo número de alumno está compuesto
          únicamente por dígitos impares.
      c.  El apellido, nombres y dirección de correo electrónico de los dos alumnos que más rápido
          se recibieron (o sea, que tardaron menos años)
  3.  Realizar un módulo que, dado un número de alumno leído desde teclado, lo busque y elimine de
      la estructura generada en el inciso 1. El alumno puede no existir.
}
program ejercicio7;
const
	cantMaterias = 24;
type
	vecNotas = array[1..cantMaterias] of integer;
  alumno = record
		ape, nom, email: string;
		notas: vecNotas;
		num, ingreso, egreso: integer;
	end;
	lista = ^nodo;
	nodo = record
		dato: alumno;
		sig: lista;
	end;

procedure cargarLista(var l: lista);

	procedure leerAlumno(var a: alumno);
	var
		i, nota, j, pos: integer; caracteres, strRandom: string;
	begin
		write('Ingrese numero de alumno: ');readln(a.num);
		if (a.num <> -1) then begin
			caracteres := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
      strRandom := '';
      for i := 1 to 6 do
        strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
			a.nom := strRandom;
			strRandom := '';
      for i := 1 to 6 do
        strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
			a.ape := strRandom;
			strRandom := '';
			for i := 1 to 8 do
        strRandom := strRandom + caracteres[Random(Length(caracteres)) + 1];
			a.email := strRandom;
			a.ingreso := Random(11) + 2005;
			a.egreso := Random(11) + 2018;
			for i := 1 to cantMaterias do // inicializar el vector para poder colocar las notas correctamente
				a.notas[i] := 0;
			for i := 1 to cantMaterias do begin
				nota := Random(10) + 1; // leo la nota
				pos := 1;
				while (pos < cantMaterias) and (a.notas[pos] > nota) do // encuentro la posicion donde va la nota
					pos := pos + 1;
				for	j := cantMaterias - 1 downto pos do // hago el corrimiento de las notas para poder insertar en el lugar correcto
					a.notas[j + 1] := a.notas[j];
				a.notas[pos] := nota;
			end;
		end;
	end;

	procedure agregarAdelante(var l: lista; a: alumno);
	var
		nue: lista;
	begin
		new(nue); nue^.dato := a;
		nue^.sig := l;
		l := nue;
	end;

var
	a: alumno;
begin
	leerAlumno(a);
	while (a.num <> -1) do begin
		agregarAdelante(l, a);
		leerAlumno(a);
	end;
	writeln();
end;

procedure recorrerLista(l: lista);

	function soloImpares(num: integer): boolean;
	var
		dig: integer;
	begin
		while (num <> 0) do begin
			dig := num MOD 10;
			if (dig MOD 2 = 0) then begin
				soloImpares := false;
				break;
			end;
			num := num DIV 10;
		end;
		if (num = 0) then
			soloImpares := true;
	end;

	procedure calcularAlumnosMinimos(a: alumno; var min1, min2: integer; var minNom1, minNom2, minApe1, minApe2, minEmail1, minEmail2: string);
	var
		cantAnios: integer;
	begin
		cantAnios := a.egreso - a.ingreso;
		if (cantAnios < min1) then begin
			min2 := min1; minNom2 := minApe1; minNom2 := minNom1; minEmail2 := minEmail1;
			min1 := cantAnios; minNom1 := a.nom; minApe1 := a.ape; minEmail1 := a.email;
		end
		else
			if (cantAnios < min2) then begin
				min2 := cantAnios; minNom2 := a.nom; minApe2 := a.ape; minEmail2 := a.email;
			end; 
	end;

var
	cant, min1, min2, i, totalNotas: integer; minNom1, minNom2, minApe1, minApe2, minEmail1, minEmail2: string;
begin
	cant := 0; min1 := 32767; min2 := 32767;
	while (l <> nil) do begin
		totalNotas := 0;
		for i := 1 to cantMaterias do
			totalNotas := totalNotas + l^.dato.notas[i];
		if (l^.dato.ingreso = 2012) and (soloImpares(l^.dato.num)) then
			cant := cant + 1;
		calcularAlumnosMinimos(l^.dato, min1, min2, minNom1, minNom2, minApe1, minApe2, minEmail1, minEmail2);
		writeln('El promedio de las notas del alumno ', l^.dato.nom ,' ', l^.dato.ape ,' es: ', (totalNotas / cantMaterias):0:2);
		l := l^.sig;
	end;
	writeln('La cantidad de ingresantes del anio 2012 con solo digitos impares en su numero es: ', cant);
	writeln('Los dos alumnos que terminaron mas rapido la carrera son: ',minNom1,' ',minApe1,' ',minEmail1,' y ',minNom2,' ',minApe2,' ',minEmail2);
end;

procedure eliminarAlumno(var l: lista; num: integer);
var
	ant, act: lista;
begin
	act := l;
	while (act <> nil) and (act^.dato.num <> num) do begin
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

procedure imprimirAlumnos(l: lista);

	procedure imprimirNotas(v: vecNotas);
	var
		i: integer;
	begin
		for i := 1 to cantMaterias do
			write(v[i],' | ');
		writeln('');
	end;

begin
	while (l <> nil) do begin
		writeln('Numero: ', l^.dato.num ,' | Nombre: ', l^.dato.nom ,' | Apellido: ', l^.dato.ape ,' | Email: ', l^.dato.email ,' | Ingreso: ', l^.dato.ingreso ,' | Egreso: ', l^.dato.egreso);
		writeln('Notas');
		imprimirNotas(l^.dato.notas);
		writeln();
		l := l^.sig;
	end;
end;

var
  l: lista; num: integer;
begin
	Randomize;
  l := nil;
	cargarLista(l);
	imprimirAlumnos(l);
	recorrerLista(l);
	writeln('Ingrese un numero de alumno para eliminarlo: ');readln(num);
	eliminarAlumno(l, num);
	writeln('Alumnos despues de la eliminacion (si es que existia en la lista el numero ingresado)');
	imprimirAlumnos(l);
end.