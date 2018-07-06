package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.imfbp.boot.common.annotation.AccessSeculity;
import com.imfbp.boot.common.spring.mvc.controller.BaseController;
import com.imfbp.boot.common.web.result.GridResult;
import com.imfbp.boot.common.web.result.Result;

import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;


@RestController
public class ${tb.fUpperTName}Controller extends BaseController{

	private ${tb.fUpperTName}Service ${tb.fLowerTName}Service;
	
	/**
	 *  查询所有
	 * @param ${tb.fLowerTName}Query
	 * @param req
	 * @param resp
	 * @param context
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	@RequestMapping(value = "${tb.fLowerTName}/get${tb.fUpperTName}All", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Object get${tb.fUpperTName}All(${tb.fUpperTName}Query ${tb.fLowerTName}Query, HttpServletRequest req,HttpServletResponse resp, ModelMap context) {
		if (${tb.fLowerTName}Query == null) {
			${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		}
		List<${tb.fUpperTName}> ${tb.fLowerTName}List = ${tb.fLowerTName}Service.get${tb.fUpperTName}All(${tb.fLowerTName}Query);
		return ${tb.fLowerTName}List;
	}

	/**
	 * 分页查询
	 * @param ${tb.fLowerTName}Query
	 * @param req
	 * @param resp
	 * @param context
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	@RequestMapping(value = "${tb.fLowerTName}/get${tb.fUpperTName}ByPage", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Object get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query, HttpServletRequest req,HttpServletResponse resp, ModelMap context) {
		if (${tb.fLowerTName}Query == null) {
			${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		}
		GridResult<${tb.fUpperTName}> gridResult = ${tb.fLowerTName}Service.get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
		return gridResult;
	}

	/**
	 * 根据id查询
	 * @param ${tb.fLowerTName}Query
	 * @param req
	 * @param resp
	 * @param context
	 * @return
	 */
	@AccessSeculity(code="PERMITVALUE_PERMITVALUE")
	@RequestMapping(value = "${tb.fLowerTName}/get${tb.fUpperTName}ById", method = { RequestMethod.POST,RequestMethod.GET })
	public @ResponseBody Object get${tb.fUpperTName}ById(${tb.fUpperTName}Query ${tb.fLowerTName}Query, HttpServletRequest req,HttpServletResponse resp, ModelMap context) {
		${tb.fUpperTName} ${tb.fLowerTName} = ${tb.fLowerTName}Service.get${tb.fUpperTName}ById(${tb.fLowerTName}Query);
		return ${tb.fLowerTName};
	}

	/**
	 *  添加或修改
	 * @param ${tb.fLowerTName}
	 * @param req
	 * @param resp
	 * @param context
	 * @return
	 */
	@RequestMapping(value = "${tb.fLowerTName}/insertOrUpdate", method = { RequestMethod.POST,RequestMethod.GET })
	public @ResponseBody Object insertOrUpdate(${tb.fUpperTName} ${tb.fLowerTName},HttpServletRequest req, HttpServletResponse resp, ModelMap context) {
		Result result = ${tb.fLowerTName}Service.insertOrUpdate(${tb.fLowerTName});
		return result;
	}

	/**
	 *  根据Id批量删除 (真正删除数据库数据)
	 * @param ${tb.fLowerTName}Query
	 * @param req
	 * @param resp
	 * @param context
	 * @return
	 */
	@RequestMapping(value = "${tb.fLowerTName}/delete${tb.fUpperTName}ByBatchId", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Object delete${tb.fUpperTName}ByBatchId(${tb.fUpperTName}Query ${tb.fLowerTName}Query,HttpServletRequest req, HttpServletResponse resp, ModelMap context) {
		Result result = ${tb.fLowerTName}Service.delete${tb.fUpperTName}ByBatchId(${tb.fLowerTName}Query);
		return result;
	}
	
	/**
	 * 根据Id批量逻辑删除(修改数据库数据为删除状态)
	 * @param ${tb.fLowerTName}Query
	 * @param req
	 * @param resp
	 * @param context
	 * @return
	 */
	@RequestMapping(value = "${tb.fLowerTName}/logicDelete${tb.fUpperTName}ByBatchId", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Object logicDelete${tb.fUpperTName}ByBatchId(${tb.fUpperTName}Query ${tb.fLowerTName}Query,HttpServletRequest req, HttpServletResponse resp, ModelMap context) {
		Result result = ${tb.fLowerTName}Service.logicDelete${tb.fUpperTName}ByBatchId(${tb.fLowerTName}Query);
		return result;
	}

	public void set${tb.fUpperTName}Service(${tb.fUpperTName}Service ${tb.fLowerTName}Service) {
		this.${tb.fLowerTName}Service = ${tb.fLowerTName}Service;
	}

}