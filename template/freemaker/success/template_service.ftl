package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;

import com.platform.common.web.result.EasyUIGridResult;
import com.platform.common.web.result.Result;

import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;

public interface ${tb.fUpperTName}${cfb.fileNameSuffix}{

	/**
	 * 添加
	 * @param ${tb.fLowerTName}
	 * @return
	 */
	public void insert${tb.fUpperTName}(${tb.fUpperTName} ${tb.fLowerTName});
	
	/**
	 * 根据Id删除
	 * @param id
	 * @return
	 */
	public boolean delete${tb.fUpperTName}ById(Long id);
	
	/**
	 * 添加或修改
	 * @param ${tb.fLowerTName}
	 */
	public Result insertOrUpdate(${tb.fUpperTName} ${tb.fLowerTName});

	/**
	 * 批量删除
	 * @param l
	 * @return
	 */
	public Result delete${tb.fUpperTName}ByIdBatch(String batchId);
	
	/**
	 * 根据条件删除
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public boolean delete${tb.fUpperTName}ByCondition(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 根据Id修改
	 * @param id
	 * @return
	 */
	public boolean update${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName});
	
	/**
	 * 根据条件修改
	 * @param data
	 * @return
	 */
	public boolean update${tb.fUpperTName}ByCondition(${tb.fUpperTName}Query record,${tb.fUpperTName}Query parameter);
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 */
	public ${tb.fUpperTName} get${tb.fUpperTName}ById(Long id);
	
	/**
	 * 查询所有
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public List<${tb.fUpperTName}> get${tb.fUpperTName}All(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 分页查询
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public EasyUIGridResult<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 分页查询查询总数
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public int get${tb.fUpperTName}ByPageCount(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	
}