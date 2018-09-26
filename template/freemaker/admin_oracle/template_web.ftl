package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.platform.common.seculity.annotation.AccessSeculity;
import com.platform.common.web.result.EasyUIGridResult;
import com.platform.common.web.result.Result;
import com.platform.common.spring.mvc.controller.BaseController;

import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;


@Controller
@RequestMapping("/${tb.fLowerTName}")
public class ${tb.fUpperTName}Controller extends BaseController{

	private ${tb.fUpperTName}Service ${tb.fLowerTName}Service;
	
	/**
	 *  跳转到${tb.fUpperTName}首页
	 * @param ${tb.fLowerTName}Query
	 * @param req
	 * @param resp
	 * @param context
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	@RequestMapping(value = "to${tb.fUpperTName}Page", method = { RequestMethod.POST,RequestMethod.GET })
	public String to${tb.fUpperTName}Page(${tb.fUpperTName}Query ${tb.fLowerTName}Query,HttpServletRequest req, HttpServletResponse resp, ModelMap context) {
		Result result = new Result();
		toVm(result, context, req);
		return "${tb.fLowerTName}/${tb.fLowerTName}";
	}

	/**
	 *  查询所有
	 * @param mktsetlistQuery
	 * @param req
	 * @param resp
	 * @param context
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	@RequestMapping(value = "get${tb.fUpperTName}All", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Object get${tb.fUpperTName}All(${tb.fUpperTName}Query ${tb.fLowerTName}Query, HttpServletRequest req,HttpServletResponse resp, ModelMap context) {
		if (${tb.fLowerTName}Query == null) {
			${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		}
		List<${tb.fUpperTName}> ${tb.fLowerTName}List = ${tb.fLowerTName}Service.get${tb.fUpperTName}All(${tb.fLowerTName}Query);
		return ${tb.fLowerTName}List;
	}

	/**
	 * 分页查询
	 * @param mktsetlistQuery
	 * @param req
	 * @param resp
	 * @param context
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	@RequestMapping(value = "get${tb.fUpperTName}ByPage", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Object get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query, HttpServletRequest req,HttpServletResponse resp, ModelMap context) {
		if (${tb.fLowerTName}Query == null) {
			${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		}
		EasyUIGridResult<${tb.fUpperTName}> easyUIGridResult = ${tb.fLowerTName}Service.get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
		return easyUIGridResult;
	}

	/**
	 * 根据id查询
	 * @param mktsetlistQuery
	 * @param req
	 * @param resp
	 * @param context
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	@RequestMapping(value = "get${tb.fUpperTName}ById", method = { RequestMethod.POST,RequestMethod.GET })
	public @ResponseBody Object get${tb.fUpperTName}ById(${tb.fUpperTName}Query ${tb.fLowerTName}Query, HttpServletRequest req,HttpServletResponse resp, ModelMap context) {
		${tb.fUpperTName} ${tb.fLowerTName} = ${tb.fLowerTName}Service.get${tb.fUpperTName}ById(${tb.fLowerTName}Query);
		return ${tb.fLowerTName};
	}

	/**
	 *  添加或修改
	 * @param mktsetlist
	 * @param req
	 * @param resp
	 * @param context
	 * @return
	 */
	@RequestMapping(value = "insertOrUpdate", method = { RequestMethod.POST,RequestMethod.GET })
	public @ResponseBody Object insertOrUpdate(${tb.fUpperTName} ${tb.fLowerTName},HttpServletRequest req, HttpServletResponse resp, ModelMap context) {
		Result result = ${tb.fLowerTName}Service.insertOrUpdate(${tb.fLowerTName});
		return result;
	}

	/**
	 *  根据Id批量删除
	 * @param batchId
	 * @param req
	 * @param resp
	 * @param context
	 * @return
	 */
	@RequestMapping(value = "delete${tb.fUpperTName}ByIdBatch", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Object delete${tb.fUpperTName}ByIdBatch(${tb.fUpperTName}Query ${tb.fLowerTName}Query,HttpServletRequest req, HttpServletResponse resp, ModelMap context) {
		Result result = ${tb.fLowerTName}Service.delete${tb.fUpperTName}ByIdBatch(${tb.fLowerTName}Query);
		return result;
	}

	public void set${tb.fUpperTName}Service(${tb.fUpperTName}Service ${tb.fLowerTName}Service) {
		this.${tb.fLowerTName}Service = ${tb.fLowerTName}Service;
	}

}