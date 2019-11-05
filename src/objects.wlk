import ubicacion.*
import certificacion.*

class Vendedor {
	var property ubicacion
	var property certificaciones = #{}
	
	method puedeTrabajarEnCiudad(ciudad)
	
	method esVersatil(){
		return ((certificaciones.size() >= 3) and
			(certificaciones.any({c => c.esSobreProductos()})) and
			(certificaciones.any({c =>not c.esSobreProductos()}))
			)
	}
	
	method esFirme(){
		return ( certificaciones.sum({c=> c.puntos()}) >= 30)
	}
	
	method esInfluyente()
}

class VendedorFijo inherits Vendedor {
	const property ciudadVivienda = ""

	override method puedeTrabajarEnCiudad(ciudad){
		return (ciudadVivienda == ciudad )
	}
	
	override method esInfluyente(){
		return false
	}
}

class VendedorViajante inherits Vendedor {
	var property provinciasHabilitadas = #{}
	
	override method puedeTrabajarEnCiudad(ciudad){
		return (provinciasHabilitadas.any({c => c.ubicacion().ciudad() == ciudad}))
	}
	
	override method esInfluyente(){
		var poblacion = provinciasHabilitadas.sum({c=> c.ubicacion().poblacionProvincia()})
		return (poblacion >= 10000000) 
	}
	
}

class ComercioCorresponsal inherits Vendedor {
	var property sucursales = #{}
	
	override method puedeTrabajarEnCiudad(ciudad){
		return (sucursales.any({c => c.ubicacion().ciudad() == ciudad}))
	}
	
	method tieneAlMenos5sucursales(){
		return (sucursales.size() >= 5)
	}
	
	method tieneAlMenos3Provincias(){ //devuelve true si la coleccion de provincias es mayor a 3
		var provincias = #{}
		sucursales.map({c=> provincias.add(c.ubicacion().provincia())})
		return (provincias.size() >=3)
	}
	override method esInfluyente(){
		return (self.tieneAlMenos3Provincias() or self.tieneAlMenos5sucursales())
	}
}

