package com.platform.generator;

import java.util.List;

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
	
	public final static String TEMPPLATE_PATH = "D:/dev/sts-bundle/workspace/platform-generator/template/freemaker/spring_boot";
	
	private GeneratorDao generatorDao;
	
	public void generatorRun(){
//		URL templatePath = this.getClass().getClassLoader().getResource("freemaker/bawie/");
//		System.out.println(templatePath);
		TypeConver typeConver = new DefaultTypeConver();
		GeneratorFile generatorFile = new DefaultGeneratorFile();
		List<GeneratorTable> generatorTableList = null;
		for (GeneratorConfig generatorConfig:generatorConfigList) {
			String tableNameStr = generatorConfig.getTableNames();
			String[] tableNames = tableNameStr.split(",");
			for (int i = 0; i < tableNames.length; i++) {
				generatorTableList = generatorDao.getGeneratorData(tableNames[i],generatorConfig,typeConver);
				if(generatorTableList!=null&&generatorTableList.size()>0){
					for (GeneratorTable generatorTable: generatorTableList) {
						generatorFile.generatorDataToFile(generatorConfig, generatorTable);
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
//		Map<String, String> map = new HashMap<String, String>();
//		map.put("a", null);
//		map.put("a", "bbbbb");
//		map.put("a", "bbbbb");
//		System.out.println(map.size());
	}

}
