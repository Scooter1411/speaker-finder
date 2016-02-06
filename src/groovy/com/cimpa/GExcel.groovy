package com.cimpa

import java.sql.Date
import org.apache.log4j.Level
import org.apache.log4j.Logger
import org.apache.poi.hssf.usermodel.HSSFCell
import org.apache.poi.hssf.usermodel.HSSFRichTextString
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.ss.usermodel.Cell
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.Font
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.util.CellRangeAddress
import org.springframework.web.multipart.MultipartFile
import org.apache.poi.ss.usermodel.IndexedColors

/**
  * Simple facade around apache poi's excel
  */
@SuppressWarnings(['MethodCount','UnnecessaryPackageReference'])
class GExcel {
    
    static final ID = '$Id: GExcel.groovy 1906 2013-07-17 09:31:03Z thf11q $'

    @SuppressWarnings(['FieldName'])
	private static final Logger log = Logger.getLogger('com.cimpa.GExcel')

    private static l2i = ['A':0, 'B':1, 'C':2, 'D':3, 'E':4, 'F':5, 'G':6, 
                          'H':7, 'I':8, 'J':9, 'K':10,'L':11,'M':12,
                          'N':13,'O':14,'P':15,'Q':16,'R':17,'S':18,'T':19,
                          'U':20,'V':21,'W':22,'X':23,'Y':24,'Z':25 ]
    private static i2l = ['A','B','C','D','E','F','G','H','I','J','K','L','M',
                          'N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
    private static ctDebug = [0:'CELL_TYPE_NUMERIC',
        1:'CELL_TYPE_STRING',
        2:'CELL_TYPE_FORMULA',
        3:'CELL_TYPE_BLANK',
        4:'CELL_TYPE_BOOLEAN',
        5:'CELL_TYPE_ERROR']

    private HSSFWorkbook workbook
    private HSSFSheet    sheet
    private Integer      cursorLine
    
    static List label2index( String label ){
        assert label ==~ /[A-Z][0-9][0-9]?/
        def result = new ArrayList(2)
        result[1] = (new Integer(label[1..2])) - 1
        result[0] = l2i[label[0]]
        return result                
    }
    
    static String index2label( List index ){
        assert index.size() == 2
        return sprintf( '%1s%02d', i2l[index[0]],index[1]+1 )        
    }
    
    GExcel( File file ){
        this(new FileInputStream(file))
        assert log.level == Level.DEBUG
        log.debug "reading File: ${file.canonicalPath}"
    }

    GExcel( String file ){
        this(new File(file))
        assert log.level == Level.DEBUG
        log.debug "reading file by name: $file"
    }
    
    GExcel( MultipartFile file ){
        this(file.inputStream)
        assert log.level == Level.DEBUG
        log.debug "reading MultipartFile: ${file.originalFilename}"
    }

    GExcel( InputStream stream ){
        workbook = new HSSFWorkbook(stream)
        if( ! log.level ) log.level = Level.DEBUG
        log.debug "${workbook.numberOfSheets} sheets found"
        sheet      = workbook.getSheetAt(0)
        cursorLine = null
    }

    GExcel(){
        if( ! log.level ) log.level = Level.DEBUG
        workbook   = new HSSFWorkbook()
        sheet      = workbook.createSheet()
        cursorLine = null
    }

    GExcel( Integer cursorLine ){
        this()
        this.cursorLine = cursorLine
    }
    
    def eachSheet( Closure closure ){
        (0..(workbook.numberOfSheets - 1)).each{ 
            sheet = workbook.getSheetAt(it) 
            closure(it) 
        }
    }

    def selectSheet( index ){
        if( index >= workbook.numberOfSheets ){ 
            (workbook.numberOfSheets..(index)).each{ sheet = workbook.createSheet() }
        }else{
            sheet = workbook.getSheetAt(index) 
        } 
    }

    def eachRow( Integer start, Closure closure ){
        (start..(sheet.physicalNumberOfRows - 1)).each{ closure(it) }
    }

    def eachRow( Closure closure ){
        this.eachRow(0,closure)
    }

    String getSheetName(){
        return sheet.sheetName 
    }

    def setSheetName( String name ){ 
        workbook.setSheetName(workbook.getSheetIndex(sheet), name )
    }

    HSSFCell getAt( List pos ){
        assert pos.size() == 2
        assert pos[0] instanceof Integer
        assert pos[1] instanceof Integer
        assert sheet

        HSSFRow row = sheet.getRow(pos[1])
        row = row ?: sheet.createRow(pos[1])

        HSSFCell cell = row.getCell(pos[0],Row.CREATE_NULL_AS_BLANK)
        if( cell?.cellType == Cell.CELL_TYPE_STRING ){
                String val = cell.stringCellValue
                log.trace val
                if( val ==~ /[0-3][0-9][.][0-1][0-9][.]20[0-9][0-9]/ ){
                    cell.cellType = Cell.CELL_TYPE_NUMERIC
                }
                log.trace "[${pos[0]},${pos[1]}] [${index2label(pos)}] -> $cell (${ctDebug[cell?.cellType]})"
        }
        log.trace "[${pos[0]},${pos[1]}] [${index2label(pos)}] -> $cell (${ctDebug[cell?.cellType]})"
        return cell
    }

    HSSFCell getAt( String label ){
        if( label ==~ /[A-Z][0-9][0-9]?/ ){     
            return this[label2index(label)]
        }else{
            assert label ==~ /[A-Z]/
            assert cursorLine != null
            return this[[l2i[label],cursorLine]]
        }
    }

    void putAt( String pos, value ){
        log.trace "[$pos] <- $value"

        if( pos ==~ /[A-Z][0-9][0-9]?/ ){     
            putAt(label2index(pos),value)
        }else{
            assert pos ==~ /[A-Z]/
            assert cursorLine != null
            putAt([l2i[pos],cursorLine],value)
        }
    }
    
    void putAt( List pos, String value ){
    
        log.trace "[${pos[0]},${pos[1]}] <- $value (String)"
        def cell = this[pos]
        if( value ==~ /[0-9]+/ ){
            cell.setCellValue(new Integer(value))
        }else{
            cell.setCellValue( new HSSFRichTextString(value) )
        }
    }

    void putAt( List pos, oracle.sql.TIMESTAMP value ){
    
        putAt( pos, value.dateValue() )
    }
    
    void putAt( List pos, java.util.Date value ){    
        assert log.level == Level.DEBUG

        def cell = this[pos]
        cell.setCellValue( value )

        def cellStyle    = workbook.createCellStyle()
        def createHelper = workbook.creationHelper
        cellStyle.setDataFormat(createHelper.createDataFormat().getFormat('m/d/yy h:mm'))
        cell.setCellStyle(cellStyle)

    }

    void putAt( List pos, HSSFCell value ){    
        putAt(pos,value.toString())
    }
    
    void putAt( List pos, value ){
    
        assert ! ( value instanceof java.util.Date )
        assert ! ( value instanceof String )
        assert ! ( value instanceof HSSFCell )

        log.trace "[${pos[0]},${pos[1]}] <- $value (other: ${value?.class?.name})"
        def cell = this[pos]
        cell.setCellValue( value )
    }
    //////////////////////////////////////////////////////////////////////////
    short getHoriAlignment( String pos ){ 
        assert pos ==~ /[A-Z][0-9][0-9]?/
        return getHoriAlignment(label2index(pos)) 
    }
    short getHoriAlignment( List pos ){
        def cell = this[pos]
        def cellStyle = cell.cellStyle 
        return cellStyle.alignment
    }
    void setHoriAlignment( String pos, short alignment ){
        assert pos ==~ /[A-Z][0-9][0-9]?/
        setHoriAlignment(label2index(pos),alignment) 
    }
    void setHoriAlignment( List pos, short alignment ){
        def cell = this[pos]
        def cellStyle = workbook.createCellStyle()
        cellStyle.cloneStyleFrom(cell.cellStyle)

        cellStyle.setAlignment(alignment)
        cell.setCellStyle(cellStyle)
    }
    //////////////////////////////////////////////////////////////////////////
    short getVertiAlignment( String pos ){ 
        assert pos ==~ /[A-Z][0-9][0-9]?/
        return getVertiAlignment(label2index(pos)) 
    }
    short getVertiAlignment( List pos ){
        def cell = this[pos]
        def cellStyle = cell.cellStyle 
        return cellStyle.verticalAlignment
    }
    void setVertiAlignment( String pos, short alignment ){
        assert pos ==~ /[A-Z][0-9][0-9]?/
        setVertiAlignment(label2index(pos),alignment) 
    }
    void setVertiAlignment( List pos, short alignment ){
        def cell = this[pos]
        def cellStyle = workbook.createCellStyle()
        cellStyle.cloneStyleFrom(cell.cellStyle)

        cellStyle.setVerticalAlignment(alignment)
        cell.setCellStyle(cellStyle)
    }
    //////////////////////////////////////////////////////////////////////////
    // format helpers
    //////////////////////////////////////////////////////////////////////////    
    short getBackgroundColor( String pos ){ 
        assert pos ==~ /[A-Z][0-9][0-9]?/
        return getBackgroundColor(label2index(pos)) 
    }
    short getBackgroundColor( List pos ){
        def cell = this[pos]
        def cellStyle    = cell.cellStyle 
        return cellStyle.fillBackgroundColor
    }
    void setBackgroundColor( String pos, short color ){

        assert pos ==~ /[A-Z][0-9][0-9]?/

        setBackgroundColor(label2index(pos),color) 
    }
    void setBackgroundColor( List pos, short color ){

        assert pos.size() == 2
        assert pos[0] instanceof Integer
        assert pos[1] instanceof Integer

        def cell = this[pos]
        def cellStyle    = workbook.createCellStyle()
        cellStyle.cloneStyleFrom(cell.cellStyle)

        cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND)
        cellStyle.setFillForegroundColor(color)
        cellStyle.setFillBackgroundColor(color)
        cell.setCellStyle(cellStyle)
    }
    //////////////////////////////////////////////////////////////////////////
    // font helpers
    //////////////////////////////////////////////////////////////////////////  
    void setBold( String pos ){ 
        assert pos ==~ /[A-Z][0-9][0-9]?/
        setBold(label2index(pos)) 
    }
    void setBold( List pos ){
        def cell = this[pos]
        def font = workbook.createFont()
        font.setBoldweight(Font.BOLDWEIGHT_BOLD)
        def cellStyle    = workbook.createCellStyle()
        cellStyle.cloneStyleFrom(cell.cellStyle)

        cellStyle.setFont(font)
        cell.setCellStyle(cellStyle)
    }
    //////////////////////////////////////////////////////////////////////////
    // freezing
    //////////////////////////////////////////////////////////////////////////    
    void freeze( String pos ){
        assert pos ==~ /[A-Z][0-9][0-9]?/
        freeze(label2index(pos)) 
    }
    void freeze( List pos ){sheet.createFreezePane( pos[0], pos[1] )}
    void unfreeze(){freeze([0,0])}
    //////////////////////////////////////////////////////////////////////////
    // filter
    //////////////////////////////////////////////////////////////////////////    
    void setAutoFilter(){
        def lastRow = sheet.lastRowNum
        assert lastRow > 0
        def lastCol = 0
        (0..lastRow).each{
            def thisCol = sheet.getRow(it).lastCellNum
            lastCol = lastCol < thisCol ? thisCol : lastCol
        }
        assert lastCol > 0
        sheet.setAutoFilter(new CellRangeAddress(0, lastRow, 0, lastCol - 1))
    }
    //////////////////////////////////////////////////////////////////////////
    // column width
    //////////////////////////////////////////////////////////////////////////    
    BigDecimal getColumnWidth( String col ){
        assert col ==~ /[A-Z]/
        return getColumnWidth(l2i[col[0]]) 
    }
    BigDecimal getColumnWidth( Integer col ){
        return sheet.getColumnWidth(col)
    }
    void setColumnWidth( String col, BigDecimal width ){
        assert col ==~ /[A-Z]/
        setColumnWidth(l2i[col[0]],width) 
    }
    void setColumnWidth( Integer col, BigDecimal width ){
        sheet.setColumnWidth(col, width.intValue() )
    }
    void autoColumnWidth( String col ){
        assert col ==~ /[A-Z]/
        autoColumnWidth(l2i[col[0]]) 
    }
    void autoColumnWidth( Integer col ){
        sheet.autoSizeColumn( col ) 
    }
    //////////////////////////////////////////////////////////////////////////
    // output
    //////////////////////////////////////////////////////////////////////////    
    void write( OutputStream out ){
        eachSheet{ index ->
            def max = 0
            (0..2).each{ i ->
                def row = sheet.getRow(i)
                def last = 0
                if( row ) last = row.lastCellNum
                if( max < last ) max = last
            }
            (0..max).each{ 
                sheet.autoSizeColumn( it ) 
                // heuristically auto :-)
                sheet.setColumnWidth( it, ( sheet.getColumnWidth(it) * 13 / 10 ).intValue() ) 
            }
            sheet.setZoom(7,10)
            //sheet.setAutoFilter(CellRangeAddress.valueOf("A1:N1"));
        }
        workbook.write( out )
        out.close()
    }

    void write( String out ){ 
        write(new File(out))
    }

    void write( File out){
        write(out.newOutputStream()) 
    }

    //////////////////////////////////////////////////////////////////////////
    // debug
    //////////////////////////////////////////////////////////////////////////   
    void debugSheet(){ 
        sheet = workbook.createSheet()
        setSheetName('DEBUG')
            this[0,0] = 'FontName'            
            this[1,0] = 'Color'
            this[2,0] = 'FontHeight'
            this[3,0] = 'Boldweight'
            this[4,0] = 'Italic'
            this[5,0] = 'FontName'
        (0..5).each{ col -> setBackgroundColor([col,0],IndexedColors.YELLOW.index)}
        (0..(workbook.numberOfFonts-1)).each{
            this[0, it+1] = workbook.getFontAt(it.shortValue()).fontName            
            this[1, it+1] = workbook.getFontAt(it.shortValue()).color
            this[2, it+1] = workbook.getFontAt(it.shortValue()).fontHeight
            this[3, it+1] = workbook.getFontAt(it.shortValue()).boldweight == Font.BOLDWEIGHT_NORMAL ? 'normal' : 'bold'
            this[4, it+1] = workbook.getFontAt(it.shortValue()).italic
            this[5, it+1] = workbook.getFontAt(it.shortValue()).fontName

            (0..5).each{ col -> setBackgroundColor([col, it+1],IndexedColors.LIGHT_YELLOW.index)}
        }
    }

    java.sql.Date guessDate(String label){ 
        if( label ==~ /[A-Z][0-9][0-9]?/ ){     
            return guessDate( label2index(label) )
        }else{
            assert label ==~ /[A-Z]/
            assert cursorLine != null
            return guessDate([l2i[label],cursorLine])
        }
    }

    java.sql.Date guessDate( List pos ){
        def input  = this[pos]
        java.sql.Date output 
        switch( input.cellType ){ 
        case Cell.CELL_TYPE_BLANK   : output = null
                                      break
        case Cell.CELL_TYPE_NUMERIC : output = new java.sql.Date(0L)
                                      output.time = input.dateCellValue.time 
                                      break
        case Cell.CELL_TYPE_STRING  : output = crystalBall(input.stringCellValue)
                                      break
        default : assert false
        }
        log.debug "guessDate $input ${ctDebug[input?.cellType]} -> $output"
        return output
    }

    /***********************************************************************************/
    /*** BEWARE, brain damage ahead                                                  ***/
    /***  - the big maps are performance optimizations (or something like that ;-)   ***/
    /***  - this is a port from awk, so it does not use any possible groovy syntax   ***/
    /***    sugar (yet)                                                              ***/
    /***  - this code will self-destruct in December 2019                            ***/
    /***********************************************************************************/

    // pattern to match a 4 digit year
    private static final YEAR4    = /(19[6-9]|20[01])[0-9]/
    // pattern to match a 2 digit year
    private static final YEAR2    = /[67890][0-9]/
    // pattern to match a 2 or 4 digit year
    private static final YEAR24   = /((19[6-9]|20[01])|[67890])[0-9]/
    // pattern to match a 1, 2 or 4 digit year
    private static final YEAR124  = /((19[6-9]|20[01])|[67890])?[0-9]/

    // pattern to match a 2 digit month 
    private static final MONTH2   = /(0[1-9]|1[0-2])/
    // pattern to match a 1 or 2 digit month
    private static final MONTH12  = /((0[1-9]|1[0-2])|[1-9])/
    // pattern to match a alphanumeric month with minor perversions
    private static final MONTH    = /[JFMASONDCLafjmos][a-zäA-Z]+/

    // pattern to match a 2 digit day
    private static final DAY2     = /(0[1-9]|[12][0-9]|3[01])/
    // pattern to match a 1 or 2 digit day
    private static final DAY12    = /(0[1-9]|[12][0-9]|3[01]|[1-9])/

    // map slightly perverted written month to numeric month
    // TODO function and regex instead of mapping table, we are fast enough
    private static monthMap = [
        'JAN':'01','JAN,':'01','JAN.':'01','Ja':'01','Ja.':'01','Jan':'01',
        'Jan,':'01','Jan.':'01','Jan.,':'01','Januar':'01','January':'01',
        'January,':'01','Jna':'01','Jna.':'01',        

        'FEB':'02','FEb':'02','Fb':'02','Feb':'02','Feb,':'02','Feb.':'02',
        'Febr':'02','Febr.,':'02','Febr.':'02','February':'02','feb':'02',      
  
        'MAR':'03','MAr':'03','Maar':'03','Mar':'03','Mar,':'03','Mar.':'03',
        'March':'03','March,':'03','Marr':'03','Marr.':'03','Mrz':'03',
        'Mrz.':'03','März':'03','mar':'03','march':'03',

        'APR':'04','APR.':'04','Appr':'04','Apr':'04','Apr,':'04','Apr.':'04',
        'Apr:':'04','April':'04','April,':'04','Ar':'04','Ar.':'04','april':'04',
        'apr':'04',

        'MAY':'05','Mai':'05','May':'05','May,':'05','May/':'05','May-':'05',
        'May.':'05','may':'05','may.':'05','mai':'05',

        'JUN':'06','JUIN':'06','Jun':'06','jun':'06','Jun.':'06','Jun,':'06',
        'Jun/':'06','June':'06','June,':'06','Juni':'06','june':'06',   
     
        'JUL':'07','JUl':'07','JULY':'07','JUly':'07','Jul':'07','Jul.':'07',
        'JUL.':'07','Jul,':'07','Juli':'07','Jull':'07','July':'07','July,':'07',
        'July.':'07','jul':'07','Lul':'07','july/':'07',      
  
        'Ag':'08','AUG':'08','AUG.':'08','Au':'08','Au.':'08','Aug':'08',
        'aug.':'08','Aug,':'08','Aug/':'08','Aug.':'08','August':'08','aug':'08',

        'SEP':'09','SEP.':'09','SEPT':'09','SEp':'09','Sep':'09','Sep,':'09',
        'Sep.':'09','Sept':'09','Sept.':'09','Sept-':'09','September':'09',
        'Spt':'09','sept':'09','sept.':'09','sep':'09', 
       
        'Cot':'10','Cot.':'10','OCT':'10','OCT.':'10','OKT':'10','Oct':'10',
        'Oct,':'10','Oct.':'10','October':'10','Okt':'10','Okt.':'10','oct':'10',    
    
        'NOV':'11','NOV.':'11','Nov':'11','Nov,':'11','Nov.':'11',
        'November':'11', 

        'DEC':'12','DEC.':'12','DEc':'12','Dec':'12','Dec,':'12','Dec.':'12',
        'December':'12','Dez':'12','Dez.':'12'
    ]

    @SuppressWarnings(['AbcComplexity', 'CyclomaticComplexity', 'MethodSize'])
    static java.sql.Date crystalBall( String inDat ){ 
    
        def tmpOld = inDat
    
        inDat = inDat.replaceAll(/^["]/,'')           //"
        inDat = inDat.replaceAll(/["]$/,'')           //"
    
        inDat = inDat.replaceAll('[+].*','')
        inDat = inDat.replaceAll('[(].*','')
        inDat = inDat.replaceAll(' u[.].*','')
        inDat = inDat.replaceAll('^[>~ ]+','')
        inDat = inDat.replaceAll('[- ]+\$','')
    
        if( inDat =~ '/.*/.*/.*/.*/' ) inDat = inDat.replaceAll(' */[^/]*/[^/]*/[^/]*\$','')
        if( inDat =~ '-.*-.*-.*-.*-' ) inDat = inDat.replaceAll(' *-[^-]*-[^-]*-[^-]*\$','')
        if( inDat =~ '/.*/.*,.*/.*/' ) inDat = inDat.replaceAll(' *,.*\$','')
        if( inDat =~ "${DAY2}/${DAY2}[/-]${MONTH2}[/-]${YEAR4}" ) inDat = inDat.replaceAll('^[^/]*/','')
    
        inDat = inDat.replaceAll('N ov','Nov')
        inDat = inDat.replaceAll(' rd','rd')
        inDat = inDat.replaceAll('19999','1999')
        inDat = inDat.replaceAll('102003','10.2003')
        inDat = inDat.replaceAll('/12003','/1/2003')
        inDat = inDat.replaceAll(',02003',',2003')
        inDat = inDat.replaceAll('20001','2001')
        inDat = inDat.replaceAll('20000','2000')
        inDat = inDat.replaceAll('20044','2004')
        inDat = inDat.replaceAll('29004','2004')
        inDat = inDat.replaceAll('2204','2004')
        inDat = inDat.replaceAll('^1003','2003')
        inDat = inDat.replaceAll(', 19 98',', 1998')
        inDat = inDat.replaceAll('^Wednesday, ','')
        inDat = inDat.replaceAll('^Thales.','')
        inDat = inDat.replaceAll('^[oO0]rg[.]? ','')
        inDat = inDat.replaceAll('^Monday, ','')
        inDat = inDat.replaceAll('303','30')
    
        inDat = inDat.replaceAll('[.]+','.')
        inDat = inDat.replaceAll('//+','/')
        inDat = inDat.replaceAll('--+','-')
        inDat = inDat.replaceAll(' +/','/')
        inDat = inDat.replaceAll(' +-','-')
        inDat = inDat.replaceAll(' +,',',')
        inDat = inDat.replaceAll(' +[.]','.')
        inDat = inDat.replaceAll('_+','-')
        inDat = inDat.replaceAll(':+','.')
        inDat = inDat.replaceAll('  +',' ')
        inDat = inDat.replaceAll('-[*]','-')

        inDat = inDat.replaceAll('([A-Za-z])([0-9])','$1 $2')
        
        if( tmpOld != inDat ) log.info "crystalBall global '$tmpOld' -> '$inDat'" 

        def daMoYe
        def day
        def month
        def year
        def tmpSwp
        //-------------------------------------------------------------- numerischer Monat
        switch( inDat ){ 
        case ~/${DAY12}[*] ?${MONTH12}[*] ?${YEAR124}/ : 
            daMoYe = inDat.tokenize('*')
            day = daMoYe[0]; month = daMoYe[1]; year = daMoYe[2]
            break
        case ~/${DAY12}, ?${MONTH12}, ?${YEAR124}/ :
            daMoYe = inDat.tokenize(',')
            day = daMoYe[0]; month = daMoYe[1]; year = daMoYe[2]
            break
        case ~/${YEAR4}\/ ?${MONTH12}\/ ?${DAY12}/ :
            daMoYe = inDat.tokenize('/')
            year = daMoYe[0]; month = daMoYe[1]; day = daMoYe[2]
            break
        case ~/ ?${DAY12}\/ ?${MONTH12}\/ ?${YEAR124}/:
            daMoYe = inDat.tokenize('/')
            day = daMoYe[0]; month = daMoYe[1]; year = daMoYe[2]
            break
        case ~/ ?${MONTH12}\/ ?${DAY12}\/ ?${YEAR124}/:
            daMoYe = inDat.tokenize('/')
            month = daMoYe[0]; day = daMoYe[1]; year = daMoYe[2]
            break
        case ~/${DAY12}\/${MONTH12}\/&${YEAR124}/:
            daMoYe = inDat.tokenize('/')
            day = daMoYe[0]; month = daMoYe[1]; year = daMoYe[2][1..2]
            break
        case ~/${YEAR2}\/${MONTH12}\/${DAY2}/:
            daMoYe = inDat.tokenize('/')
            year = daMoYe[0]; month = daMoYe[1]; day = daMoYe[2]
            break
        case ~/[0-9][0-9]\/[0-9][0-9]7[0-9][0-9]/:
            daMoYe = inDat.tokenize('/')
            day = daMoYe[0]; month = daMoYe[1][0..1]; year = daMoYe[1][3..4]
            break
        case ~/[0-9][0-9]\/[0-9][0-9]\/${YEAR4}/:
            daMoYe = inDat.tokenize('/')
            month = daMoYe[0]; day = daMoYe[1]; year = daMoYe[2]
            break
        case ~/[0-9][0-9]?\/[0-9][0-9]? ${YEAR124}/:
            daMoYe = inDat.tokenize('/')
            month = daMoYe[0];
            daMoYe = daMoYe[1].tokenize(' ')
            day = daMoYe[0]; year = daMoYe[1]
            break
        case ~/[0-9][0-9]?\/[0-9][0-9]?-${YEAR124}/:
            daMoYe = inDat.tokenize('/')
            month = daMoYe[0];
            daMoYe = daMoYe[1].tokenize('-')
            day = daMoYe[0]; year = daMoYe[1]
            break
        //------------
        case ~/0[0-9]-[1-9]-[1-9]/:
            daMoYe = inDat.tokenize('-')
            year = daMoYe[0]; month = daMoYe[1]; day = daMoYe[2]
            break
        case ~/${MONTH12}-0?${DAY12}-[- ]?${YEAR124}/:
            daMoYe = inDat.tokenize('-')
            month = daMoYe[0]; day = daMoYe[1]; year = daMoYe[2]
            break
        case ~/${DAY12}-${MONTH12}-[- ]?${YEAR124}/:
            daMoYe = inDat.tokenize('-')
            day = daMoYe[0]; month = daMoYe[1]; year = daMoYe[2]
            break
        case ~/[0-9][0-9]?-[0-9][0-9]? ${YEAR124}/:
            daMoYe = inDat.tokenize('-')
            month  = daMoYe[0]
            daMoYe = daMoYe[1].tokenize(' ')
            day    = daMoYe[0]; year   = daMoYe[1]
            break
        case ~/[0-9][0-9]?-[0-9][0-9]?[.]${YEAR124}/:
            //------------ Default: Month first
            daMoYe = inDat.tokenize('-')
            month  = daMoYe[0]
            daMoYe = daMoYe[1].tokenize('.')
            day    = daMoYe[0]; year   = daMoYe[1]
            break
        case ~/${YEAR124}-${MONTH12}-${DAY12}/:
            daMoYe = inDat.tokenize('-')
            year = daMoYe[0]; month = daMoYe[1]; day = daMoYe[2]
            break
        case ~/${YEAR124}-${DAY12}-${MONTH12}/:
            daMoYe = inDat.tokenize('-')
            year = daMoYe[0]; day = daMoYe[1]; month = daMoYe[2]
            break
        case ~/[0-9][0-9]-[0-9][0-9][0-9][0-9]/:
            month = inDat[0..1]; day = inDat[3..4]; year = inDat[5..6]
            break
        //------------
        case ~/[0 ]?${DAY12}[.] ?${MONTH12}[.] ?${YEAR24}/:
            daMoYe = inDat.tokenize('.')
            day = daMoYe[0]; month = daMoYe[1]; year = daMoYe[2]
            break
        case ~/${YEAR2}[.] ?${MONTH12}[.] ?${DAY12}/:
            //------------ leading 0 -> ymd
            daMoYe = inDat.tokenize('.')
            year = daMoYe[0]; month = daMoYe[1]; day = daMoYe[2]
            break
        case ~/${MONTH12}[.] ?${DAY12}[.] ?${YEAR24}/:
            daMoYe = inDat.tokenize('.')
            month = daMoYe[0]; day = daMoYe[1]; year = daMoYe[2]
            break
        case ~/[0-9][0-9][0-9][.][0-9][.] ?${YEAR24}/:
            daMoYe = inDat.tokenize('.')
            day = daMoYe[0][0..1]; month = daMoYe[0][2] + daMoYe[1]; year = daMoYe[2]
            break
        case ~/[0-9][0-9][.] ?[0-9]?[0-9], ?${YEAR24}/:
            daMoYe = inDat.tokenize('.')
            day = daMoYe[0];
            daMoYe = daMoYe[1].tokenize(',')
            month = daMoYe[0]
            year  = daMoYe[1]
            break
        //------------
        case ~/[0-9][0-9] [0-9][0-9] ${YEAR24}/:
            daMoYe = inDat.tokenize(' ')
            day = daMoYe[0]; month = daMoYe[1]; year = daMoYe[2]
            break
        case ~/[0-9][0-9]\/[0-9][0-9][0-9]\/[0-9]/:
            daMoYe = inDat.tokenize('/')
            day = daMoYe[0]; month = daMoYe[1][0..1]; year = daMoYe[1][2] + daMoYe[2]
            break
        case ~/(19[6-9]|20[01])[0-9] [0-9]?[0-9][.][0-9]?[0-9]/:
            daMoYe = inDat.tokenize(' ')
            year   = daMoYe[0]
            daMoYe = daMoYe[1].tokenize('.')
            day    = daMoYe[0]; month  = daMoYe[1]
            break
        //------------ Mitte: textueller Monat
        case ~/[0-9][0-9]?-${MONTH}[.]?-${YEAR24}/:
            daMoYe = inDat.tokenize('-')
            day = daMoYe[0]; month = monthMap[daMoYe[1]]; year = daMoYe[2] 
            break
        case ~/(19[6-9]|20[01])[0-9](-${MONTH}-|[.]${MONTH}[.]| ${MONTH} )[0-9][0-9]/:
            daMoYe = inDat.tokenize(inDat[4])
            year = daMoYe[0]; month = monthMap[daMoYe[1]]; day = daMoYe[2] 
            break
        case ~/(19[6-9]|20[01])[0-9]${MONTH}[0-9][0-9]/:
            year = inDat[0..3]; month = monthMap[inDat[4..-1].replaceAll(/[0-9]/,'')]
            day = inDat[4..-1].replaceAll(/[^0-9]/,'')
            break
        case ~/(19[6-9]|20[01])[0-9]-${MONTH} [0-9][0-9]/:
            year = inDat[0..3]; month = monthMap[inDat[5..-1].replaceAll(/[0-9 ]/,'')]
            day = inDat[5..-1].replaceAll(/[^0-9]/,'')
            break
        case ~/(19[6-9]|20[01])[0-9] ${MONTH} [0-9]?[0-9](st|nd|rd|th|ST)/:
            daMoYe = inDat.tokenize(' ')
            year = daMoYe[0]; month = monthMap[daMoYe[1]]; day = daMoYe[2].replaceAll(/[^0-9]/,'')
            break
        case ~/[0-9][0-9]\/${MONTH}\/${YEAR24}/:
            daMoYe = inDat.tokenize('/')
            day = daMoYe[0]; month = monthMap[daMoYe[1]]; year = daMoYe[2]
            break
        case ~/[ 0-9]?[0-9][.,-]? ${MONTH}[.,-]* +${YEAR24}/:
            daMoYe = inDat.tokenize(' ')
            day = daMoYe[0].replaceAll(/[^0-9]/,''); month = monthMap[daMoYe[1]]; year = daMoYe[2]
            break
        case ~/[ 0-9]?[0-9](st|nd|rd|th|ST) ${MONTH}[.,-]* +${YEAR24}/:
            daMoYe = inDat.tokenize(' ')
            day = daMoYe[0].replaceAll(/[^0-9]/,''); month = monthMap[daMoYe[1]]; year = daMoYe[2]
            break
        case ~/(19[6-9]|20[01])[0-9][.]? ${MONTH}[.]? +[0-9][0-9]?/:
            daMoYe = inDat.tokenize(' ')
            year = daMoYe[0]; month = monthMap[daMoYe[1]]; day = daMoYe[2]
            break
        case ~/[0-9][0-9]?[.]? ${MONTH}[.\/]?${YEAR24}/:
            daMoYe = inDat.tokenize(' ')
            day = daMoYe[0]; month = monthMap[daMoYe[1].replaceAll(/[.0-9\/]/,'')]
            year = daMoYe[1].replaceAll(/[^0-9]/,'')
            break
        case ~/[0-9][0-9]?[.]? ${MONTH}[.]? +20[0-9]/:
            daMoYe = inDat.tokenize(' ')
            day = daMoYe[0]; month = monthMap[daMoYe[1]]; year = new Integer(daMoYe[2]) + 1800
            break
        case ~/[0-9][0-9]?[.] ?${MONTH}[.] ?${YEAR24}/:
            daMoYe = inDat.tokenize('.')
            day = daMoYe[0]; month = monthMap[daMoYe[1].replaceAll(/ /,'')]; year = daMoYe[2]
            break
        case ~/[0-9][0-9]?[.]${MONTH}[ \/,]${YEAR24}/:
            daMoYe = inDat.tokenize('.')
            day = daMoYe[0]; month = monthMap[daMoYe[1].replaceAll(/[.0-9\/]/,'')]
            year = daMoYe[1].replaceAll(/[^0-9]/,'')
            break
        case ~/[0-9][0-9]?-${MONTH}[ \/]${YEAR24}/:
            daMoYe = inDat.tokenize('-')
            day = daMoYe[0]; month = monthMap[daMoYe[1].replaceAll(/[.0-9\/]/,'')]
            year = daMoYe[1].replaceAll(/[^0-9]/,'')
            break
        case ~/[0-9][0-9]?\/${MONTH}[ .]${YEAR24}/:
            daMoYe = inDat.tokenize('/')
            day = daMoYe[0]; month = monthMap[daMoYe[1].replaceAll(/[.0-9\/]/,'')]
            year = daMoYe[1].replaceAll(/[^0-9]/,'')
            break
        case ~/[0-9][0-9]${MONTH}[., ]?${YEAR24}/:
            day = inDat[0..1]; month = monthMap[inDat.replaceAll(/[.0-9\/ ]/,'')]
            year = inDat[2..-1].replaceAll(/[^0-9]/,'')
            log.trace "2 $day ${inDat.replaceAll(/[.0-9\/]/,'')} $month $year"
            break
        case ~/[0-9]${MONTH}[., ]?${YEAR24}/:
            day = inDat[0]; month = monthMap[inDat.replaceAll(/[.0-9\/ ]/,'')]
            year = inDat[1..-1].replaceAll(/[^0-9]/,'')
            break
        //------------ Anfang: textueller Monat
        case ~/${MONTH} ${DAY12},? ${YEAR24}/:
            daMoYe = inDat.tokenize(' ')
            month = monthMap[daMoYe[0]]; day = daMoYe[1].replaceAll(/[^0-9]/,'')
            year = daMoYe[2]
            break
        case ~/${MONTH} ${DAY12},${YEAR24}/:
            daMoYe = inDat.tokenize(',')
            month = monthMap[daMoYe[0].replaceAll(/[0-9 ]/,'')]
            day = daMoYe[0].replaceAll(/[^0-9]/,''); year = daMoYe[1]
            break
        case ~/${MONTH} ${DAY12}\/${YEAR24}/:
            daMoYe = inDat.tokenize('/')
            month = monthMap[daMoYe[0].replaceAll(/[0-9 ]/,'')] 
            day = daMoYe[0].replaceAll(/[^0-9]/,''); year = daMoYe[1]
            break
        case ~/${MONTH}-${DAY12}-${YEAR24}/:
            daMoYe = inDat.tokenize('-')
            month = monthMap[daMoYe[0]]; day = daMoYe[1]; year = daMoYe[2]
            break
        case ~/${MONTH}-${DAY12}[.]${YEAR24}/:
            daMoYe = inDat.tokenize('.')
            year = daMoYe[1] 
            daMoYe = daMoYe[0].tokenize('-')
            month = monthMap[daMoYe[0]]
            tmpSwp = daMoYe[2]; day = daMoYe[1]
            break
        case ~/${MONTH}[.]?, ?${DAY12}[.]?, ?${YEAR24}/:
            daMoYe = inDat.tokenize(',')
            month = monthMap[daMoYe[0]]; day = daMoYe[1].replaceAll(/[^0-9]/,''); year = daMoYe[2]
            break
        case ~/${MONTH}[.]?\/ ?${DAY12}[.]?\/ ?${YEAR24}/:
            daMoYe = inDat.tokenize('/')
            month = monthMap[daMoYe[0]]; day = daMoYe[1].replaceAll(/[^0-9]/,''); year = daMoYe[2]
            break
        case ~/${MONTH}[.][0-9][0-9][,\/ ] ?((19[6-9]|20[01])|[67890´])[0-9]/:
            daMoYe = inDat.tokenize('.')
            month = monthMap[daMoYe[0]]; day = daMoYe[1][0..1]; year = daMoYe[1][3..-1].replaceAll(/[^0-9]/,'')
            break
        case ~/${MONTH}[.][0-9][,\/ ] ?((19[6-9]|20[01])|[67890´])[0-9]/:
            daMoYe = inDat.tokenize('.')
            month = monthMap[daMoYe[0]]; day = daMoYe[1][0]; year = daMoYe[1][2..-1].replaceAll(/[^0-9]/,'')
            break
        case ~/${MONTH}[.][0-9][0-9]?[.] ?((19[6-9]|20[01])|[67890´])[0-9]/:
            daMoYe = inDat.tokenize('.')
            month = monthMap[daMoYe[0]]; day = daMoYe[1]; year = daMoYe[2].replaceAll(/[^0-9]/,'')
            break
        case ~/${MONTH}[.][0-9][0-9][,\/ ] ?20[0-9]/:
            daMoYe = inDat.tokenize('.')
            month = monthMap[daMoYe[0]]; day = daMoYe[1][0..1]; year = daMoYe[1][2..-1].replaceAll(/[^0-9]/,'')
            break
        case ~/${MONTH}[.,:]? ${DAY12}[.\/,]* ${YEAR124}/:
            daMoYe = inDat.tokenize(' ')
            month = monthMap[daMoYe[0]]; day = daMoYe[1].replaceAll(/[^0-9]/,''); year = daMoYe[2]
            break
        case ~/${MONTH}[.,]? +[0-9][0-9][-\/.,]${YEAR24}/:
            daMoYe = inDat.tokenize(' ')
            month = monthMap[daMoYe[0]]; day = daMoYe[1][0..1]; year = daMoYe[1][3..-1]
            break
        case ~/${MONTH}[.,]? +[0-9]?[0-9](st|nd|rd|th|ST|St|t)[\/,.]? +${YEAR24}/:
            daMoYe = inDat.tokenize(' ')
            month = monthMap[daMoYe[0]]; day = daMoYe[1].replaceAll(/[^0-9]/,''); year = daMoYe[2]
            break
        case ~/${MONTH}[.,]? +[0-9]?[0-9](st|nd|rd|th|ST|St) +[\/,] +${YEAR24}/:
            daMoYe = inDat.tokenize(' ')
            month = monthMap[daMoYe[0]]; day = daMoYe[1].replaceAll(/[^0-9]/,''); year = daMoYe[3]
            break
        case ~/${MONTH}[.,]? +[0-9]?[0-9](st|nd|rd|th|ST),? +20[0-9]/:
            daMoYe = inDat.tokenize(' ')
            month = monthMap[daMoYe[0]]; day = daMoYe[1].replaceAll(/[^0-9]/,''); year = daMoYe[2]
            break
        //------------ nur Monat/Jahr
        case ~/[JFMASONDCLafjmos][a-zäA-Z]+[-.,\/ ]*((19[6-9]|20[01])|[67890])[0-9]/:
            day = '01'; month = monthMap[inDat.replaceAll(/[-0-9.,\/ ]/,'')]; year = inDat.replaceAll(/[^0-9]/,'')
            log.trace "1 $day $month $year"
            break
        case ~/(0[0-9]|1[0-2])[-.\/ ]${YEAR24}/:
            day = '01'; month = inDat[0..1]; year = inDat[3..-1]
            break
        case ~/[1-9][-.\/ ]${YEAR24}/:
            day = '01'; month = inDat[0]; year = inDat[2..-1]
            break
        case ~/(19[6-9]|20[01])[0-9][-.\/ ](0[0-9]|1[0-2])/:
            year = inDat[0..3]; day = '01'; month = inDat[5..-1]
            break
        case ~/[67890][0-9][-.\/ ](0[0-9]|1[0-2])/:
            year = inDat[0..1]; day = '01'; month = inDat[3..-1]
            break
        //------------ nur Jahr
        case ~/${YEAR24}/:
            day   = '01'; month = '01'; year  = inDat
            break
        //------------ nichts verstanden
        default: 
            log.error "crystalBall strange date $inDat (no case)"
            return null
        }
        if( day && month && year ){ 
            if( year instanceof String ){ 
                year = new Integer(year.replaceAll(/[^0-9]/,''))
            }
            if(( year >= 66 )&&( year < 100 )){
                year += 1900
            } else if( year <= 9 ) {
                year += 2000
            } else if(( year >= 200 )&&( year <= 219 )){ 
                year += 1800
            }
            //------------ das sollte nicht passieren
            if( year < 1966 || year > 2019 ){
                log.error "crystalBall strange date $inDat -> ${day}/${month}/${year} (year out of bounds)"
                return null
            } 
            month = new Integer(month.replaceAll(/[^0-9]/,''))
            day = new Integer(day.replaceAll(/[^0-9]/,''))

            // I've always looked for a usage of this syntax ;-)
            if(( month > 12 )&&( day <= 12 ))     (month, day) = [day, month]

            if( month > 12 || month < 1 ){
                log.error "crystalBall strange date $inDat -> ${day}/${month}/${year} (month out of bounds)"
                return null
            } 
            Boolean tooMany 
            def febMax = ((year % 4 ) == 0 ) ? 29 : 28
            switch( month ){
            case  1: tooMany = ( day >     31 ); break;
            case  2: tooMany = ( day > febMax ); break;
            case  3: tooMany = ( day >     31 ); break;
            case  4: tooMany = ( day >     30 ); break;
            case  5: tooMany = ( day >     31 ); break;
            case  6: tooMany = ( day >     30 ); break;
            case  7: tooMany = ( day >     31 ); break;
            case  8: tooMany = ( day >     31 ); break;
            case  9: tooMany = ( day >     30 ); break;
            case 10: tooMany = ( day >     31 ); break;
            case 11: tooMany = ( day >     30 ); break;
            case 12: tooMany = ( day >     31 ); break;
            }
            if( tooMany ){ 
                log.error "crystalBall strange date $inDat -> ${day}/${month}/${year} (day out of bounds)"
                return null
            }
            log.info "crystalBall final $tmpOld -> $daMoYe -> ${day}/${month}/${year}"
            def output = Date.parse('dd/MM/yyyy',"${day}/${month}/${year}")
            return new java.sql.Date(output.time)
        }else{
            log.error "crystalBall failed $tmpOld -> $daMoYe"
            return null 
        }
    }
    /**
     *  
     */

}

