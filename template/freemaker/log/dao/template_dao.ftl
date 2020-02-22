package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.Map;

import ${cfb.packageName}.domain.${mytagprizepackage}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage}.query.${tb.fUpperTName}Query;
import java.util.List;

public interface ${tb.fUpperTName}${cfb.fileNameSuffix}{

	/**
	 * 添加
	 * @param ${tb.fLowerTName}
	 * @return
	 */
	public void insert${tb.fUpperTName}(${tb.fUpperTName} ${tb.fLowerTName});
	
	/**
	 * 批量添加
	 * @param ${tb.fLowerTName}List
	 * @return
	 */
	public void insertBatch${tb.fUpperTName}(List<${tb.fUpperTName}> ${tb.fLowerTName}List);
	
	
	/**
	 * 根据Id删除 (真正删除数据库数据)
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public boolean delete${tb.fUpperTName}ById(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 根据条件删除 (真正删除数据库数据)
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public boolean delete${tb.fUpperTName}ByCondition(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 根据主键批量删除 (真正删除数据库数据)
	 * @param data
	 * @return
	 */
	public boolean delete${tb.fUpperTName}ByBatchId(Map<String,Object> data);
	
	/**
	 * 根据Id逻辑删除 (修改数据库数据为删除状态)
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public boolean logicDelete${tb.fUpperTName}ById(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 根据条件逻辑删除 (修改数据库数据为删除状态)
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public boolean logicDelete${tb.fUpperTName}ByCondition(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 根据主键批量逻辑删除 (修改数据库数据为删除状态)
	 * @param data
	 * @return
	 */
	public boolean logicDelete${tb.fUpperTName}ByBatchId(Map<String,Object> data);
	
	
	/**
	 * 根据Id修改
	 * @param ${tb.fLowerTName}
	 * @return
	 */
	public boolean update${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName});
	
	/**
	 * 根据条件修改
	 * @param data
	 * @return
	 */
	public boolean update${tb.fUpperTName}ByCondition(Map<String,Object> data);
	
		/**
	 * 根据Id批量修改
	 * @param ${tb.fLowerTName}List
	 * @return
	 */
	public boolean update${tb.fUpperTName}ByBatchId(List<${tb.fUpperTName}> ${tb.fLowerTName}List);
	
	/**
	 * 根据id查询
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public ${tb.fUpperTName} get${tb.fUpperTName}ById(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
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
	public List<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 分页查询查询总数
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public Integer get${tb.fUpperTName}ByPageCount(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
}