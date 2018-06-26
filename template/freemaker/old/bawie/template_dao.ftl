package ${cfb.packageName}.${cfb.packageSuffix};

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
	 * 修改
	 * @param ${tb.fLowerTName}
	 * @return
	 */
	public boolean update${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName});
	
	/**
	 * 删除
	 * @param ${tb.fLowerTName}
	 * @return
	 */
	public boolean delete${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName});
	
	/**
	 * 查询所有
	 * @return
	 */
	public List<${tb.fUpperTName}> get${tb.fUpperTName}All(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 根据id查询
	 * @param ${tb.fLowerTName}
	 * @return
	 */
	public ${tb.fUpperTName} get${tb.fUpperTName}ById(${tb.fUpperTName} ${tb.fLowerTName});
	

	/**
	 * 分页查询
	 * @param permitOperation
	 * @return
	 */
	public List<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 分页查询查询总数
	 * @param permitOperation
	 * @return
	 */
	public int get${tb.fUpperTName}ByPageCount(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
}