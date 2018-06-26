package ${cfb.packageName}.${cfb.packageSuffix};

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.dao.${mytagprizepackage1}.${tb.fUpperTName}Dao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-config.xml")
public class ${tb.fUpperTName}${cfb.fileNameSuffix}{


	@Autowired
	private ${tb.fUpperTName}Dao ${tb.fLowerTName}Dao;
	
	
	@Before
	public void init() {

	}

	@Test
	public void insert${tb.fUpperTName}(){
		${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
		//testInsert
		${tb.fLowerTName}Dao.insert${tb.fUpperTName}(${tb.fLowerTName});	
	}
	
	@Test
	public void delete${tb.fUpperTName}ById(){
		${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
		//testDelete
		${tb.fLowerTName}Dao.delete${tb.fUpperTName}ById(${tb.fLowerTName});	
	}
	
	@Test
	public void update${tb.fUpperTName}ById(){
		${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
		//testUpdate
		${tb.fLowerTName}Dao.update${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Test
	public void get${tb.fUpperTName}ById(){
		${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
		//testGetById
		${tb.fLowerTName}Dao.get${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Test
	public void get${tb.fUpperTName}All(){
		//testGetAll
		${tb.fLowerTName}Dao.get${tb.fUpperTName}All();
	}
	
	@Test
	public void get${tb.fUpperTName}ByPage(){
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		//testGetPage
		${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
	}
	
	@Test
	public void get${tb.fUpperTName}ByPageCount(){
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		//testGetPageCount
		${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
	}
}