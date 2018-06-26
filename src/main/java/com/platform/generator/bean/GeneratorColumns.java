package com.platform.generator.bean;

/**
 * @author quanjj
 *
 */
public class GeneratorColumns {
	
	public static final String TABLE_CAT = "TABLE_CAT";
	public static final String TABLE_SCHEM = "TABLE_SCHEM";
	public static final String TABLE_NAME = "TABLE_NAME";
	public static final String COLUMN_NAME = "COLUMN_NAME";
	public static final String DATA_TYPE = "DATA_TYPE";
	public static final String TYPE_NAME = "TYPE_NAME";
	public static final String COLUMN_SIZE = "COLUMN_SIZE";
	public static final String BUFFER_LENGTH = "BUFFER_LENGTH";
	public static final String DECIMAL_DIGITS = "DECIMAL_DIGITS";
	public static final String NUM_PREC_RADIX = "NUM_PREC_RADIX";
	public static final String NULLABLE = "NULLABLE";
	public static final String REMARKS = "REMARKS";
	public static final String COLUMN_DEF = "COLUMN_DEF";
	public static final String SQL_DATA_TYPE = "SQL_DATA_TYPE";
	public static final String SQL_DATETIME_SUB = "SQL_DATETIME_SUB";
	public static final String CHAR_OCTET_LENGTH = "CHAR_OCTET_LENGTH";
	public static final String ORDINAL_POSITION = "ORDINAL_POSITION";
	public static final String IS_NULLABLE = "IS_NULLABLE";
	
	
	private String tableCat;
	
	private String tableSchem;
	
	private String tableName;
	
	private String columnName;
	
	private int dataType;
	
	private String typeName;
	
	private String columnSize;
	
	private String bufferLength;

	private String decimalDigits;

	private String numPrecRadix;

	private String nullable;

	private String remarks;

	private String columnDef;

	private String sqlDataType;

	private String sqlDatetimeSub;

	private String charOctetLength;

	private String ordinalPosition;

	private String isNullable;
	
	private String fLowerColName;
	
	private String fUpperColName;
	
	private String javaType;
	
	private String jdbcType;
	
	private String javaPackage;
	
	public String getTableCat() {
		return tableCat;
	}
	public String getTableSchem() {
		return tableSchem;
	}
	public String getTableName() {
		return tableName;
	}
	public String getColumnName() {
		return columnName;
	}
	public String getTypeName() {
		return typeName;
	}
	public String getColumnSize() {
		return columnSize;
	}
	public String getBufferLength() {
		return bufferLength;
	}
	public String getDecimalDigits() {
		return decimalDigits;
	}
	public String getNumPrecRadix() {
		return numPrecRadix;
	}
	public String getNullable() {
		return nullable;
	}
	public String getRemarks() {
		return remarks;
	}
	public String getColumnDef() {
		return columnDef;
	}
	public String getSqlDataType() {
		return sqlDataType;
	}
	public String getSqlDatetimeSub() {
		return sqlDatetimeSub;
	}
	public String getCharOctetLength() {
		return charOctetLength;
	}
	public String getOrdinalPosition() {
		return ordinalPosition;
	}
	public String getIsNullable() {
		return isNullable;
	}
	public void setTableCat(String tableCat) {
		this.tableCat = tableCat;
	}
	public void setTableSchem(String tableSchem) {
		this.tableSchem = tableSchem;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public void setColumnSize(String columnSize) {
		this.columnSize = columnSize;
	}
	public void setBufferLength(String bufferLength) {
		this.bufferLength = bufferLength;
	}
	public void setDecimalDigits(String decimalDigits) {
		this.decimalDigits = decimalDigits;
	}
	public void setNumPrecRadix(String numPrecRadix) {
		this.numPrecRadix = numPrecRadix;
	}
	public void setNullable(String nullable) {
		this.nullable = nullable;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public void setColumnDef(String columnDef) {
		this.columnDef = columnDef;
	}
	public void setSqlDataType(String sqlDataType) {
		this.sqlDataType = sqlDataType;
	}
	public void setSqlDatetimeSub(String sqlDatetimeSub) {
		this.sqlDatetimeSub = sqlDatetimeSub;
	}
	public void setCharOctetLength(String charOctetLength) {
		this.charOctetLength = charOctetLength;
	}
	public void setOrdinalPosition(String ordinalPosition) {
		this.ordinalPosition = ordinalPosition;
	}
	public void setIsNullable(String isNullable) {
		this.isNullable = isNullable;
	}
	
	public String getfLowerColName() {
		return fLowerColName;
	}
	public void setfLowerColName(String fLowerColName) {
		this.fLowerColName = fLowerColName;
	}
	public String getfUpperColName() {
		return fUpperColName;
	}
	public void setfUpperColName(String fUpperColName) {
		this.fUpperColName = fUpperColName;
	}
	public String getJavaType() {
		return javaType;
	}
	public void setJavaType(String javaType) {
		this.javaType = javaType;
	}
	public String getJavaPackage() {
		return javaPackage;
	}
	public void setJavaPackage(String javaPackage) {
		this.javaPackage = javaPackage;
	}
	public String getJdbcType() {
		return jdbcType;
	}
	public void setJdbcType(String jdbcType) {
		this.jdbcType = jdbcType;
	}
	public int getDataType() {
		return dataType;
	}
	public void setDataType(int dataType) {
		this.dataType = dataType;
	}
}
