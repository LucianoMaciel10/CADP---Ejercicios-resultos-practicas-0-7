{
  7)  Se desea almacenar en memoria una secuencia de 2500 nombres de ciudades, cada nombre podrá tener
      una longitud máxima de 50 caracteres.
  a)  Definir una estructura de datos estática que permita guardar la información leída. Calcular el tamaño
      de memoria que requiere la estructura.
  b)  Dado que un compilador de Pascal típico no permite manejar estructuras de datos estáticas que
      superen los 64 Kb, pensar en utilizar un vector de punteros a palabras, como se indica en la siguiente
      estructura:

  Type 
    Nombre = String[50];
    Puntero = ^Nombre;
    ArrPunteros = array[1..2500] of Puntero;
  Var
    Punteros: ArrPunteros;

  b.1)  Indicar cuál es el tamaño de la variable Punteros al comenzar el programa.
  b.2)  Escribir un módulo que permita reservar memoria para los 2500 nombres. ¿Cuál es la cantidad de
        memoria reservada después de ejecutar el módulo? ¿La misma corresponde a memoria estática o
        dinámica?
  b.3)  Escribir un módulo para leer los nombres y almacenarlos en la estructura de la variable Punteros.
}
program ejercicio7;
Type 
  Nombre = String[50];
  Puntero = ^Nombre;
  ArrPunteros = array[1..2500] of Puntero;

procedure reservarMemoriaVector(var v: ArrPunteros);
var
  i, memoriaTotal: integer;
begin
  memoriaTotal := 0;
  for i := 1 to 2500 do begin
    new (v[i]);
    memoriaTotal := memoriaTotal + sizeof(v[i]);
  end;
  writeln(memoriaTotal,' bytes / memoria dinamica'); 
end;

procedure cargarNombres(var v: ArrPunteros);
var
  nom: string;
  i: integer;
begin
  for i := 1 to 2 do begin
    write('Ingrese un nombre: ');readln(nom);
    v[i]^ := nom;
  end;
end;

Var
  Punteros: ArrPunteros;
begin
  writeln(sizeof(Punteros),' bytes / memoria estatica'); { 10.000 bytes }
  reservarMemoriaVector(Punteros); { 10.000 bytes }
  cargarNombres(Punteros);
end.