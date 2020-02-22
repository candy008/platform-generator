package com.platform.generator;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

import com.platform.generator.bean.GeneratorTable;
import com.platform.generator.config.GeneratorConfig;
import com.platform.generator.db.GeneratorDao;
import com.platform.generator.interfaces.GeneratorFile;
import com.platform.generator.interfaces.TypeConver;
import com.platform.generator.interfaces.impl.DefaultGeneratorFile;
import com.platform.generator.interfaces.impl.DefaultTypeConver;

@Component("generatorCenter")
public class GeneratorCenter {
	
	private List<GeneratorConfig> generatorConfigList;
	
//	public final static String TEMPPLATE_PATH = "D:/springsource/workspace_work/platforms-generator/template/permit";
//	public final static String TEMPPLATE_PATH = "/export/programFile/eclipse_devs/workspase/platforms-generator-20151015/template/freemaker/admin_oracle";
//	public final static String TEMPPLATE_PATH = "D:/sts-bundle/workspace_New/platform-generator/template/freemaker/spring_crm";
//	public final static String TEMPPLATE_PATH = "D:/yonyou/iuap/platform-generator-new/template/freemaker/spring_crm";
//	public final static String TEMPPLATE_PATH = "D:/WorkSpace/dfsworkspacegit/gen_code/platform-generator-new/template/freemaker/spring_of";
//	public final static String TEMPPLATE_PATH = "D:/WorkSpace/dfsworkspacegit/gen_code/platform-generator-new/template/freemaker/spring_bj";
	public final static String TEMPPLATE_PATH = "D:/workspace/codegenerator/platform-generator-new/template/freemaker/spring_bj";
//	public final static String TEMPPLATE_PATH = "/Users/xingganghong/mywork/worktools/IDE/workspace/codegenerator/platform-generator-new/template/freemaker/spring_bj";

//	public final static String TEMPPLATE_PATH = 
//	"C:/Users/fulq/git/codegenerator/platform-generator-new/template/freemaker/0wangxiao";
	
	//	public final static String TEMPPLATE_PATH = "D:/sts-bundle/resources/platforms-generator/template/freemaker/admin_oracle";
	
//	public final static String TEMPPLATE_PATH = "D:/springsource2/workspace/plat/wplatform-generator/template/permit";
//	public final static String TEMPPLATE_PATH = "D:/springsource2/workspace/club_vip/wplatform-generator/template/permit";
//	public final static String TEMPPLATE_PATH = "E:/sts/workspace/platform/wplatform-generator/template/permit";
	private GeneratorDao generatorDao;


	public void generatorRun(){
//		URL templatePath = this.getClass().getClassLoader().getResource("freemaker/bawie/");
//		System.out.println(templatePath);
		TypeConver typeConver = new DefaultTypeConver();
		GeneratorFile generatorFile = new DefaultGeneratorFile();
		List<GeneratorTable> generatorTableList = null;
		for (GeneratorConfig generatorConfig:generatorConfigList) {

			String tableNameStr = generatorConfig.getTableNames();

			String[] tableNames = null;
			if(generatorConfig.isChildTable()){
				tableNames = tableNameStr.split("\\|");
			}else{
				tableNames = tableNameStr.split(",");
			}

			for (int i = 0; i < tableNames.length; i++) {
				generatorTableList = generatorDao.getGeneratorData(tableNames[i],generatorConfig,typeConver);
				if(generatorTableList!=null&&generatorTableList.size()>0){
					for (GeneratorTable generatorTable: generatorTableList) {
						generatorFile.generatorDataToFile(generatorConfig, generatorTable);
						if(generatorTable.getChildTable()!=null&&generatorTable.getChildTable().size()>0){
							for (GeneratorTable childTable: generatorTable.getChildTable()) {
								generatorFile.generatorDataToFile(generatorConfig, childTable);
							}
						}
					}
				}
			}
		}
	}

	public List<GeneratorConfig> getGeneratorConfigList() {
		return generatorConfigList;
	}
	
	public void setGeneratorConfigList(List<GeneratorConfig> generatorConfigList) {
		this.generatorConfigList = generatorConfigList;
	}

	public GeneratorDao getGeneratorDao() {
		return generatorDao;
	}

	public void setGeneratorDao(GeneratorDao generatorDao) {
		this.generatorDao = generatorDao;
	}
	
	public static void main(String[] args) {

		ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("spring-config.xml");
		GeneratorCenter center = (GeneratorCenter)context.getBean("generatorCenter");
		center.generatorRun();

	}

}
