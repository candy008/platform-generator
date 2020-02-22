package com.platform.generator.bean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 
 * @author quanjj 
 *
 */
public class GeneratorTable {
	

	public List<GeneratorTableKey> getTableKey() {
		return tableKey;
	}

	public void setTableKey(List<GeneratorTableKey> tableKey) {
		this.tableKey = tableKey;
	}

	public static final String TABLE_CAT = "TABLE_CAT";
	public static final String TABLE_SCHEM = "TABLE_SCHEM";
	public static final String TABLE_NAME = "TABLE_NAME";
	public static final String TABLE_TYPE = "TABLE_TYPE";
	public static final String REMARKS = "REMARKS";
	public static final String DEF_TABLE_NAMEPATTERN = "%";

	/**
	 * 字表
	 */
	public List<GeneratorTable> childTable;
	
	private List<GeneratorTableKey> tableKey;

	public List<GeneratorTable> getChildTable() {
		return childTable;
	}

	public void setChildTable(List<GeneratorTable> childTable) {
		this.childTable = childTable;
	}

	private String tableCat;
	
	private String tableSchem;
	
	private String tableName;
	
	private String tableType;
	
	private String remarks;
	
	private List<GeneratorColumns> columns;
	
	private String fLowerTName;
	
	private String fUpperTName;
	
	private String allLowerTName="";
	
	private String allUpperTName="";
	
	private String lTableName;
	
	private Map<String, String> packageMap;

	public boolean isChild() {
		return child;
	}

	public void setChild(boolean child) {
		this.child = child;
	}

	//是否为子
	private boolean child;


	public GeneratorTable(){
		columns = new ArrayList<GeneratorColumns>();
		tableKey = new ArrayList<GeneratorTableKey>();
	}
	
	public String getTableCat() {
		return tableCat;
	}
	public void setTableCat(String tableCat) {
		this.tableCat = tableCat;
	}
	public String getTableSchem() {
		return tableSchem;
	}
	public void setTableSchem(String tableSchem) {
		this.tableSchem = tableSchem;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getTableType() {
		return tableType;
	}
	public void setTableType(String tableType) {
		this.tableType = tableType;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public List<GeneratorColumns> getColumns() {
		return columns;
	}

	public void setColumns(List<GeneratorColumns> columns) {
		this.columns = columns;
	}

	public String getlTableName() {
		return lTableName;
	}

	public void setlTableName(String lTableName) {
		this.lTableName = lTableName;
	}

	public String getfLowerTName() {
		return fLowerTName;
	}

	public void setfLowerTName(String fLowerTName) {
		this.fLowerTName = fLowerTName;
	}

	public String getfUpperTName() {
		return fUpperTName;
	}

	public void setfUpperTName(String fUpperTName) {
		this.fUpperTName = fUpperTName;
	}

	public String getAllLowerTName() {
		return allLowerTName;
	}

	public void setAllLowerTName(String allLowerTName) {
		this.allLowerTName = allLowerTName;
	}

	public Map<String, String> getPackageMap() {
		return packageMap;
	}

	public void setPackageMap(Map<String, String> packageMap) {
		this.packageMap = packageMap;
	}

	public String getAllUpperTName() {
		return allUpperTName;
	}

	public void setAllUpperTName(String allUpperTName) {
		this.allUpperTName = allUpperTName;
	}
}
