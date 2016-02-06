class Maker {

    String name
	
    static hasMany = [drivers: Driver]

    String toString(){name}
}