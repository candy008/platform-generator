package com.platform.generator.db;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.type.JdbcType;
import org.springframework.stereotype.Component;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.platform.generator.bean.GeneratorColumns;
import com.platform.generator.bean.GeneratorTable;
import com.platform.generator.bean.GeneratorTableKey;
import com.platform.generator.config.GeneratorConfig;
import com.platform.generator.interfaces.TypeConver;
import com.platform.generator.util.ConvertUtil;

public interface  GeneratorDao {


	public List<GeneratorTable> getGeneratorData(String tableName, GeneratorConfig generatorConfig, TypeConver typeConver);


}
