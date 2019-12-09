# README

Este README explica el uso correcto de mi proyecto

* Como preparar el ambiente
    
    1. En la consola navegar hasta la carpeta del proyecto.

    2. Asegurarse de tener instalado Ruby. Aplicacion desarrollada usando ruby 2.6.3

    3. Asegurarse de tener instalado PostgreSQL. Aplicacion desarrollada usando PostgreSQL 9.6.6

    4. Asegurarse de tener instalada la gema bundler. Puede instalarla ejecutando el comando gem install bundler.

    5. Ejecutar bundler install para instalar todas las dependencias del proyecto.

    6. Ejecutar el comando rails db:create para cargar la base de datos con los datos de ejemplo.

    7. Ejecutar el comando rails db:migrate para cargar la base de datos con los datos de ejemplo.

    8. Ejecutar el comando rails server para encender el servidor.

    9. Ingresar a localhost:3000

* Utilizar CURL

    1. Con curl -X POST -d 'u=Matias&p=DelleDonne' http://localhost:3000/usuarios , crearemos a nuestro usuario

    2. Con curl -X POST -d 'u=Mati&p=DelleDonne' http://localhost:3000/sesiones ,  para lograr un logueo correcto 

* Para generar las condiciones de IV, utilizaremos tambien curl
    * curl -X POST -d 'descrip=IVA_Responsable_Inscripto' http://localhost:3000/types
    * curl -X POST -d 'descrip=IVA_Responsable_no_Inscripto' http://localhost:3000/types
    * curl -X POST -d 'descrip=IVA_no_Responsable' http://localhost:3000/types
    * curl -X POST -d 'descrip=IVA_Sujeto_Exento' http://localhost:3000/types
    * curl -X POST -d 'descrip=Consumidor_Final' http://localhost:3000/types
    * curl -X POST -d 'descrip=Responsable_Monotributo' http://localhost:3000/types
    * curl -X POST -d 'descrip=Sujeto_no_Categorizado' http://localhost:3000/types
    * curl -X POST -d 'descrip=Proveedor_del_Exterior' http://localhost:3000/types
    * curl -X POST -d 'descrip=Cliente_del_Exterior' http://localhost:3000/types
    * curl -X POST -d 'descrip=IVA_Liberado_Ley_Nº_19.640' http://localhost:3000/types
    * curl -X POST -d 'descrip=IVA_Responsable_Inscripto_Agente_de_Percepción' http://localhost:3000/types
    * curl -X POST -d 'descrip=Pequeño_Contribuyente_Eventual' http://localhost:3000/types
    * curl -X POST -d 'descrip=Monotributista_Social' http://localhost:3000/types
    * curl -X POST -d 'descrip=Pequeño_Contribuyente_Eventual_Social' http://localhost:3000/types

* Apartir de aqui se tendra que utilizar el unicode que nos devuele el POST del punto 2 de "Utilizar CURL", ya que hay servicios que requieren token de autenticación
    
    3. Con curl -d 'unicode=ABC123&descrip=EsRojo&detail=EsGrandeYEsRojo&price=9&name=Tomate' -X POST http://localhost:3000/products , tendremos creado nuestro primer producto 
    
    4. Usando estos distintos curls, retornaremos
        curl -d 'q=all' -X GET http://localhost:3000/productos ,  únicamente los productos con stock disponible.
        curl -d 'q=scarce' -X GET http://localhost:3000/productos , aquellos productos cuyo stock es de entre 1 y 5 unidades
        curl -d 'q=in_stock' -X GET http://localhost:3000/productos , todos los productos, aún aquellos sin stock disponible

    5. Especificando en la ruta http://localhost:3000/productos/123ABCDEF o curl -X GET http://localhost:3000/productos/123ABCDEF , tendremos solo el producto con el codigo especificado despues de /productos/* . Para el caso de que querramos los items asociados al producto identificado por el código, tendremos que poner /items al final ya sea de nuestra ruta o de nuestro curl.

    6. Con curl -X POST -d 'cant=3' http://localhost:3000/productos/ABC123/items , creara ítems para el producto identificado por el código recibido, con una cantidad de items a crear, en este caso  cant=3. (Todos estaran en estado Disponible)

    7. Con curl -X GET -d 'authentication=xxxxx' http://localhost:3000/reservas , tendremos las reservas que no son ventas

    8. Con curl -X GET -d 'authentication=xxxxx' http://localhost:3000/reservas/1 , tendremos la reserva con identificador 1

    9. Con curl -X DELETE -d 'authentication=xxxxx&id=1' http://localhost:3000/reservas/1 , eliminaremos la reserva con identificador 1

    10. Con curl -X POST -d 'authentication=xxxxx&id_client=x&user_id=x&reservation_id=x&'

    11. Con curl -X GET -d 'authentication=xxxxxx' http://localhost:3000/ventas , tendremos todas las ventas

    12. Con curl -X GET -d 'authentication=xxxxxx' http://localhost:3000/ventas/1 , tendremos la venta con id 1

* Aclaracion: Si alguno de los curls no devuelve algo o es por no tener algo creado o nos devolvera HTTP status 404 Not found

