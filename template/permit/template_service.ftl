package ${cfb.packageName}.${cfb.packageSuffix};

import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import java.util.List;
import com.platform.base.result.Result;
import com.platform.base.utils.page.ExtPageResult;
import com.platform.base.utils.page.PageInfo;


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
	 * 添加或者修改
	 * @param ${tb.fUpperTName}
	 * @return
	 */
	public Result insertOrUpdata(${tb.fUpperTName} ${tb.fLowerTName});
	
	/**
	 * 删除
	 * @param ${tb.fLowerTName}
	 * @id
	 * @return
	 */
	public boolean delete${tb.fUpperTName}ById(Long id);
	
	/**
	 * 查询所有
	 * ${tb.fUpperTName}Query
	 * @return
	 */
	public List<${tb.fUpperTName}> get${tb.fUpperTName}All(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 */
	public ${tb.fUpperTName} get${tb.fUpperTName}ById(Long id);

	/**
	 * 分页查询
	 * @param ${tb.fUpperTName}Query
	 * @return
	 */
	public ExtPageResult<${tb.fUpperTName}> get${tb.fUpperTName}ByPage(PageInfo pageInfo,${tb.fUpperTName}Query ${tb.fLowerTName}Query);
	
	/**
	 * 分页查询查询总数
	 * @param ${tb.fUpperTName}Query
	 * @return
	 */
	public int get${tb.fUpperTName}ByPageCount(${tb.fUpperTName}Query ${tb.fLowerTName}Query);
}