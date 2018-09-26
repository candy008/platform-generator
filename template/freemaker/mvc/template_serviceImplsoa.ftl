package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;
import org.springframework.stereotype.Component;
import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.manager.${mytagprizepackage}.${tb.fUpperTName}ManagerSoa;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}ServiceSoa;

@Component("${tb.fLowerTName}Service")
public class ${tb.fUpperTName}${cfb.fileNameSuffix} implements ${tb.fUpperTName}ServiceSoa{


	private ${tb.fUpperTName}ManagerSoa ${tb.fLowerTName}ManagerSoa;

	@Override
	public void insert${tb.fUpperTName}(${tb.fUpperTName} ${tb.fLowerTName}){
		${tb.fLowerTName}ManagerSoa.insert${tb.fUpperTName}(${tb.fLowerTName});	
	}
	
	@Override
	public boolean delete${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return ${tb.fLowerTName}ManagerSoa.delete${tb.fUpperTName}ById(${tb.fLowerTName});	
	}
	
	@Override
	public boolean update${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return ${tb.fLowerTName}ManagerSoa.update${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Override
	public ${tb.fUpperTName} get${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return ${tb.fLowerTName}ManagerSoa.get${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Override
	public List<${tb.fUpperTName}> get${tb.fUpperTName}All(){
		return ${tb.fLowerTName}ManagerSoa.get${tb.fUpperTName}All();
	}
	
	@Override
	public List<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query,int index){
		return ${tb.fLowerTName}ManagerSoa.get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
	}
	
	@Override
	public int get${tb.fUpperTName}ByPageCount(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}ManagerSoa.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
	}
	
	public void set${tb.fUpperTName}ManagerSoa(${tb.fUpperTName}ManagerSoa  ${tb.fLowerTName}ManagerSoa){
		this.${tb.fLowerTName}ManagerSoa = ${tb.fLowerTName}ManagerSoa;
	}
	
}