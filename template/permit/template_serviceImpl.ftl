package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;
import java.util.Date;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.platform.base.result.Result;
import com.platform.base.utils.page.ExtPageResult;
import com.platform.base.utils.page.PageInfo;

import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;
import ${cfb.packageName}.dao.${mytagprizepackage}.${tb.fUpperTName}Dao;

@Component("${tb.fLowerTName}Service")
public class ${tb.fUpperTName}${cfb.fileNameSuffix} implements ${tb.fUpperTName}Service{

	private final Logger logger = Logger.getLogger(${tb.fUpperTName}${cfb.fileNameSuffix}.class);

	private ${tb.fUpperTName}Dao ${tb.fLowerTName}Dao;

	@Override
	public void insert${tb.fUpperTName}(${tb.fUpperTName} ${tb.fLowerTName}){
		${tb.fLowerTName}Dao.insert${tb.fUpperTName}(${tb.fLowerTName});	
	}
	
	@Override
	public boolean update${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return ${tb.fLowerTName}Dao.update${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Override
	public Result insertOrUpdata(${tb.fUpperTName} ${tb.fLowerTName}){
		
		Result result = new Result();
		result.setSuccess(false);
		
		if(${tb.fLowerTName}!=null){
			try {
				if(${tb.fLowerTName}.getId()!=null){
					${tb.fLowerTName}.setModified(new Date());
					${tb.fLowerTName}Dao.update${tb.fUpperTName}ById(${tb.fLowerTName});
				}else{
					${tb.fLowerTName}.setCreated(new Date());
					${tb.fLowerTName}.setModified(new Date());
					${tb.fLowerTName}Dao.insert${tb.fUpperTName}(${tb.fLowerTName});
				}
				result.setSuccess(true);;
				result.addDefaultModel("${tb.fLowerTName}", ${tb.fLowerTName});
			} catch (Exception e) {
				result.addDefaultModel("exception", e);
				logger.error("${tb.fUpperTName}${cfb.fileNameSuffix}.insertOrUpdata() is error",e);
			}
		}
		return result;
	}
	
	@Override
	public boolean delete${tb.fUpperTName}ById(Long id){
		return ${tb.fLowerTName}Dao.delete${tb.fUpperTName}ById(id);	
	}
	
	@Override
	public ${tb.fUpperTName} get${tb.fUpperTName}ById(Long id){
		return ${tb.fLowerTName}Dao.get${tb.fUpperTName}ById(id);
	}
	
	@Override
	public List<${tb.fUpperTName}> get${tb.fUpperTName}All(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.get${tb.fUpperTName}All(${tb.fLowerTName}Query);
	}
	
	@Override
	public ExtPageResult<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(PageInfo pageInfo,${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		int count = ${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
		ExtPageResult<${tb.fUpperTName}> ${tb.fLowerTName}PageData = new ExtPageResult<${tb.fUpperTName}>(pageInfo,${tb.fLowerTName}Query);
		List<${tb.fUpperTName}> ${tb.fLowerTName}List = ${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
		${tb.fLowerTName}PageData.setRows(${tb.fLowerTName}List);
		${tb.fLowerTName}PageData.setTotal(count);
		return ${tb.fLowerTName}PageData;
	}
	
	@Override
	public int get${tb.fUpperTName}ByPageCount(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
	}
	
	public void set${tb.fUpperTName}Dao(${tb.fUpperTName}Dao  ${tb.fLowerTName}Dao){
		this.${tb.fLowerTName}Dao = ${tb.fLowerTName}Dao;
	}
	
}