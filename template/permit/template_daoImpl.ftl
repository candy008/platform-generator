package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;
import org.springframework.stereotype.Component;

import ${cfb.packageName}.domain.${mytagprizepackage}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.dao.${mytagprizepackage}.${tb.fUpperTName}Dao;
<#if cfb.parentPackageName!="">
	<#if cfb.parentClassName!="">
import ${cfb.parentPackageName}.${cfb.parentClassName};
	</#if>
</#if>


@SuppressWarnings("unchecked")
@Component("${tb.fLowerTName}Dao")
public class  ${tb.fUpperTName}${cfb.fileNameSuffix} extends ${cfb.parentClassName}<${tb.fUpperTName}> implements ${tb.fUpperTName}Dao{

	@Override
	public void insert${tb.fUpperTName}(${tb.fUpperTName} ${tb.fLowerTName}){
		this.insert("${tb.fUpperTName}.insert${tb.fUpperTName}", ${tb.fLowerTName});
	}
	
	@Override
	public boolean delete${tb.fUpperTName}ById(Long id){
		return this.delete("${tb.fUpperTName}.delete${tb.fUpperTName}ById", id)>0;
	}
	
	@Override
	public boolean update${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return this.update("${tb.fUpperTName}.update${tb.fUpperTName}ById", ${tb.fLowerTName})>0;
	}
	
	@Override
	public ${tb.fUpperTName} get${tb.fUpperTName}ById(Long id){
		return (${tb.fUpperTName})this.queryForObject("${tb.fUpperTName}.get${tb.fUpperTName}ById",id);
	}
	
	@Override
	public List<${tb.fUpperTName}> get${tb.fUpperTName}All(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return this.queryForList("${tb.fUpperTName}.get${tb.fUpperTName}All",${tb.fLowerTName}Query);
	}
	
	/**
	 * 分页查询
	 * @param permitOperation
	 * @return
	 */
	public List<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return this.queryForList("${tb.fUpperTName}.get${tb.fUpperTName}ByPage",${tb.fLowerTName}Query);
	}
	
	/**
	 * 分页查询查询总数
	 * @param permitOperation
	 * @return
	 */
	public int get${tb.fUpperTName}ByPageCount(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return (Integer)this.queryForObject("${tb.fUpperTName}.get${tb.fUpperTName}ByPageCount",${tb.fLowerTName}Query);
	}
}