Ext.define('${cfb.packageName}.${cfb.packageSuffix}.${tb.fUpperTName}FormController', {
    extend: 'Ext.app.Controller',
    refs: [{
        ref: ' ${tb.fLowerTName}',
        selector: ' ${tb.fLowerTName}'
    },{
		ref: 'commonToolsbar',
		selector: 'commonToolsbar'
	}],
    init: function() {
        this.control({

        });
    }
});

