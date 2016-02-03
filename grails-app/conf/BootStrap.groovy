import groovy.io.FileType
import org.apache.commons.io.FilenameUtils

class BootStrap {

    private Maker bootstrapMaker( String name ){
	    def result = Maker.findByName(name)
		if( ! result ){
		    result = new Maker( name:name ).save(flush:true)
		}
		assert result
		result
	}

    private bootstrapDriver( Maker maker, String line ){
	    println line
	}

    def init = { servletContext ->
	
	    def old = new File('old')
		assert old.isDirectory()
	
	    old.eachFileMatch(FileType.FILES, ~/.*in/){
			def maker = bootstrapMaker(FilenameUtils.getBaseName(it.name))
			it.eachLine{ line ->
			    bootstrapDriver( maker, line )
			}
		}
	
	    //assert false
	
    }
    def destroy = {
    }
}
