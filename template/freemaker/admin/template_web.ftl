package ${cfb.packageName}.${cfb.packageSuffix};

import org.springframework.context.annotation.Scope;

import com.platform.common.seculity.annotation.AccessSeculity;
import com.platform.common.struts.action.BaseAction;
import com.platform.common.struts.utils.Struts2Utils;
import com.platform.common.utils.json.JsonUtils;
import com.platform.common.web.result.EasyUIGridResult;
import com.platform.common.web.result.Result;

import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;

@Scope("prototype")
public class ${tb.fUpperTName}Action extends BaseAction<${tb.fUpperTName}>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ${tb.fUpperTName}Service ${tb.fLowerTName}Service;
	
	private ${tb.fUpperTName}Query ${tb.fLowerTName}Query;
	
	private ${tb.fUpperTName} ${tb.fLowerTName};
	
	/**
	 * 批量Id
	 */
	private String batchId;
	
	/**
	 * 跳转到${tb.fLowerTName}首页
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	public String to${tb.fUpperTName}Page(){
		Result result = new Result();
		toVm(result);
		return "to${tb.fUpperTName}Page";
	}
	
	/**
	 * 分页查询
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	public void get${tb.fUpperTName}ByPage(){
		if(${tb.fLowerTName}Query==null){
			${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		}
		setPageInfo(${tb.fLowerTName}Query);
		EasyUIGridResult<${tb.fUpperTName}> easyUIGridResult = ${tb.fLowerTName}Service.get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
		String ${tb.fLowerTName}PageListStr = JsonUtils.toJson(easyUIGridResult);
		Struts2Utils.renderText(${tb.fLowerTName}PageListStr);
	}
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	public void get${tb.fUpperTName}ById(){
		${tb.fUpperTName} ${tb.fLowerTName} = ${tb.fLowerTName}Service.get${tb.fUpperTName}ById(${tb.fLowerTName}Query.getId());
		Struts2Utils.renderText(JsonUtils.toJson(${tb.fLowerTName}));
	}
	
	/**
	 * 添加或修改
	 * @param ${tb.fLowerTName}
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	public void insertOrUpdate(){
		Result result = ${tb.fLowerTName}Service.insertOrUpdate(${tb.fLowerTName});
		String json = JsonUtils.toJson(result);
		Struts2Utils.renderText(json);
	}
	
	/**
	 * 根据Id批量删除
	 * @param id
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	public void delete${tb.fUpperTName}ByIdBatch(){
		Result result = ${tb.fLowerTName}Service.delete${tb.fUpperTName}ByIdBatch(batchId);
		String json = JsonUtils.toJson(result);
		Struts2Utils.renderText(json);
	}

	public void set${tb.fUpperTName}Service(${tb.fUpperTName}Service  ${tb.fLowerTName}Service){
		this.${tb.fLowerTName}Service = ${tb.fLowerTName}Service;
	}
	
	public void set${tb.fUpperTName}Query(${tb.fUpperTName}Query  ${tb.fLowerTName}Query){
		this.${tb.fLowerTName}Query = ${tb.fLowerTName}Query;
	}
	
	public ${tb.fUpperTName}Query get${tb.fUpperTName}Query(){
		return this.${tb.fLowerTName}Query;
	}
	
	public void set${tb.fUpperTName}(${tb.fUpperTName}  ${tb.fLowerTName}){
		this.${tb.fLowerTName} = ${tb.fLowerTName};
	}
	
	public ${tb.fUpperTName} get${tb.fUpperTName}(){
		return this.${tb.fLowerTName};
	}

	public String getBatchId() {
		return batchId;
	}

	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}
	
	/**
	 * 实现该方法可以不使用 ${tb.fLowerTName}.id 方式注入值
	 */
	@Override
	public ${tb.fUpperTName} getModel() {
		if(${tb.fLowerTName}==null){
			${tb.fLowerTName} = new ${tb.fUpperTName}();
		}
		return ${tb.fLowerTName};
	}
}