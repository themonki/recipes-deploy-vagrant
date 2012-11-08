Edar Andrés Moncada
0832294


El ip asignado a la maquina loadb01 que contiene el haproxy es 172.168.0.100

Existe un archivo php en cada una de las maquinas web01, web02 y web03 llamada 
page.php que contiene información diferente sobre cada servidor para poder identificar
 cual maquina esta respondiendo a la petición.

Al principio siempre direcciona a la maquina 1.

Se realizo una prueba de estres sobre el servidor usando un aplicativo de apache llamado ab.
El comando fue:

ab -n 1000000 -c 999 172.168.0.100/

Enviando 1 000 000 de peticiones con 999 usuarios diferentes, se logra obtener las capturas 
que se observan en la carpeta imagenes donde se muestra los momentos en que los web server 
comienzan a caer poniendose de colores diferentes. Y en el momento en que cae el servidor web01
al llamar 172.168.0.100/page en el navegador este cambia a la maquina 3. Y sigue cambiando a medida
que se cae una cierta maquina y se solicita la pagina.