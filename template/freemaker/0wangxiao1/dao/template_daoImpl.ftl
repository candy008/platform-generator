package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;
import java.util.Map;

import ${cfb.packageName}.domain.${mytagprizepackage}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.dao.${mytagprizepackage}.${tb.fUpperTName}Dao;
<#if cfb.parentPackageName!="">
	<#if cfb.parentClassName!="">
import ${cfb.parentPackageName}.${cfb.parentClassName};
	</#if>
</#if>

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
	 * 批量添加
	 * @param List<${tb.fLowerTName}>
	 * @return
	 */
	public void insertBatch${tb.fUpperTName}(List<${tb.fUpperTName}> ${tb.fLowerTName}List){
		this.getSqlSession().insert("${tb.fLowerTName}.insertBatch${tb.fUpperTName}", ${tb.fLowerTName}List);
	}
	/**
	 * 删除 (真正删除数据库数据)
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@Override
	public boolean delete${tb.fUpperTName}ById(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return this.getSqlSession().delete("${tb.fLowerTName}.delete${tb.fUpperTName}ById", ${tb.fLowerTName}Query)>0;
	}
	
	/**
	 * 根据条件删除 (真正删除数据库数据)
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@Override
	public boolean delete${tb.fUpperTName}ByCondition(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return this.getSqlSession().delete("${tb.fLowerTName}.delete${tb.fUpperTName}ById", ${tb.fLowerTName}Query)>0;
	}
	
	/**
	 * 根据主键批量删除  (真正删除数据库数据)
	 * @param data
	 * @return
	 */
	@Override
	public boolean delete${tb.fUpperTName}ByBatchId(Map<String,Object> data){
		return this.getSqlSession().delete("${tb.fLowerTName}.delete${tb.fUpperTName}ByBatchId", data)>0;
	}
	
	/**
	 * 逻辑删除 (修改数据库数据为删除状态)
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@Override
	public boolean logicDelete${tb.fUpperTName}ById(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return this.getSqlSession().update("${tb.fLowerTName}.logicDelete${tb.fUpperTName}ById", ${tb.fLowerTName}Query)>0;
	}
	
	/**
	 * 根据条件逻辑删除 (修改数据库数据为删除状态)
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@Override
	public boolean logicDelete${tb.fUpperTName}ByCondition(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return this.getSqlSession().update("${tb.fLowerTName}.logicDelete${tb.fUpperTName}ById", ${tb.fLowerTName}Query)>0;
	}
	
	/**
	 * 根据主键批量逻辑删除 (修改数据库数据为删除状态)
	 * @param data
	 * @return
	 */
	@Override
	public boolean logicDelete${tb.fUpperTName}ByBatchId(Map<String,Object> data){
		return this.getSqlSession().update("${tb.fLowerTName}.logicDelete${tb.fUpperTName}ByBatchId", data)>0;
	}
	
	
	/**
	 * 修改
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */	
	@Override
	public boolean update${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return this.getSqlSession().update("${tb.fLowerTName}.update${tb.fUpperTName}ById", ${tb.fLowerTName})>0;
	}
	
	/**
	 * 根据主键批量逻辑删除 (修改数据库数据为删除状态)
	 * @param data
	 * @return
	 */
	@Override
	public boolean logicDelete${tb.fUpperTName}ByBatchId(Map<String,Object> data){
		return this.getSqlSession().update("${tb.fLowerTName}.logicDelete${tb.fUpperTName}ByBatchId", data)>0;
	}
	
	/**
	 * 根据条件修改
	 * @param data
	 * @return
	 */
	@Override
	public boolean update${tb.fUpperTName}ByCondition(Map<String,Object> data){
		return this.getSqlSession().update("${tb.fLowerTName}.update${tb.fUpperTName}ByCondition", data)>0;
	}
	/**
	 * 根据Id批量修改
	 * @param ${tb.fLowerTName}List
	 * @return
	 */
	public boolean update${tb.fUpperTName}ByBatchId(List<${tb.fUpperTName}> ${tb.fLowerTName}List){
		return this.getSqlSession().update("${tb.fLowerTName}.update${tb.fUpperTName}ByBatchId", ${tb.fLowerTName}List)>0;
	}
	/**
	 * 根据id查询
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@Override
	public ${tb.fUpperTName} get${tb.fUpperTName}ById(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return this.getSqlSession().selectOne("${tb.fLowerTName}.get${tb.fUpperTName}ById",${tb.fLowerTName}Query);
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
	@Override
	public List<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return this.getSqlSession().selectList("${tb.fLowerTName}.get${tb.fUpperTName}ByPage",${tb.fLowerTName}Query);
	}
	
	/**
	 * 分页查询查询总数
	 * @param permitOperation
	 * @return
	 */
	@Override
	public Integer get${tb.fUpperTName}ByPageCount(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return this.getSqlSession().selectOne("${tb.fLowerTName}.get${tb.fUpperTName}ByPageCount",${tb.fLowerTName}Query);
	}
}