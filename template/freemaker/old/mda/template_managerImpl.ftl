package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;
import org.springframework.stereotype.Component;
import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.dao.${mytagprizepackage1}.${tb.fUpperTName}Dao;
import ${cfb.packageName}.manager.${mytagprizepackage}.${tb.fUpperTName}Manager;

@Component("${tb.fLowerTName}Manager")
public class ${tb.fUpperTName}${cfb.fileNameSuffix} implements ${tb.fUpperTName}Manager{


	private ${tb.fUpperTName}Dao ${tb.fLowerTName}Dao;

	@Override
	public void insert${tb.fUpperTName}(${tb.fUpperTName} ${tb.fLowerTName}){
		${tb.fLowerTName}Dao.insert${tb.fUpperTName}(${tb.fLowerTName});	
	}
	
	@Override
	public boolean delete${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return ${tb.fLowerTName}Dao.delete${tb.fUpperTName}ById(${tb.fLowerTName});	
	}
	
	@Override
	public boolean update${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return ${tb.fLowerTName}Dao.update${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Override
	public ${tb.fUpperTName} get${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return ${tb.fLowerTName}Dao.get${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Override
	public List<${tb.fUpperTName}> get${tb.fUpperTName}All(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.get${tb.fUpperTName}All(${tb.fLowerTName}Query);
	}
	
	@Override
	public List<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
	}
	
	@Override
	public int get${tb.fUpperTName}ByPageCount(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
	}
	
	public void set${tb.fUpperTName}Dao(${tb.fUpperTName}Dao  ${tb.fLowerTName}Dao){
		this.${tb.fLowerTName}Dao = ${tb.fLowerTName}Dao;
	}
	
}