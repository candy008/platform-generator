package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;
import java.util.Map;
import com.platform.common.web.result.v1.Result;
import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}QueryExtend;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * ${tb.remarks}Service
 * 
 * @author administrator
 */
public interface ${tb.fUpperTName}${cfb.fileNameSuffix} {

    /**
	 * 添加
	 * 
	 * @param ${tb.fLowerTName} ${tb.remarks}实体
	 */
	void insert(${tb.fUpperTName} ${tb.fLowerTName});
	
	/**
	 * 批量添加
	 *
	 * @param ${tb.fLowerTName}List ${tb.remarks}集合实体
	 */
	void insertBatch(List<${tb.fUpperTName}> ${tb.fLowerTName}List);
	
	/**
	 * 根据主键删除
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return boolean 返回结果
	 */
	boolean deleteById(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend);
	
	/**
	 * 根据条件删除 (真正删除数据库数据)
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return boolean 返回结果
	 */
	boolean deleteByCondition(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend);
	
	/**
	 * 根据主键批量删除 (真正删除数据库数据)
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return Result 返回结果
	 */
	Result deleteByBatchId(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend);
	
	/**
	 * 根据Id逻辑删除 (修改数据库数据为删除状态)
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return boolean 返回结果
	 */
	boolean logicDeleteById(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend);
	
	/**
	 * 根据条件逻辑删除 (修改数据库数据为删除状态)
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return boolean 返回结果
	 */
	boolean logicDeleteByCondition(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend);
	
	/**
	 * 根据主键批量逻辑删除 (修改数据库数据为删除状态)
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return Result 返回结果
	 */
	Result logicDeleteByBatchId(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend);
	
	/**
	 * 添加或修改
	 *
	 * @param ${tb.fLowerTName} ${tb.remarks}实体
	 * @return Result 返回结果
	 */
	Result insertOrUpdate(${tb.fUpperTName} ${tb.fLowerTName});
	
	/**
	 * 根据Id修改
	 *
	 * @param ${tb.fLowerTName} ${tb.remarks}实体
	 * @return boolean 返回结果
	 */
	boolean updateById(${tb.fUpperTName} ${tb.fLowerTName});
	
	
	/**
	 * 根据条件修改
	 *
     * @param record 修改实体
     * @param parameter 修改条件
	 *
	 * @return boolean 返回结果
	 */
	boolean updateByCondition(${tb.fUpperTName} record,${tb.fUpperTName}QueryExtend parameter);
	
	/**
	 * 根据Id批量修改
	 *
	 * @param ${tb.fLowerTName}List ${tb.remarks}实体
	 * @return Result 返回结果
	 */
	Result updateByBatchId(List<${tb.fUpperTName}> ${tb.fLowerTName}List);
	
	
	/**
	 * 根据id查询
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return ${tb.fUpperTName} 返回结果
	 */
	${tb.fUpperTName} getById(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend);
	
	/**
	 * 查询所有
	 *
	 * @param ${tb.fLowerTName}QueryExtend ${tb.remarks}查询实体
	 * @return List<${tb.fUpperTName}> 返回结果
	 */
	List<${tb.fUpperTName}> getAll(${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend);
	
	/**
	 * 分页查询
	 *
	 * @param pageRequest 分页参数
     * @param pageParamMap 查询条件
	 * @return Page<${tb.fUpperTName}> 返回结果
	 */
    Page<${tb.fUpperTName}> getByPage(PageRequest pageRequest, Map<String, Object> pageParamMap);

	/**
	 * 分页查询查询总数
	 *
     * @param pageParamMap 查询条件
	 * @return int 返回分页总数
	 */
	int getByPageCount(Map<String, Object> pageParamMap);
	
	
}