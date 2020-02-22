package com.platform.generator.db;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.platform.generator.bean.GeneratorColumns;
import com.platform.generator.bean.GeneratorTable;
import com.platform.generator.bean.GeneratorTableKey;
import com.platform.generator.config.GeneratorConfig;
import com.platform.generator.interfaces.TypeConver;
import com.platform.generator.util.ConvertUtil;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.type.JdbcType;
import org.springframework.stereotype.Component;

import java.sql.*;
import java.util.*;

@Component("generatorDao")
public class GeneratorDaoImpl implements GeneratorDao {

    public TypeConver typeConver;

    public List<GeneratorTable> getGeneratorData(String tableName, GeneratorConfig generatorConfig, TypeConver typeConver) {

        this.typeConver = typeConver;
        ComboPooledDataSource dataSource = generatorConfig.getDataSource();

        Connection connection = null;
        try {
            if (dataSource.getDriverClass().equals("oracle.jdbc.driver.OracleDriver")) {
                Properties props = new Properties();
                props.put("remarksReporting", "true");
                props.put("password", dataSource.getPassword());
                props.put("user", dataSource.getUser());
                connection = DriverManager.getConnection(dataSource.getJdbcUrl(), props);
            } else {
                connection = dataSource.getConnection();
            }

        } catch (SQLException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        //generatorConfig.setChildTable(false);
        if(generatorConfig.isChildTable()){
            Map<String,String> tableMap = JSONObject.fromObject(tableName);
            String masterTable = tableMap.get("master");
            List<GeneratorTable> masterTableList = getGeneratorTable(connection,masterTable,generatorConfig,typeConver);
            if(masterTableList!=null&&masterTableList.size()>0){
                GeneratorTable generatorTable = masterTableList.get(0);

                String[] childTableName = tableMap.get("child").split(",");

                List<GeneratorTable> childTableList = new ArrayList<>();
                for(String table :childTableName) {
                    List<GeneratorTable> childTables = getGeneratorTable(connection, table, generatorConfig, typeConver);
                    if (childTables != null && childTables.size() > 0){
                        for (GeneratorTable childTable:childTables){
                            childTable.setChild(true);
                        }
                        childTableList.add(childTables.get(0));
                    }
                }
                generatorTable.setChildTable(childTableList);
            }
            return masterTableList;
        }else{
            return getGeneratorTable(connection, tableName, generatorConfig, typeConver);
        }
    }

    public List<GeneratorTable> getGeneratorTable(Connection connection, String tableName, GeneratorConfig generatorConfig, TypeConver typeConver) {

        ResultSet rs = null;
        List<GeneratorTable> generatorTableList = new ArrayList<GeneratorTable>();
        try {
            DatabaseMetaData metaData = connection.getMetaData();
            if (StringUtils.isNotBlank(tableName)) {
                //数据库名，null,表名，null
                rs = metaData.getTables(generatorConfig.getDbName(), null, tableName, null);
                while (rs.next()) {
                    String tableType = rs.getString(GeneratorTable.TABLE_TYPE);
                    if (tableType != null && tableType.toUpperCase().equals("TABLE")) {
                        GeneratorTable generatorTable = new GeneratorTable();
                        generatorTable.setTableCat(rs.getString(GeneratorTable.TABLE_CAT));
                        generatorTable.setTableSchem(rs.getString(GeneratorTable.TABLE_SCHEM));
                        generatorTable.setTableType(rs.getString(GeneratorTable.TABLE_TYPE));
                        generatorTable.setRemarks(rs.getString(GeneratorTable.REMARKS));
                        generatorTable.setTableName(rs.getString(GeneratorTable.TABLE_NAME));
                        generatorTable.setfLowerTName(ConvertUtil.firstLowerCamelCase(generatorTable.getTableName()));
                        generatorTable.setfUpperTName(ConvertUtil.firstUpperCamelCase(generatorTable.getTableName()));
                        generatorTable.setAllLowerTName(ConvertUtil.allLower(generatorTable.getTableName()));
                        generatorTable.setAllUpperTName(ConvertUtil.allUpper(generatorTable.getTableName()));
                        getTableKey(generatorTable, metaData);
                        getColumns(generatorTable, metaData);
                        generatorTableList.add(generatorTable);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeRs(rs);
        }
        return generatorTableList;
    }

    private void getTableKey(GeneratorTable table, DatabaseMetaData databaseMetaData) {
        ResultSet rs = null;
        try {
            if (table.getTableSchem() == null || "".equals(table.getTableSchem())) {
                table.setTableSchem(table.getTableCat());
            }
            rs = databaseMetaData.getPrimaryKeys(null, table.getTableSchem().trim(), table.getTableName());
            while (rs.next()) {
                GeneratorTableKey tableKey = new GeneratorTableKey();
                tableKey.setKeyStr(rs.getString(4));
                tableKey.setfLowerkey(ConvertUtil.firstLowerCamelCase(tableKey.getKeyStr()));
                tableKey.setfUpperkey(ConvertUtil.firstUpperCamelCase(tableKey.getKeyStr()));
                tableKey.setfAUpperkey(ConvertUtil.allUpper(tableKey.getKeyStr()));
                tableKey.setfALowerkey(ConvertUtil.allLower(tableKey.getKeyStr()));

                table.getTableKey().add(tableKey);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeRs(rs);
        }
    }

    private void getColumns(GeneratorTable table, DatabaseMetaData databaseMetaData) {


        ResultSet rs = null;
        try {

            if (table.getTableSchem() == null || "".equals(table.getTableSchem())) {
                table.setTableSchem(table.getTableCat());
            }

            //	rs = databaseMetaData.getColumns(null, null, table.getTableName(),null);
            rs = databaseMetaData.getColumns(table.getTableCat(), table.getTableSchem(), table.getTableName(), null);
            Map<String, String> packageMap = new Hashtable<String, String>();

            while (rs.next()) {
                GeneratorColumns columns = new GeneratorColumns();
                columns.setTableCat(rs.getString(GeneratorColumns.TABLE_CAT));
                columns.setTableSchem(rs.getString(GeneratorColumns.TABLE_SCHEM));
                columns.setTableName(rs.getString(GeneratorColumns.TABLE_NAME));
                columns.setColumnName(rs.getString(GeneratorColumns.COLUMN_NAME));
                columns.setDataType(rs.getInt(GeneratorColumns.DATA_TYPE));
                columns.setJdbcType(JdbcType.forCode(columns.getDataType()).name());
                columns.setTypeName(rs.getString(GeneratorColumns.TYPE_NAME));
                columns.setColumnSize(rs.getString(GeneratorColumns.COLUMN_SIZE));
                columns.setBufferLength(rs.getString(GeneratorColumns.BUFFER_LENGTH));
                columns.setDecimalDigits(rs.getString(GeneratorColumns.DECIMAL_DIGITS));
                columns.setNumPrecRadix(rs.getString(GeneratorColumns.NUM_PREC_RADIX));
                columns.setNullable(rs.getString(GeneratorColumns.NULLABLE));
                String remarks = rs.getString(GeneratorColumns.REMARKS);
                if (StringUtils.isNotBlank(remarks)) {
                    columns.setRemarks(remarks);
                } else {
                    columns.setRemarks("");
                }
                columns.setColumnDef(rs.getString(GeneratorColumns.COLUMN_DEF));
                columns.setSqlDataType(rs.getString(GeneratorColumns.SQL_DATA_TYPE));
                columns.setSqlDatetimeSub(rs.getString(GeneratorColumns.SQL_DATETIME_SUB));
                columns.setCharOctetLength(rs.getString(GeneratorColumns.CHAR_OCTET_LENGTH));
                columns.setOrdinalPosition(rs.getString(GeneratorColumns.ORDINAL_POSITION));
                columns.setIsNullable(rs.getString(GeneratorColumns.IS_NULLABLE));
                columns.setfLowerColName(ConvertUtil.firstLowerCamelCase(columns.getColumnName()));
                columns.setfUpperColName(ConvertUtil.firstUpperCamelCase(columns.getColumnName()));
                Map<String, String> typeMap = typeConver.dbTypeToJava(columns.getTypeName(), columns.getColumnSize());
                if (typeMap != null) {
                    columns.setJavaType(typeMap.get("type"));
                    columns.setJavaPackage(typeMap.get("package"));
                }
                table.getColumns().add(columns);

                if (StringUtils.isNotBlank(typeMap.get("package"))) {
                    if (!packageMap.containsKey(typeMap.get("type"))) {
                        packageMap.put(typeMap.get("type"), typeMap.get("package"));
                    }
                }
            }
            table.setPackageMap(packageMap);
            System.out.println(packageMap.size());

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeRs(rs);
        }
    }

    public void closeRs(ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
