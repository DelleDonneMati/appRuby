# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

	user=User.create([{username: 'Matias', password: 'DelleDonne'}, {username: 'Lautaro', password: 'De Leon'}])
	products = Product.create([{unicode: 'aaa111111', name: 'Tomate', detail: 'Tomate Rojo', descrip: 'Tomate natural', price: 25}, {unicode: 'bbb555555', name: 'Lechuga', detail: 'Lechuga verde', descrip: 'Lechuga grande', price: 20}, {unicode: 'ccc333333', name: 'Yerba Mate', detail: 'Playadito', descrip: 'Yerba Playadito', price: 5 },{unicode: 'rrr323232', name: 'Jamon', detail: 'Jamon cocido', descrip: 'Muy rico', price:23 },{unicode: 'ggg020923', name: 'Queso', detail: 'Queso mantecoso', descrip: 'Poco rico', price:4 }])
	Item.create([{product_id: products.first.id, status: 'Disponible'},{product_id: products.first.id, status: 'Disponible'},{product_id: products.first.id, status: 'Disponible'},{product_id: products.last.id, status: 'Disponible'},{product_id: products.last.id, status: 'Disponible'},{product_id: products.last.id, status: 'Disponible'}] )
	ivatypes = Type.create( [ { descrip: 'IVA Responsable Inscripto' },{ descrip: 'IVA Responsable no Inscripto'},{ descrip: 'IVA no Responsable'}, { descrip: 'IVA Sujeto Exento'},{ descrip: 'Consumidor Final'},{ descrip: 'Responsable Monotributo'},{ descrip:'Sujeto no Categorizado' }, { descrip:'Proveedor del Exterior' },{ descrip:'Cliente del Exterior' },{ descrip: 'IVA Liberado  Ley Nº 19.640'},{ descrip:'IVA Responsable Inscripto  Agente de Percepción' },{ descrip:'Pequeño Contribuyente Eventual' },{ descrip: 'Monotributista Social'},{ descrip: 'Pequeño Contribuyente Eventual Social'}, ] )
	client = Client.create([{cuit: '5546854', name: 'Matias', type_id: ivatypes.first.id, email: 'matias@email.com'},{cuit: '2323233', name: 'Lautaro', type_id: ivatypes.last.id, email: 'lau@hotmail.com'}])
	Phone.create(client_id: client.first.id, number: 10101010)
	Phone.create(client_id: client.last.id, number: 01010101)
	Reservation.create([{client_id:client.first.id, user_id: user.last.id, date: '5-12-2019', status: 'Disponible', total: '9'},{client_id:client.last.id, user_id: user.first.id, date: '3-1-2020', status: 'Disponible', total: '5'}])
