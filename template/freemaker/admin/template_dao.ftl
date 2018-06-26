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
	 * 根据${tb.fLowerTName}Query删除
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public boolean delete${tb.fUpperTName}ById(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 根据条件删除
	 * @param ${tb.fLowerTName}Query
	 * @return
	 */
	public boolean delete${tb.fUpperTName}ByCondition(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 根据${tb.fLowerTName}Query修改
	 * @param ${tb.fLowerTName}Query
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
	 * 根据${tb.fLowerTName}Query查询
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