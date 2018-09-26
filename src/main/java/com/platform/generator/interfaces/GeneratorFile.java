package com.platform.generator.interfaces;

import com.platform.generator.bean.GeneratorTable;
import com.platform.generator.config.GeneratorConfig;

public interface GeneratorFile {
	
	public void generatorDataToFile(GeneratorConfig generatorConfig,GeneratorTable generatorTable);

}
