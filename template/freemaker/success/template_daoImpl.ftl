package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Component;

import ${cfb.packageName}.domain.${mytagprizepackage}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.dao.${mytagprizepackage}.${tb.fUpperTName}Dao;
<#if cfb.parentPackageName!="">
	<#if cfb.parentClassName!="">
import ${cfb.parentPackageName}.${cfb.parentClassName};
	</#if>
</#if>

@Component("${tb.fLowerTName}Dao")
public class ${tb.fUpperTName}${cfb.fileNameSuffix} extends ${cfb.parentClassName} implements ${tb.fUpperTName}Dao{


	/**
	 * 添加
	 * @param ${tb.fLowerTName}
	 * @return
	 */
	@Override
	public void insert${tb.fUpperTName}(${tb.fUpperTName} ${tb.fLowerTName}){
		this.getSqlSession().insert("${tb.fLowerTName}.insert${tb.fUpperTName}", ${tb.fLowerTName});
	}
	
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@Override
	public boolean delete${tb.fUpperTName}ById(Long id){
		return this.getSqlSession().delete("${tb.fLowerTName}.delete${tb.fUpperTName}ById", id)>0;
	}
	
	/**
	 * 根据条件删除
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@Override
	public boolean delete${tb.fUpperTName}ByCondition(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return this.getSqlSession().delete("${tb.fLowerTName}.delete${tb.fUpperTName}ById", ${tb.fLowerTName}Query)>0;
	}
	
	/**
	 * 修改
	 * @param id
	 * @return
	 */	
	@Override
	public boolean update${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return this.getSqlSession().update("${tb.fLowerTName}.update${tb.fUpperTName}ById", ${tb.fLowerTName})>0;
	}
	
	
	
	/**
	 * 根据条件修改
	 * @param data
	 * @return
	 */
	public boolean update${tb.fUpperTName}ByCondition(Map<String,Object> data){
		return this.getSqlSession().update("${tb.fLowerTName}.update${tb.fUpperTName}ByCondition", data)>0;
	}
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 */
	@Override
	public ${tb.fUpperTName} get${tb.fUpperTName}ById(Long id){
		return this.getSqlSession().selectOne("${tb.fLowerTName}.get${tb.fUpperTName}ById",id);
	}
	
	/**
	 * 查询所有
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@Override
	public List<${tb.fUpperTName}> get${tb.fUpperTName}All(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return this.getSqlSession().selectList("${tb.fLowerTName}.get${tb.fUpperTName}All",${tb.fLowerTName}Query);
	}
	
	/**
	 * 分页查询
	 * @param permitOperation
	 * @return
	 */
	public List<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return this.getSqlSession().selectList("${tb.fLowerTName}.get${tb.fUpperTName}ByPage",${tb.fLowerTName}Query);
	}
	
	/**
	 * 分页查询查询总数
	 * @param permitOperation
	 * @return
	 */
	public int get${tb.fUpperTName}ByPageCount(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return this.getSqlSession().selectOne("${tb.fLowerTName}.get${tb.fUpperTName}ByPageCount",${tb.fLowerTName}Query);
	}
}