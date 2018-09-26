package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.platform.common.seculity.annotation.AccessSeculity;
import com.platform.common.web.result.GridResult;
import com.platform.common.web.result.Result;
import ${cfb.packageName}.service.InterfaceFactoryService;

import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;
import ${cfb.packageName}.controller.pub.BjBaseController;

@RestController
public class ${tb.fUpperTName}Controller extends BjBaseController{

	private static final String SERVCIE_BEAN_NAME = "${tb.fLowerTName}Service";

	private ${tb.fUpperTName}Service ${tb.fLowerTName}Service;
	
	private InterfaceFactoryService interfaceFactoryService;
	

	/**
	 *  查询所有
	 * @param mktsetlistQuery
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	@RequestMapping(value = "${tb.fLowerTName}/get${tb.fUpperTName}All", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody List<${tb.fUpperTName}> get${tb.fUpperTName}All(${tb.fUpperTName}Query ${tb.fLowerTName}Query) {
		if (${tb.fLowerTName}Query == null) {
			${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		}
		List<${tb.fUpperTName}> ${tb.fLowerTName}List = get${tb.fUpperTName}Service(getTenantId()).get${tb.fUpperTName}All(${tb.fLowerTName}Query);
		return ${tb.fLowerTName}List;
	}

	/**
	 * 分页查询
	 * @param mktsetlistQuery
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	@RequestMapping(value = "${tb.fLowerTName}/get${tb.fUpperTName}ByPage", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody GridResult<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query) {
		if (${tb.fLowerTName}Query == null) {
			${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		}
		GridResult<${tb.fUpperTName}> gridResult = get${tb.fUpperTName}Service(getTenantId()).get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
		return gridResult;
	}

	/**
	 * 根据id查询
	 * @param mktsetlistQuery
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	@RequestMapping(value = "${tb.fLowerTName}/get${tb.fUpperTName}ById", method = { RequestMethod.POST,RequestMethod.GET })
	public @ResponseBody ${tb.fUpperTName} get${tb.fUpperTName}ById(${tb.fUpperTName}Query ${tb.fLowerTName}Query) {
		${tb.fUpperTName} ${tb.fLowerTName} = get${tb.fUpperTName}Service(getTenantId()).get${tb.fUpperTName}ById(${tb.fLowerTName}Query);
		return ${tb.fLowerTName};
	}

	/**
	 *  添加或修改
	 * @param mktsetlist
	 * @return
	 */
	@RequestMapping(value = "${tb.fLowerTName}/insertOrUpdate", method = { RequestMethod.POST,RequestMethod.GET })
	public @ResponseBody Result insertOrUpdate(${tb.fUpperTName} ${tb.fLowerTName}) {
		Result result = get${tb.fUpperTName}Service(getTenantId()).insertOrUpdate(${tb.fLowerTName});
		return result;
	}

	/**
	 *  根据Id批量删除 (真正删除数据库数据)
	 * @param batchId
	 * @return
	 */
	@RequestMapping(value = "${tb.fLowerTName}/delete${tb.fUpperTName}ByBatchId", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Result delete${tb.fUpperTName}ByBatchId(${tb.fUpperTName}Query ${tb.fLowerTName}Query) {
		Result result = get${tb.fUpperTName}Service(getTenantId()).delete${tb.fUpperTName}ByBatchId(${tb.fLowerTName}Query);
		return result;
	}
	
	<#list tb.columns as item>
    <#if (item.columnName)=="dr">
	/**
	 * 根据Id批量逻辑删除(修改数据库数据为删除状态)
	 * @param batchId
	 * @return
	 */
	@RequestMapping(value = "${tb.fLowerTName}/logicDelete${tb.fUpperTName}ByBatchId", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Result logicDelete${tb.fUpperTName}ByBatchId(${tb.fUpperTName}Query ${tb.fLowerTName}Query) {
		Result result = get${tb.fUpperTName}Service(getTenantId()).logicDelete${tb.fUpperTName}ByBatchId(${tb.fLowerTName}Query);
		return result;
	}
    </#if>
    </#list>
	
	public void set${tb.fUpperTName}Service(${tb.fUpperTName}Service ${tb.fLowerTName}Service) {
		this.${tb.fLowerTName}Service = ${tb.fLowerTName}Service;
	}
	
	public ${tb.fUpperTName}Service get${tb.fUpperTName}Service(String tenantId) {
		if(interfaceFactoryService != null ){
			${tb.fUpperTName}Service ${tb.fLowerTName}Service = interfaceFactoryService.getBean(tenantId, SERVCIE_BEAN_NAME);
			if(${tb.fLowerTName}Service != null){
				return ${tb.fLowerTName}Service;
			}
		}
		return ${tb.fLowerTName}Service;
	}
	
	public void setInterfaceFactoryService(InterfaceFactoryService interfaceFactoryService) {
		this.interfaceFactoryService = interfaceFactoryService;
	}

}