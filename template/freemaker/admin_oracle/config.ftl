<body>
<#list tb.columns as item>
${item.remarks}
<input type="text" name="${item.fLowerColName}" value="${"$"}${tb.fLowerTName}.${item.fLowerColName}"></br>
</#list>
</body>