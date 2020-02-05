# README

Este README explica el uso de la app

Para tener la base de datos cargada tendremos que hace:
	heroku run rails db:migrate db:seed

Para obtener el token de autenticacion tendremos que hacer
	curl -X POST -d 'u=Matias&p=DelleDonne' https://rubyttps.herokuapp.com/sesiones

Luego el token en el campo authentication se tendra que usar en todas las rutas (excepto POST /usuarios y POST /sesiones)

Ejemplo:

GET /productos?authentication="xxxxxxx"
GET /reservas/1?authentication="xxxxxxx"

La ejecucion de los test estando parados en /appRuby ejecutar 
	rails test test/models/product_test.rb

