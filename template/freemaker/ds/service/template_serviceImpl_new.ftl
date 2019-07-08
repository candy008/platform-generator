package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.Map;
import java.util.List;
import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import com.platform.common.web.result.v1.Result;
import com.platform.common.utils.primarykey.PrimaryKeyUtil;

import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}QueryExtend;
import ${cfb.packageName}.mapper.${mytagprizepackage}.${tb.fUpperTName}Mapper;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;
import ${cfb.packageName}.commons.enums.IConst;
import com.platform.common.utils.date.DateUtil;
import com.platform.common.utils.tool.InstanceUtils;
import com.platform.common.utils.tool.ToolUtils;


/**
 * ${tb.remarks}Service实现类
 * 
 * @author administrator
 */
@Component("${tb.fLowerTName}Service")
public class ${tb.fUpperTName}${cfb.fileNameSuffix} implements ${tb.fUpperTName}Service {

	@Resource
	private ${tb.fUpperTName}Mapper ${tb.fLowerTName}Mapper;

    @Resource
	private PrimaryKeyUtil primaryKeyUtil;
	
	/**
	 * 添加
     *
	 * @param ${tb.fLowerTName} ${tb.remarks}实体
	 */
	@Override
	public void insert(${tb.fUpperTName} ${tb.fLowerTName}) {
		List<${tb.fUpperTName}> list = InstanceUtils.newArrayList();
		list.add(${tb.fLowerTName});
		insertBatch(list);
	}
	
	/**
	 * 批量添加
     *
	 * @param ${tb.fLowerTName}List ${tb.remarks}集合实体
	 */
	@Override
	public void insertBatch(List<${tb.fUpperTName}> ${tb.fLowerTName}List) {
		if (!CollectionUtils.isEmpty(${tb.fLowerTName}List)) {
			for (${tb.fUpperTName} ${tb.fLowerTName} : ${tb.fLowerTName}List) {
			<#list tb.columns as item>
				<#if (item.columnName)=="dr">
				${tb.fLowerTName}.setDr(IConst.DR_STATE_N);
			    </#if>
			    <#if (item.columnName)=="create_time">
				${tb.fLowerTName}.setCreateTime(DateUtil.getTs());
			    </#if>
			    <#if (item.columnName)=="ts">
				${tb.fLowerTName}.setTs(DateUtil.getTs());
			    </#if>
		    </#list>
		    	String pk = primaryKeyUtil.getPrimaryKey();
				${tb.fLowerTName}.set${tb.tableKey[0].fUpperkey}(pk);
			}
			${tb.fLowerTName}Mapper.insertBatch(${tb.fLowerTName}List);
		}
	}
	
	/***
	 * 根据主键删除
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return boolean 返回结果
	 */
	@Override
	public boolean deleteById(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend) {
		return ${tb.fLowerTName}Mapper.deleteById(${tb.fLowerTName}QueryExtend);
	}
	
	/**
	 * 根据条件删除 (真正删除数据库数据)
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return boolean 返回结果
	 */
	@Override
	public boolean deleteByCondition(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend) {
		return ${tb.fLowerTName}Mapper.deleteByCondition(${tb.fLowerTName}QueryExtend);
	}
	
	/**
	 * 根据主键批量删除 (真正删除数据库数据)
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return Result 返回结果
	 */	
	@Override
	public Result deleteByBatchId(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend) {
		Result result = new Result();
        parseBatchIdToList(${tb.fLowerTName}QueryExtend);
        if (!CollectionUtils.isEmpty(${tb.fLowerTName}QueryExtend.getIdList())) {
            boolean flag = ${tb.fLowerTName}Mapper.deleteByBatchId(${tb.fLowerTName}QueryExtend);
            result.setSuccess(flag);
        }
        return result;
	}
	
	/**
	 * 根据Id逻辑删除 (修改数据库数据为删除状态)
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return boolean 返回结果
	 */
	@Override
	public boolean logicDeleteById(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend) {
		return ${tb.fLowerTName}Mapper.logicDeleteById(${tb.fLowerTName}QueryExtend);
	}
	
	/**
	 * 根据条件逻辑删除 (修改数据库数据为删除状态)
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return boolean 返回结果
	 */
	@Override
	public boolean logicDeleteByCondition(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend) {
		return ${tb.fLowerTName}Mapper.logicDeleteByCondition(${tb.fLowerTName}QueryExtend);
	}
	
	/**
	 * 根据主键批量逻辑删除 (修改数据库数据为删除状态)
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return Result 返回结果
	 */	
	@Override
	public Result logicDeleteByBatchId(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend) {
		Result result = new Result();
        parseBatchIdToList(${tb.fLowerTName}QueryExtend);
        if (!CollectionUtils.isEmpty(${tb.fLowerTName}QueryExtend.getIdList())) {
            boolean flag = ${tb.fLowerTName}Mapper.logicDeleteByBatchId(${tb.fLowerTName}QueryExtend);
            result.setSuccess(flag);
        }
        return result;
	}
	
	/**
	 * 添加或修改
	 *
	 * @param ${tb.fLowerTName} ${tb.remarks}实体
	 * @return Result 返回结果
	 */	
	@Override
	public Result insertOrUpdate(${tb.fUpperTName} ${tb.fLowerTName}) {
		Result result = new Result();
		if (${tb.fLowerTName} != null){
			if (StringUtils.isNotEmpty(${tb.fLowerTName}.get${tb.tableKey[0].fUpperkey}())){
                updateById(${tb.fLowerTName});
			} else {
                insert(${tb.fLowerTName});
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
	 *
	 * @param ${tb.fLowerTName} ${tb.remarks}实体
	 * @return boolean 返回结果
	 */
	@Override
	public boolean updateById(${tb.fUpperTName} ${tb.fLowerTName}) {
	    <#list tb.columns as item>
		<#if (item.columnName)=="last_modified">
		${tb.fLowerTName}.setLastModified(DateUtil.getTs());
		</#if>
		<#if (item.columnName)=="ts">
		${tb.fLowerTName}.setTs(DateUtil.getTs());
		</#if>
    	</#list>
		return ${tb.fLowerTName}Mapper.updateById(${tb.fLowerTName});
	}
	
	/**
	 * 根据条件修改
	 *
	 * @param record 修改实体
	 * @param parameter 修改条件
	 *
	 * @return boolean 返回结果
	 */
	@Override
	public boolean updateByCondition(${tb.fUpperTName} record,${tb.fUpperTName}QueryExtend parameter) {
		Map<String, Object> data = InstanceUtils.newHashMap();
		data.put("record",record);
		data.put("parameter",parameter);
		return ${tb.fLowerTName}Mapper.updateByCondition(data);
	}
	
	/**
	 * 根据Id批量修改
	 *
	 * @param ${tb.fLowerTName}List ${tb.remarks}实体
	 * @return Result 返回结果
	 */
	@Override
	public Result updateByBatchId(List<${tb.fUpperTName}> ${tb.fLowerTName}List) {
		Result result = new Result();
		if (!CollectionUtils.isEmpty(${tb.fLowerTName}List)) {
			for (${tb.fUpperTName} ${tb.fLowerTName} : ${tb.fLowerTName}List) {
				<#list tb.columns as item>
		    	<#if (item.columnName)=="ts">
				${tb.fLowerTName}.setTs(DateUtil.getTs());
				</#if>	
				<#if (item.columnName)=="last_modified">
				${tb.fLowerTName}.setLastModified(DateUtil.getTs());
		    	</#if>
		    </#list>
			}
			boolean flag = ${tb.fLowerTName}Mapper.updateByBatchId(${tb.fLowerTName}List);
			result.setSuccess(flag);
		}
		return result;
	}
	
	/**
	 * 根据id查询
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return ${tb.fUpperTName} 返回结果
	 */
	@Override
	public ${tb.fUpperTName} getById(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend) {
		return ${tb.fLowerTName}Mapper.getById(${tb.fLowerTName}QueryExtend);
	}
	
	/**
	 * 查询所有
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return List<${tb.fUpperTName}> 返回结果
	 */
	@Override
	public List<${tb.fUpperTName}> getAll(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend) {
		return ${tb.fLowerTName}Mapper.getAll(${tb.fLowerTName}QueryExtend);
	}

    /**
     * 分页查询
     *
     * @param pageRequest 分页参数
     * @param pageParamMap 查询条件
     * @return Page<${tb.fUpperTName}> 返回结果
     */
    @Override
    public Page<${tb.fUpperTName}> getByPage(PageRequest pageRequest, Map<String, Object> pageParamMap) {
        Map<String, Object> param = InstanceUtils.newHashMap();
        param.put("pageRequest", pageRequest);
        param.put("pageParamMap", pageParamMap);
        int total = ${tb.fLowerTName}Mapper.getByPageCount(pageParamMap);
        List<${tb.fUpperTName}> ${tb.fLowerTName}List = ${tb.fLowerTName}Mapper.getByPage(param);
        return new PageImpl<${tb.fUpperTName}>(${tb.fLowerTName}List, pageRequest, total);
	}

    /**
     * 分页查询查询总数
     *
     * @param pageParamMap 查询条件
     * @return int 返回分页总数
     */
    @Override
    public int getByPageCount(Map<String, Object> pageParamMap) {
        return ${tb.fLowerTName}Mapper.getByPageCount(pageParamMap);
	}

    /**
     * 将batchId,转换idList
     *
     * @param ${tb.fLowerTName}QueryExtend 查询实体
     */
    private void parseBatchIdToList(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend){
        List<String> idList = ToolUtils.parseBatchIdToList(${tb.fLowerTName}QueryExtend.getBatchId());
        if (!CollectionUtils.isEmpty(idList)) {
            ${tb.fLowerTName}QueryExtend.setIdList(idList);
        }
     }
	
}