package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;
import java.util.Map;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import javax.annotation.Resource;
import org.springframework.web.bind.annotation.*;
import com.platform.common.web.result.v1.Result;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}QueryExtend;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;
import com.imfbp.bs.commons.controller.BsBaseController;
import com.imfbp.bs.commons.enums.IOptionMsgConst;

/**
 * ${tb.fUpperTName}Controller
 * 
 * @author administrator
 */
@RestController
@Api(value="${tb.fUpperTName}替换Controller",tags={"${tb.fUpperTName}操作接口"})
public class ${tb.fUpperTName}Controller extends BsBaseController {

    private Logger logger = LoggerFactory.getLogger(${tb.fUpperTName}Controller.class);

	@Resource(name = "${tb.fLowerTName}Service")
	private ${tb.fUpperTName}Service ${tb.fLowerTName}Service;
	
	/**
	 * 查询所有
	 * @param ${tb.fLowerTName}QueryExtend 查询实体
	 * @return Result 返回结果
	 */
	@ApiOperation(value="查询所有${tb.fUpperTName}替换",notes="无")
	@RequestMapping(value = "${tb.fLowerTName}/get${tb.fUpperTName}All", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Result get${tb.fUpperTName}All(@RequestBody ${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend) {
        Result result = new Result();
        try {
            List<${tb.fUpperTName}> list = ${tb.fLowerTName}Service.getAll(${tb.fLowerTName}QueryExtend);
            result.addDefaultModel(list);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setErrorMessage(IOptionMsgConst.QUERY_DATA_ERR);
            logger.error(IOptionMsgConst.QUERY_DATA_ERR, e);
        }
        return result;
	}

	/**
	 * 分页查询
	 * @param pageRequest 分页
     * @param paramMap 查询map
	 * @return Result 返回结果
	 */
	@ApiOperation(value="分页查询${tb.fUpperTName}替换",notes="无")
	@RequestMapping(value = "${tb.fLowerTName}/get${tb.fUpperTName}ByPage", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Result get${tb.fUpperTName}ByPage(PageRequest pageRequest, @RequestBody Map<String,Object> paramMap) {
        Result result = checkPageData(pageRequest, paramMap);
        if (!result.isSuccess()) {
            return result;
        }
        try {
            Page<${tb.fUpperTName}> list = ${tb.fLowerTName}Service.getByPage(pageRequest, paramMap);
            result.addDefaultModel(list);
        } catch (Exception e) {
            result.setErrorMessage(IOptionMsgConst.QUERY_DATA_ERR);
            logger.error(IOptionMsgConst.QUERY_DATA_ERR, e);
        }
        return result;
	}

	/**
	 * 根据id查询
	 * @param ${tb.fLowerTName}QueryExtend 查询实体
	 * @return Result 返回结果
	 */
	@ApiOperation(value="根据id查询${tb.fUpperTName}替换",notes="无")
	@RequestMapping(value = "${tb.fLowerTName}/get${tb.fUpperTName}ById", method = { RequestMethod.POST,RequestMethod.GET })
	public @ResponseBody Result get${tb.fUpperTName}ById(@RequestBody ${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend) {
        Result result = new Result();
        if (StringUtils.isBlank(${tb.fLowerTName}QueryExtend.getId())) {
            result.setErrorMessage(IOptionMsgConst.QUERY_DATA_ERR_ID);
            return result;
        }
        try {
            ${tb.fUpperTName} ${tb.fLowerTName} = ${tb.fLowerTName}Service.getById(${tb.fLowerTName}QueryExtend);
            result.addDefaultModel(${tb.fLowerTName});
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setErrorMessage(IOptionMsgConst.QUERY_DATA_ERR);
            logger.error(IOptionMsgConst.QUERY_DATA_ERR, e);
        }
        return result;
	}

	/**
	 *  添加或修改
	 * @param ${tb.fLowerTName} 数据实体
	 * @return Result 返回结果
	 */
	@ApiOperation(value="添加或修改${tb.fUpperTName}替换",notes="无")
	@RequestMapping(value = "${tb.fLowerTName}/insertOrUpdate", method = { RequestMethod.POST,RequestMethod.GET })
	public @ResponseBody Result insertOrUpdate(@RequestBody ${tb.fUpperTName} ${tb.fLowerTName}) {
		return ${tb.fLowerTName}Service.insertOrUpdate(${tb.fLowerTName});
	}

	/**
	 *  根据Id批量删除 (真正删除数据库数据)
	 * @param ${tb.fLowerTName}QueryExtend 查询实体
	 * @return Result 返回结果
	 */
	@ApiOperation(value="根据Id批量删除 (真正删除数据库数据)${tb.fUpperTName}替换",notes="无")
	@RequestMapping(value = "${tb.fLowerTName}/delete${tb.fUpperTName}ByBatchId", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Result delete${tb.fUpperTName}ByBatchId(@RequestBody ${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend) {
		return ${tb.fLowerTName}Service.deleteByBatchId(${tb.fLowerTName}QueryExtend);
	}
	
	/**
	 * 根据Id批量逻辑删除(修改数据库数据为删除状态)
	 * @param  ${tb.fLowerTName}QueryExtend 查询实体
	 * @return Result 返回结果
	 */
	@ApiOperation(value="根据Id批量逻辑删除(修改数据库数据为删除状态)${tb.fUpperTName}替换",notes="无")
	@RequestMapping(value = "${tb.fLowerTName}/logicDelete${tb.fUpperTName}ByBatchId", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Result logicDelete${tb.fUpperTName}ByBatchId(@RequestBody ${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend) {
		return ${tb.fLowerTName}Service.logicDeleteByBatchId(${tb.fLowerTName}QueryExtend);
	}
}