package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;
import java.util.Map;
import java.util.Hashtable;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.platform.common.utils.page.PaginatedList;
import com.platform.common.utils.page.impl.MysqlPaginatedArrayList;
import com.platform.common.utils.StringUtil;
import com.platform.common.utils.primarykey.PrimaryKeyUtil;
import com.platform.common.web.result.GridResult;
import com.platform.common.web.result.Result;

import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.dao.${mytagprizepackage}.${tb.fUpperTName}Dao;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;
<#list tb.columns as item>
<#if (item.columnName)=="ts">
import ${cfb.packageName}.util.DateUtil;
</#if>
</#list>





@Component("${tb.fLowerTName}Service")
public class ${tb.fUpperTName}${cfb.fileNameSuffix} implements ${tb.fUpperTName}Service{


	private ${tb.fUpperTName}Dao ${tb.fLowerTName}Dao;

	@Autowired
	private PrimaryKeyUtil primaryKeyUtil;

	/**
	 * 添加
	 * @param ${tb.fLowerTName}
	 * @return
	 */
	@Override
	public void insert${tb.fUpperTName}(${tb.fUpperTName} ${tb.fLowerTName}){
		String pk = primaryKeyUtil.getPrimaryKey();
		<#list tb.columns as item>
	    <#if (item.columnName)=="dr">
		${tb.fLowerTName}.setDr(0);
	    </#if>
	    <#if (item.columnName)=="created">
		${tb.fLowerTName}.setCreated(DateUtil.getTs());
	    </#if>
	    <#if (item.columnName)=="ts">
		${tb.fLowerTName}.setTs(DateUtil.getTs());
	    </#if>
    	</#list>
		${tb.fLowerTName}.set${tb.tableKey[0].fUpperkey}(pk);
		${tb.fLowerTName}Dao.insert${tb.fUpperTName}(${tb.fLowerTName});	
	}
	
	/**
	 * 批量添加
	 * @param List<${tb.fLowerTName}>
	 * @return
	 */
	public void insertBatch${tb.fUpperTName}(List<${tb.fUpperTName}> ${tb.fLowerTName}List){
		if(${tb.fLowerTName}List != null && ${tb.fLowerTName}List.size()>0){
			for(int i=0;i<${tb.fLowerTName}List.size();i++){
				<#list tb.columns as item>
			    <#if (item.columnName)=="dr">
				${tb.fLowerTName}List.get(i).setDr(0);
			    </#if>
			    <#if (item.columnName)=="created">
				${tb.fLowerTName}List.get(i).setCreated(DateUtil.getTs());
			    </#if>
			    <#if (item.columnName)=="ts">
				${tb.fLowerTName}List.get(i).setTs(DateUtil.getTs());
			    </#if>
		    	</#list>
				String pk = primaryKeyUtil.getPrimaryKey();
				${tb.fLowerTName}List.get(i).set${tb.tableKey[0].fUpperkey}(pk);
			}
			${tb.fLowerTName}Dao.insertBatch${tb.fUpperTName}(${tb.fLowerTName}List);
		}
	}
	
	/**
	 * 根据Id删除 (真正删除数据库数据)
	 * @param id
	 * @return
	 */
	@Override
	public boolean delete${tb.fUpperTName}ById(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.delete${tb.fUpperTName}ById(${tb.fLowerTName}Query);	
	}
	
	/**
	 * 根据条件删除 (真正删除数据库数据)
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@Override
	public boolean delete${tb.fUpperTName}ByCondition(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.delete${tb.fUpperTName}ByCondition(${tb.fLowerTName}Query);	
	}
	
	/**
	 * 根据id批量删除 (真正删除数据库数据)
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */	
	@Override
	public Result delete${tb.fUpperTName}ByBatchId(${tb.fUpperTName}Query ${tb.fLowerTName}Query) {
		Result result = new Result(false);
		Map<String, Object> data = new Hashtable<String, Object>();
		if(StringUtils.isNotEmpty(${tb.fLowerTName}Query.getBatchId())){
			String [] batchIdArr = ${tb.fLowerTName}Query.getBatchId().split(",");
			if(batchIdArr != null && batchIdArr.length>0){
				data.put("batchId1",batchIdArr);
				boolean flat = ${tb.fLowerTName}Dao.delete${tb.fUpperTName}ByBatchId(data);	
				result.setSuccess(flat);
			}
		}
		return result;
	}
	<#list tb.columns as item>
    <#if (item.columnName)=="dr">
	/**
	 * 根据Id逻辑删除 (修改数据库数据为删除状态)
	 * @param id
	 * @return
	 */
	@Override
	public boolean logicDelete${tb.fUpperTName}ById(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.logicDelete${tb.fUpperTName}ById(${tb.fLowerTName}Query);	
	}
	
	/**
	 * 根据条件逻辑删除 (修改数据库数据为删除状态)
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@Override
	public boolean logicDelete${tb.fUpperTName}ByCondition(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.logicDelete${tb.fUpperTName}ByCondition(${tb.fLowerTName}Query);	
	}
	
	/**
	 * 根据id逻辑批量删除 (修改数据库数据为删除状态)
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */	
	@Override
	public Result logicDelete${tb.fUpperTName}ByBatchId(${tb.fUpperTName}Query ${tb.fLowerTName}Query) {
		Result result = new Result(false);
		if(StringUtils.isNotEmpty(${tb.fLowerTName}Query.getBatchId())){
			String [] batchIdArr = ${tb.fLowerTName}Query.getBatchId().split(",");
			if(batchIdArr != null && batchIdArr.length>0){
				Map<String, Object> data = new Hashtable<String, Object>();
				data.put("batchId1",batchIdArr);
				boolean flat = ${tb.fLowerTName}Dao.logicDelete${tb.fUpperTName}ByBatchId(data);	
				result.setSuccess(flat);
			}
		}
		return result;
	}
    </#if>
    </#list>
	
	
	/**
	 * 添加或修改
	 * @param ${tb.fLowerTName}
	 * @return
	 */	
	@Override
	public Result insertOrUpdate(${tb.fUpperTName} ${tb.fLowerTName}) {
		Result result = new Result(false);
		if(${tb.fLowerTName}!=null){
			if(StringUtil.isNotEmpty(${tb.fLowerTName}.get${tb.tableKey[0].fUpperkey}())){
				update${tb.fUpperTName}ById(${tb.fLowerTName});
			}else{
				insert${tb.fUpperTName}(${tb.fLowerTName});
			}
			result.setSuccess(true);
		} else {
			result.setErrorMessage("数据对象不能为空");
		}
		result.addDefaultModel(${tb.fLowerTName});
		return result;
	}
	
	/**
	 * 根据Id修改
	 * @param ${tb.fLowerTName}
	 * @return
	 */
	@Override
	public boolean update${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		<#list tb.columns as item>
		<#if (item.columnName)=="modified">
		${tb.fLowerTName}.setModified(DateUtil.getTs());
		</#if>
		<#if (item.columnName)=="ts">
		${tb.fLowerTName}.setTs(DateUtil.getTs());
		</#if>
    	</#list>
		return ${tb.fLowerTName}Dao.update${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	/**
	 * 根据条件修改
	 * @param data
	 * @return
	 */
	@Override
	public boolean update${tb.fUpperTName}ByCondition(${tb.fUpperTName}Query record,${tb.fUpperTName}Query parameter){
		Map<String, Object> data = new Hashtable<String, Object>();
		<#list tb.columns as item>
		<#if (item.columnName)=="modified">
		record.setModified(DateUtil.getTs());
		</#if>
		<#if (item.columnName)=="ts">
		record.setTs(DateUtil.getTs());
		</#if>
    	</#list>
		data.put("record",record);
		data.put("parameter",parameter);
		return ${tb.fLowerTName}Dao.update${tb.fUpperTName}ByCondition(data);
	}
	
	/**
	 * 根据Id批量修改
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public Result update${tb.fUpperTName}ByBatchId(List<${tb.fUpperTName}> ${tb.fLowerTName}List){
		Result result = new Result(false);
		if(${tb.fLowerTName}List != null && ${tb.fLowerTName}List.size()>0){
			<#list tb.columns as item>
		    <#if (item.columnName)=="modified">
		    for(int i=0;i<${tb.fLowerTName}List.size();i++){
				${tb.fLowerTName}List.get(i).setModified(DateUtil.getTs());
				${tb.fLowerTName}List.get(i).setTs(DateUtil.getTs());
			}
		    </#if>
		    </#list>
		   
			boolean flag = ${tb.fLowerTName}Dao.update${tb.fUpperTName}ByBatchId(${tb.fLowerTName}List);
			result.setSuccess(flag);
		}
		return result;
	}
	
	/**
	 * 根据id查询
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@Override
	public ${tb.fUpperTName} get${tb.fUpperTName}ById(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.get${tb.fUpperTName}ById(${tb.fLowerTName}Query);
	}
	
	/**
	 * 查询所有
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@Override
	public List<${tb.fUpperTName}> get${tb.fUpperTName}All(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.get${tb.fUpperTName}All(${tb.fLowerTName}Query);
	}
	
	/**
	 * 分页查询
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@Override
	public GridResult<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		//如果排序的字段是空或者空字符串
		if(${tb.fLowerTName}Query!=null&&StringUtils.isBlank(${tb.fLowerTName}Query.getSort())){
			${tb.fLowerTName}Query.setSort("${tb.tableKey[0].keyStr}");
			${tb.fLowerTName}Query.setOrder("desc");
		}
		int total = ${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
		PaginatedList<${tb.fUpperTName}> ${tb.fLowerTName}PageList = new MysqlPaginatedArrayList<${tb.fUpperTName}>(${tb.fLowerTName}Query,total);
		List<${tb.fUpperTName}> ${tb.fLowerTName}List = ${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
		${tb.fLowerTName}PageList.addAll(${tb.fLowerTName}List);
		GridResult<${tb.fUpperTName}> result = new GridResult<${tb.fUpperTName}>(${tb.fLowerTName}PageList);
		return result;
	}
	
	/**
	 * 分页查询查询总数
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@Override
	public int get${tb.fUpperTName}ByPageCount(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
	}

	public void set${tb.fUpperTName}Dao(${tb.fUpperTName}Dao  ${tb.fLowerTName}Dao){
		this.${tb.fLowerTName}Dao = ${tb.fLowerTName}Dao;
	}
	
}