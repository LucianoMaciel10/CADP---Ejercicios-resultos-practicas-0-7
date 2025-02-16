{
  Realizar un programa que lea y almacene la información de 400 alumnos ingresantes a la Facultad de
  Informática de la UNLP en el año 2020. De cada alumno se lee: nro de inscripción, DNI, apellido, nombre y
  año de nacimiento. Una vez leída y almacenada toda la información, calcular e informar:
  a)  El porcentaje de alumnos con DNI compuesto sólo por dígitos pares.
  b)  Apellido y nombre de los dos alumnos de mayor edad.
}
program ejercicio8;
const
  maxAlumnos = 400;
  
type
  alumno = record
    dni: longint;
    num, ano: integer;
    ape, nom: string;
  end;
  vecAlumnos = array[1..maxAlumnos] of alumno;

procedure leerAlumno(var a: alumno);
begin
  write('Ingrese numero de inscripcion: ');readln(a.num);
  write('Ingrese nombre: ');readln(a.nom);
  write('Ingrese apellido: ');readln(a.ape);
  write('Ingrese ano de nacimiento: ');readln(a.ano);
  write('Ingrese dni: ');readln(a.dni);
  writeln();
end;

procedure cargarVector(var v: vecAlumnos);
var
  a: alumno;
  i: integer;
begin
  for i := 1 to maxAlumnos do begin
    leerAlumno(a);
    v[i] := a;
  end;
end;

function porceAlumDNIPar(v: vecAlumnos): real;
var
  dni: longint;
  i, dig, cant: integer;
begin
  cant := 0;
  for i := 1 to maxAlumnos do begin
    dni := v[i].dni;
    while (dni <> 0) do begin
      dig := dni MOD 10;
      if (dig MOD 2 <> 0) then
        break;
      dni := dni DIV 10;
    end;
    if (dni = 0) then
      cant := cant + 1;
  end;
  porceAlumDNIPar := (cant / maxAlumnos) * 100;
end;

procedure calcularAlumnosMasGrandes(v: vecAlumnos;var min1, min2: integer;var minNom1, minNom2, minApe1, minApe2: string);
var
  i: integer;
begin
  for i := 1 to maxAlumnos do 
    if (v[i].ano < min1) then begin
      min2 := min1;
      minNom2 := minNom1;
      minApe2 := minApe1;
      min1 := v[i].ano;
      minNom1 := v[i].nom;
      minApe1 := v[i].ape;
    end
    else 
      if (v[i].ano < min2) then begin
        min2 := v[i].ano;
        minNom2 := v[i].nom;
        minApe2 := v[i].ape;
      end;
end;

var
  v: vecAlumnos;
  min1, min2: integer;
  minNom1, minNom2, minApe1, minApe2: string;
begin
  min1 := 32767; min2 := 32767;
  cargarVector(v);
  writeln('El porcentaje de alumnos con DNI compuesto solo por digitos pares es: ', porceAlumDNIPar(v):0:2,'%');
  calcularAlumnosMasGrandes(v, min1, min2, minNom1, minNom2, minApe1, minApe2);
  writeln('El apellido y nombre de los dos alumnos con mas edad son: ', minNom1 ,' ', minApe1 ,' y ', minNom2 ,' ', minApe2);
end.