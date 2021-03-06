package com.platform.generator.interfaces.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.platform.generator.GeneratorCenter;
import com.platform.generator.bean.GeneratorBean;
import com.platform.generator.bean.GeneratorTable;
import com.platform.generator.config.GeneratorConfig;
import com.platform.generator.interfaces.GeneratorFile;
import com.platform.generator.util.ConfEnum;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import net.sf.json.JSONObject;

public class DefaultGeneratorFile implements GeneratorFile {


    private static Map<String, String> pageTagMap = new HashMap<String, String>();


//	
//	private String tableSchem;
//
//	private String tableName;
//	
//	private String tableType;
//	
//	private String remarks;
//	
//	private List<GeneratorColumns> columns;
//	
//	private String fLowerTName;
//	
//	private String fUpperTName;
//	
//	private String allLowerTName="";
//	
//	private String lTableName;


    @Override
    public void generatorDataToFile(GeneratorConfig generatorConfig, GeneratorTable generatorTable) {
        Map<String, GeneratorBean> generatorMap = generatorConfig.getGeneratorBeanMap();
        for (Map.Entry<String, GeneratorBean> entry : generatorMap.entrySet()) {
            GeneratorBean generatorBean = entry.getValue();
            pageTagMap.put("tableName", generatorTable.getTableName());
            pageTagMap.put("fLowerTName", generatorTable.getfLowerTName());
            pageTagMap.put("fUpperTName", generatorTable.getfUpperTName());
            pageTagMap.put("allLowerTName", generatorTable.getAllLowerTName());
            List<String> configList = generatorBean.getConfigList();


            Map<String, String> myTag = new HashMap<String, String>();
            myTag.put("!allLowerTName!", generatorTable.getAllLowerTName());
            myTag.put("!myadmintag!", generatorTable.getAllLowerTName());
            myTag.put("!mysoatag!", generatorTable.getAllLowerTName());

//			myTag.put("!allLowerTName!", "doclib");
//			myTag.put("!myadmintag!", "doclib");
            //myTag.put("!mysoatag!", "soa.coupon");


//			myTag.put("!allLowerTName!", "grade");
//			myTag.put("!mysoatag!", "soa.grade");
//			myTag.put("!myadmintag!", "admin.grade");


            if (configList != null) {

                for (int i = 0; i < configList.size(); i++) {
                    String configJson = configList.get(i);
                    JSONObject jsonObject = JSONObject.fromObject(configJson);
                    System.out.println(jsonObject.getString("templateName"));
                    Map<String, Object> dataMap = new HashMap<String, Object>();

                    String fileType = jsonObject.getString(ConfEnum.FILE_TYPE.getConfig());
                    String fileNameSuffix = jsonObject.getString(ConfEnum.FILENAME_SUFFIX.getConfig());
                    String packageSuffix = jsonObject.getString(ConfEnum.PACKAGE_SUFFIX.getConfig());

                    myTag.put("!myaextjstag!", "security." + generatorTable.getAllLowerTName());

                    String mypackageTag = "";

                    for (String key : myTag.keySet()) {
                        if (packageSuffix.indexOf(key) >= 0) {
                            packageSuffix = packageSuffix.replace(key, myTag.get(key));
                            mypackageTag = myTag.get(key);
                        }
                    }

                    String templateName = jsonObject.getString(ConfEnum.TEMPLATE_NAME.getConfig());

                    String parentClassName = jsonObject.getString(ConfEnum.PARENT_CLASSNAME.getConfig());
                    String parentPackageName = jsonObject.getString(ConfEnum.PARENT_PACKAGENAME.getConfig());
                    String tpath = jsonObject.getString(ConfEnum.PATH.getConfig());
                    String packageName = "";
                    String packageName1 = "";
                    try {
                        packageName = jsonObject.getString("packageName");
                    } catch (Exception e) {
                        System.out.println("jsonObject.getString('packageName') is null");
                    }
                    try {
                        packageName1 = jsonObject.getString("packageName1");
                    } catch (Exception e) {
                        System.out.println("jsonObject.getString('packageName1') is null");
                    }

                    String packageSuffixPath = packageSuffix.replace(".", "/");
                    generatorBean.setPackageSuffixPath(packageSuffixPath);
                    generatorBean.setFileType(fileType);
                    generatorBean.setFileNameSuffix(fileNameSuffix);
                    generatorBean.setPackageSuffix(packageSuffix);
                    generatorBean.setTemplateName(templateName);
                    generatorBean.setParentClassName(parentClassName);
                    generatorBean.setParentPackageName(parentPackageName);
                    generatorBean.setPath(tpath);
                    generatorBean.setPackageName1(packageName1);
                    generatorBean.setPackageNameTemp(packageName);


                    String filename = generatorTable.getfUpperTName() + fileNameSuffix + "." + fileType;

                    String path = generatorBean.getPackageName().replace(".", "/");
                    if (fileNameSuffix.contains("Mapper")&&!fileType.contains("java")) {
                        path = "";
                    } else if (fileType.equals("vm")) {
                        path = "/WEB-INF/vm/";
                        filename = generatorTable.getfLowerTName() + fileNameSuffix + "." + fileType;
                        packageSuffixPath = generatorTable.getfLowerTName();
                    } else if ("template_struts".equals(templateName)) {
                        path = "";
                        String taable = generatorTable.getTableName().replace("T_", "");
                        taable = taable.replace("_", "-");
                        filename = "struts-" + taable.toLowerCase() + fileNameSuffix + "." + fileType;
                        packageSuffixPath = "struts";
                    } else if (fileType.contains("vue")) {
                        path = "";
                        filename = generatorTable.getfLowerTName() + fileNameSuffix + "." + fileType;
                    } else if (fileType.contains("js")) {
                        path = "";
                        filename = generatorTable.getfLowerTName() + fileNameSuffix + "." + fileType;
                    } else if (fileType.contains("json")) {
                        path = "";
                        filename = generatorTable.getfLowerTName() + fileNameSuffix + "." + fileType;
                    }else if(fileType.contains("html")){
                        path = "";
                    }
                    else if(fileType.contains("less")){
                        path = "";
                    }

                    if(jsonObject.containsKey("fileName")){
                        filename = jsonObject.getString("fileName") + fileNameSuffix + "." + fileType;
                    }

                    String filePath = "";
                    if(jsonObject.containsKey("filePath")){
                        filePath = jsonObject.getString("filePath");
                        filePath=filePath.replaceAll("!myadmintag!",myTag.get("!myadmintag!"));
                    }

                    //packageSuffixPath = generatorTable.getTableName().replaceAll("_","-");

                    String generatorFilePath = generatorConfig.getBasePath() + "/" + "/" + generatorBean.getPath() + "/" + path + "/" + packageSuffixPath + "/"+filePath;

                    System.out.println(generatorFilePath);

                    dataMap.put("tb", generatorTable);
                    dataMap.put("cfb", generatorBean);
                    dataMap.put("cf", generatorConfig);
                    dataMap.put("myTag", myTag);
//                    generatorTable.getChildTable().get(0);
                    dataMap.put("mytagprizepackage", mypackageTag);
                    dataMap.put("mytagprizepackage1", myTag.get("!allLowerTName!"));
                    dataMap.put("child",generatorTable.childTable);
//					dataMap.put("LowerAllkeyTag","matkey");
//					dataMap.put("upperAllkeyTag","MATKEY");
//					dataMap.put("fUkeyTag","matkey");
//					dataMap.put("fLkeyTag","matkey");


                    generatorFile(generatorFilePath, filename, templateName, dataMap, generatorConfig);
//
//                    if(generatorTable.isChild()){
//                        generatorFile(generatorFilePath, filename, templateName+"_child", dataMap, generatorConfig);
//                    }else{
//                        generatorFile(generatorFilePath, filename, templateName, dataMap, generatorConfig);
//                    }

                }


//				for (Map.Entry<String, String> templateEntry : templateMap.entrySet()) {
//					Map<String, Object> dataMap = new HashMap<String, Object>();
//					dataMap.put("tb", generatorTable);
//					dataMap.put("cfb", generatorBean);
//					dataMap.put("cf", generatorConfig);
//					String filename = generatorTable.getfUpperTName()+ templateEntry.getValue();
//					generatorFile(generatorFilePath, filename,templateEntry.getKey(), dataMap);
//					System.out.println("generator:"+filename);
//				}
            }
        }
    }

    private void generatorFile(String generatorFilePath, String fileName, String template, Map<String, Object> dataMap, GeneratorConfig generatorConfig) {

        //URL templatePath = this.getClass().getClassLoader().getResource("freemaker");

        Template tpl;
        Configuration cf = new Configuration();
        cf.setObjectWrapper(new DefaultObjectWrapper());
        Writer out = null;

        try {
            String[] templateNameArr;
            String templateName = template;
            String templatePath = "/";
            if (template.indexOf("/") > 0) {
                templateNameArr = template.split("/");
                templatePath = "/" + template.substring(0,template.lastIndexOf("/")+1);
                templateName = template.substring(template.lastIndexOf("/")+1,template.length());
            }
            //TODO fulq 取配置
            String freemakerTemplate = generatorConfig.getFreemakerTemplatePath();
            if (freemakerTemplate == null || freemakerTemplate.equals(""))
                freemakerTemplate = GeneratorCenter.TEMPPLATE_PATH;

            cf.setDirectoryForTemplateLoading(new File(freemakerTemplate + templatePath));
            tpl = cf.getTemplate(templateName + ".ftl");

            File tempfile = new File(generatorFilePath);
            if (!tempfile.exists()) {
                tempfile.mkdirs();
            }


            if ("config".equals(templateName)) {
                String generatorFilePathTemp = generatorConfig.getBasePath() + "/config";
                File tempfile1 = new File(generatorFilePathTemp);
                if (!tempfile1.exists()) {
                    tempfile1.mkdirs();
                }
                File tempfile2 = new File(generatorConfig.getBasePath() + "/config/dao.xml");
                out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(tempfile2, true), "UTF-8"));
                tpl.process(dataMap, out);
            } else {
                File file = new File(generatorFilePath + "/" + fileName);
                out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"));
                tpl.process(dataMap, out);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            System.out.println("path:" + generatorFilePath);
            try {
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}
