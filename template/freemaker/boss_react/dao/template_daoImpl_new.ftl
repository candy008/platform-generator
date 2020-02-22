package ${cfb.packageName}.${cfb.packageSuffix};

import ${cfb.packageName}.domain.${mytagprizepackage}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}QueryExtend;
import ${cfb.packageName}.dao.${mytagprizepackage}.${tb.fUpperTName}Dao;
import ${cfb.packageName}.commons.enums.IMapperConst;
import ${cfb.packageName}.dao.commons.impl.BaseMyBatisDaoImpl;
import org.springframework.stereotype.Component;

/**
 * ${tb.remarks}Dao实现类
 * 
 * @author administrator
 */
@Component("${tb.fLowerTName}Dao")
public class ${tb.fUpperTName}${cfb.fileNameSuffix} extends BaseMyBatisDaoImpl<${tb.fUpperTName}, ${tb.fUpperTName}QueryExtend> implements ${tb.fUpperTName}Dao {

    @Override
    public String getMapperPrefixPath() {
        return IMapperConst.MAPPER_PREFIX + ${tb.fUpperTName}.class.getSimpleName() + "Mapper.";
    }

}