package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;
import java.util.Map;
import java.util.Hashtable;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.platform.common.utils.page.PaginatedList;
import com.platform.common.utils.page.impl.MysqlPaginatedArrayList;
import com.platform.common.web.result.Result;
import com.platform.common.web.result.EasyUIGridResult;

import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.dao.${mytagprizepackage}.${tb.fUpperTName}Dao;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;


@Component("${tb.fLowerTName}Service")
public class ${tb.fUpperTName}${cfb.fileNameSuffix} implements ${tb.fUpperTName}Service{


	private ${tb.fUpperTName}Dao ${tb.fLowerTName}Dao;


	/**
	 * 添加
	 * @param ${tb.fLowerTName}
	 * @return
	 */
	public void insert${tb.fUpperTName}(${tb.fUpperTName} ${tb.fLowerTName}){
		${tb.fLowerTName}Dao.insert${tb.fUpperTName}(${tb.fLowerTName});
	}
	
	/**
	 * 根据Id删除
	 * @param id
	 * @return
	 */
	public boolean delete${tb.fUpperTName}ById(Long id){
		return ${tb.fLowerTName}Dao.delete${tb.fUpperTName}ById(id);
	}
	
	/**
	 * 根据条件删除
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public boolean delete${tb.fUpperTName}ByCondition(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.delete${tb.fUpperTName}ByCondition(${tb.fLowerTName}Query);
	}
	
	
	/**
	 * 添加或修改
	 * @param ${tb.fLowerTName}
	 * @return
	 */	
	@Override
	public Result insertOrUpdate(${tb.fUpperTName} ${tb.fLowerTName}) {
		Result result = new Result();
		//设置调用失败
		result.setSuccess(false);
		try {
			if(${tb.fLowerTName}!=null&&${tb.fLowerTName}.getId()!=null){
				update${tb.fUpperTName}ById(${tb.fLowerTName});
			}else{
				insert${tb.fUpperTName}(${tb.fLowerTName});
			}
			//如果没有异常设置成功
			result.setSuccess(true);
			//设置service返回的对象，可以是多个。 result.addDefaultModel("key", obj)
			result.addDefaultModel(${tb.fLowerTName});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 根据id批量删除
	 */
	@Override
	public Result delete${tb.fUpperTName}ByIdBatch(String batchId) {
		Result result = new Result();
		result.setSuccess(false);
		try {
			String [] batchIdArr = batchId.split(",");
			for (int i = 0; i < batchIdArr.length; i++) {
				${tb.fLowerTName}Dao.delete${tb.fUpperTName}ById(Long.parseLong(batchIdArr[i]));
			}
			result.setSuccess(true);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 根据Id修改
	 * @param id
	 * @return
	 */
	public boolean update${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName}){
		return ${tb.fLowerTName}Dao.update${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	/**
	 * 根据条件修改
	 * @param data
	 * @return
	 */
	public boolean update${tb.fUpperTName}ByCondition(${tb.fUpperTName}Query record,${tb.fUpperTName}Query parameter){
		Map<String, Object> data = new Hashtable<String, Object>();
		data.put("record",record);
		data.put("parameter",parameter);
		return ${tb.fLowerTName}Dao.update${tb.fUpperTName}ByCondition(data);
	}
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 */
	public ${tb.fUpperTName} get${tb.fUpperTName}ById(Long id){
		return ${tb.fLowerTName}Dao.get${tb.fUpperTName}ById(id);
	}
	
	/**
	 * 查询所有
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public List<${tb.fUpperTName}> get${tb.fUpperTName}All(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.get${tb.fUpperTName}All(${tb.fLowerTName}Query);
	}
	
	/**
	 * 分页查询
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public EasyUIGridResult<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		//如果排序的字段是空或者空字符串
		if(${tb.fLowerTName}Query!=null&&StringUtils.isBlank(${tb.fLowerTName}Query.getSortname())){
			${tb.fLowerTName}Query.setSortname("id");
			${tb.fLowerTName}Query.setSortorder("desc");
		}
		int total = ${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
		PaginatedList<${tb.fUpperTName}> ${tb.fLowerTName}PageList = new OraclePaginatedArrayList<${tb.fUpperTName}>(${tb.fLowerTName}Query,total);
		List<${tb.fUpperTName}> ${tb.fLowerTName}List = ${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
		${tb.fLowerTName}PageList.addAll(${tb.fLowerTName}List);
		EasyUIGridResult<${tb.fUpperTName}> result = new EasyUIGridResult<${tb.fUpperTName}>(${tb.fLowerTName}PageList);
		return result;
	}
	
	/**
	 * 分页查询查询总数
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public int get${tb.fUpperTName}ByPageCount(${tb.fUpperTName}Query ${tb.fLowerTName}Query){
		return ${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
	}

	public void set${tb.fUpperTName}Dao(${tb.fUpperTName}Dao  ${tb.fLowerTName}Dao){
		this.${tb.fLowerTName}Dao = ${tb.fLowerTName}Dao;
	}
	
}