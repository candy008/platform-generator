package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;
import com.jd.common.util.PaginatedList;
import com.jd.common.util.base.PaginatedArrayList;

import org.springframework.stereotype.Component;
import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.manager.${mytagprizepackage}.${tb.fUpperTName}Manager;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;

@Component("${tb.fLowerTName}Service")
public class ${tb.fUpperTName}${cfb.fileNameSuffix} implements ${tb.fUpperTName}Service{


	private ${tb.fUpperTName}Manager ${tb.fLowerTName}Manager;

	@Override
	public void insert${tb.fUpperTName}(${tb.fUpperTName} ${tb.fLowerTName}){
		${tb.fLowerTName}Manager.insert${tb.fUpperTName}(${tb.fLowerTName});	
	}
	
	@Override
	public boolean delete${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return ${tb.fLowerTName}Manager.delete${tb.fUpperTName}ById(${tb.fLowerTName});	
	}
	
	@Override
	public boolean update${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return ${tb.fLowerTName}Manager.update${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Override
	public ${tb.fUpperTName} get${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return ${tb.fLowerTName}Manager.get${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Override
	public List<${tb.fUpperTName}> get${tb.fUpperTName}All(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Manager.get${tb.fUpperTName}All(${tb.fLowerTName}Query);
	}
	
	@Override
	public PaginatedList<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		
		PaginatedList<${tb.fUpperTName}> ${tb.fLowerTName}PageList = new PaginatedArrayList<${tb.fUpperTName}>(${tb.fLowerTName}Query.getIndex(), ${tb.fLowerTName}Query.getPageSize());
		int total = ${tb.fLowerTName}Manager.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
		${tb.fLowerTName}PageList.setTotalItem(total);
		${tb.fLowerTName}Query.setStartRow(${tb.fLowerTName}PageList.getStartRow());
		${tb.fLowerTName}Query.setEndRow(${tb.fLowerTName}PageList.getEndRow());
		List<${tb.fUpperTName}> ${tb.fLowerTName}List = ${tb.fLowerTName}Manager.get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
		${tb.fLowerTName}PageList.addAll(${tb.fLowerTName}List);
		return ${tb.fLowerTName}PageList;
		
	}
	
	@Override
	public int get${tb.fUpperTName}ByPageCount(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Manager.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
	}
	
	public void set${tb.fUpperTName}Manager(${tb.fUpperTName}Manager  ${tb.fLowerTName}Manager){
		this.${tb.fLowerTName}Manager = ${tb.fLowerTName}Manager;
	}
	
}