package ${cfb.packageName}.${cfb.packageSuffix};

import java.io.IOException;

import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.platform.base.page.ExtPageResult;
import com.platform.base.action.BaseAction;
import com.platform.base.util.JSONUtils;
import com.platform.base.result.Result;

import ${cfb.packageName}.model.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.model.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;

@Component
@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
public class ${tb.fUpperTName}Action extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private ${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
	private ${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
	
	private ${tb.fUpperTName}Service ${tb.fLowerTName}Service;
	
	/**
	 * 分页查询
	 */
	public void get${tb.fUpperTName}PageList(){
		if(${tb.fLowerTName}Query==null){
			${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		}
		ExtPageResult<${tb.fUpperTName}> ${tb.fLowerTName}PageData = ${tb.fLowerTName}Service.get${tb.fUpperTName}ByPage(pageInfo, ${tb.fLowerTName}Query);
		String pageDataStr = JSONUtils.toJson(${tb.fLowerTName}PageData);
		try {
			response.getWriter().write(pageDataStr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 添加或者修改
	 */
	public void insertOrUpdata(){
		if(${tb.fLowerTName}!=null){
			${tb.fLowerTName}.setCreateUser(getUserId());
			Result result = ${tb.fLowerTName}Service.insertOrUpdata(${tb.fLowerTName});
			renderJson(JSONUtils.toJson(result));
		}
	}
	
	/**
	 * 根据id删除
	 */
	public void ${tb.fLowerTName}Delete(){
		boolean bool = ${tb.fLowerTName}Service.delete${tb.fUpperTName}ById(${tb.fLowerTName}.getId());
		if(bool){
			renderJson("true");
		}else{
			renderTest("false");
		}
	}
	
	public ${tb.fUpperTName} get${tb.fUpperTName}() {
		return ${tb.fLowerTName};
	}
	public void set${tb.fUpperTName}(${tb.fUpperTName} ${tb.fLowerTName}) {
		this.${tb.fLowerTName} = ${tb.fLowerTName};
	}
	
	public ${tb.fUpperTName}Query get${tb.fUpperTName}Query() {
		return ${tb.fLowerTName}Query;
	}
	public void set${tb.fUpperTName}(${tb.fUpperTName}Query ${tb.fLowerTName}Query) {
		this.${tb.fLowerTName}Query = ${tb.fLowerTName}Query;
	}
	
	public void set${tb.fUpperTName}Service(${tb.fUpperTName}Service  ${tb.fLowerTName}Service){
		this.${tb.fLowerTName}Service = ${tb.fLowerTName}Service;
	}
}
