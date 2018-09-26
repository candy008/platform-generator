<#list tb.columns as item>
<input type="text" name="${item.fLowerColName}" value="${"$"}${tb.fLowerTName}.${item.fLowerColName}"></br>
<bean id="${tb.fLowerTName}Dao" class="${cfb.packageName}.dao.${mytagprizepackage}.impl.${tb.fUpperTName}DaoImpl">
	<property name="sqlSessionFactory" ref="commonSqlSessionFactory"></property>
</bean></br>
</#list>
