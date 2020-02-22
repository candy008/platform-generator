/**
 *  MainForm.js 详情页-表单组件
 */
import React, { Component } from "react";
import moment from "moment";
import { Row, FormControl, Label, InputNumber, Icon, Collapse, InputGroup, Button} from "tinper-bee";
import { RefIuapDept } from 'components/RefViews';
import DatePicker from 'bee-datepicker';
import Form from 'bee-form';
import Select from 'bee-select';
import FormError from 'components/FormError';
import RefComboBox, { ComboStore } from 'pap-refer/lib/pap-common-combobox/src/index';
import { getCurrentTime } from "utils";
import RefWalsinCombo from 'components/RefWalsinCombo';
import PapReferOrg from 'pap-refer/lib/pap-ref-org/src/index.js';
import PapRefStaff from 'pap-refer/lib/pap-ref-staff/src/index';
import RefTreeWithInput, { RefTree } from 'pap-refer/lib/pap-common-tree/src/index';
import { actions } from "mirrorx";
import axios from "axios"
import { getCookie,deepClone } from "utils";
import './index.less';

const { Option } = Select;
const { FormItem } = Form;
const format = "YYYY-MM-DD";

class MainForm extends Component {
    constructor(props) {
        super(props);
        this.state = {
            openState: {
                open1: false,
                open2: true,
            },
            endDate:"",
            creditTerm:1,
        }
    }
    openStateFun = (num) => {
        let obj = deepClone(this.state.openState);
        obj["open" + num] = !obj["open" + num];
        this.setState({ openState: obj })
    }
    /**
     *  截止日期的获取方法
     */
    DateAdd=(interval,number,date)=>{
        switch(interval) 
        { 
            case   "y"   :   { 
                    date.setFullYear(date.getFullYear()+number); 
                    return   date; 
                    break; 
            } 
            case   "q"   :   { 
                    date.setMonth(date.getMonth()+number*3); 
                    return   date; 
                    break; 
            } 
            case   "m" :   { 
                    date.setMonth(date.getMonth()+number); 
                    return   date; 
                    break; 
            } 
            case   "w"   :   { 
                    date.setDate(date.getDate()+number*7); 
                    return   date; 
                    break; 
            } 
            case   "d"   :   { 
                    date.setDate(date.getDate()+number); 
                    return   date; 
                    break; 
            }
            case   "h"   :   { 
                    date.setHours(date.getHours()+number); 
                    return   date; 
                    break; 
            } 
            case   "m"   :   { 
                    date.setMinutes(date.getMinutes()+number); 
                    return   date; 
                    break; 
            } 
            case   "s"   :   { 
                    date.setSeconds(date.getSeconds()+number); 
                    return   date; 
                    break; 
            } 
            default   :   { 
                    date.setDate(date.getDate()+number); 
                    return   date; 
                    break; 
            } 
        } 
    }
    /*
    *开始日期改变的回调
    */
    startDateFun=(value)=>{
        if(!value){return};
        let { formData } = this.props;
        let formDataCopy=deepClone(formData);
        let {creditTerm,creditUnit,startDate}=formDataCopy;
        //授信期限默认为1
        if(!creditTerm){creditTerm=1}
        //授信期限单位默认为1
        if(!creditUnit){creditUnit="1"}
        //获取开始时间
        
        startDate=value.format("YYYY-MM-DD")
        formData.startDate=startDate;
        startDate=new Date(startDate).getTime();
        this.getEndDate(startDate,creditTerm,creditUnit);
    }
    /*
    *授信期限改变时的回调
    */
    creditTermChange=(value)=>{
        if(!!value){
            let { formData } = this.props;
            let formDataCopy=deepClone(formData)
            let {creditTerm,creditUnit,startDate}=formDataCopy;
            if(!creditUnit){
                creditUnit="1";
            }
            if(!startDate){
                startDate=new Date();
            }
            creditTerm=Number(value);
            this.getEndDate(startDate,creditTerm,creditUnit);
        }
    }
    /*
    *creditUnitChange
    *授信期限单位改变时的回调
    */
   creditUnitChange=(value)=>{
        let { formData } = this.props;
        let {creditTerm,creditUnit,startDate}=formData;
        if(!creditTerm){creditTerm=1}
        if(!startDate){
            startDate=new Date();
        }
        creditUnit=value;
        formData.creditUnit=value;
        creditTerm=Number(creditTerm);
        this.getEndDate(startDate,creditTerm,creditUnit);
   }
    /*
    *获取结束日期
    *@startDate开始日期
    *@creditTerm 授信期限
    *@creditUnit 授信期限单位
    */
   getEndDate=(startDate,creditTerm,creditUnit)=>{
  
        if(creditTerm){
            creditTerm=Number(creditTerm);
            creditUnit=creditUnit.toString();
        }else{
            return;
        }
        let { formData } = this.props;
        let _formData=deepClone(formData);
        let endDate;
        //授信期限为年的处理
        if(creditUnit.toString()==='1'){
            endDate=this.DateAdd('y',creditTerm,new Date(startDate));
        }
        //授信期限为月的处理
        if(creditUnit.toString()==='2'){
            endDate=this.DateAdd('m',creditTerm,new Date(startDate));
        }
            //授信期限为天的处理
            if(creditUnit.toString()==='3'){
            endDate=this.DateAdd('d',creditTerm,new Date(startDate));
        }
        endDate=endDate.toLocaleDateString();
        let arr=endDate.split("/");
        let [year,month,day]=arr;
        day=day-1;
        if(day===0){
            month=month-1;
            if(month===2){
                day=28;
            }
            if('1,3,5,7,8,10,12'.indexOf(month)>-1){
                day=31;
            }else{
                day=30;
            }
        }
        if(month===0){
            year=year-1;
            month=12;
        }
        endDate=year+"-"+month+"-"+day;
        _formData.endDate=endDate;
        _formData.startDate=startDate;
        _formData.creditTerm=creditTerm;
        _formData.creditUnit=creditUnit;
        actions.mainModel.updateState({
            editFormData:_formData
        })
   }
   /**
    * 综合授信额度 
    */
//    totalCreditAmtOnchange=(value)=>{
//        let {queryDetailObj}=deepClone(this.props);
//        if(!queryDetailObj.list.length){
//            return
//        }
//        let { formData } = this.props;
//        let sum=0;
//        queryDetailObj.list.forEach(element => {
//             sum+=Number(element.creditAmt);
//        });
//        if(value<sum){
//             Message.create({content: '综合授信额度值不得小于子表授信额度总和', color: 'warninglight'});
//        }  
//    }
     /**
     * 字典自定义档案的翻译
     * @value 要翻译的值
     * @optionStr 根据哪个地点翻译
     * @inStr 用来对比的属性
     * @outStr 输出结构的属性
     */ 
    dicFormatter=(value,dicFormatter,inStr,outStr)=>{
        if(!value){return};
        let {option}=deepClone(this.props);
        let list=option[dicFormatter];
        if(list&&list.length){
            for(let item in list){
                if(value.toString()===list[item][inStr]){
                    return list[item][outStr]
                }
            }
        }

    }
    /**
     * 自定义档案档案的翻译
     * @value 要翻译的值
     * @optionStr 根据哪个地点翻译
     * @inStr 用来对比的属性
     * @outStr 输出结构的属性
     */ 
    dicMoreFormatter=(value,dicFormatter,inStr,outStr)=>{
        
        if(!value){return};
        let {docOption}=deepClone(this.props);
        let list=docOption[dicFormatter];
        let str=""
        let arr=value.split(",");
        for(let j=0;j<arr.length;j++){
            if(list&&list.length){
                for(let item in list){
                    if(arr[j].toString()===list[item][inStr]){
                        str+= list[item][outStr]+","
                        break
                    }
                }
            }
        }
        str=str.substring(0,str.length-1);
        return str
    }
    //赋值操作时的初始化操作
    initCopyData=()=>{
        let {formData}=this.props;
        formData.billNo="";
        formData.creditName="";
        formData.createUserName="";
        formData.createUser="";
        formData.pkOrgName="";
        formData.pkOrg="";
    }

    /**
     *  @description  生成下拉列表的 Options;
     *  @param key 需要翻译的字段的key;
     *  @param option 字典数据源;
     *  @retrun 翻译的 options;
     */
    generateOptions(key,option){
        if(JSON.stringify(option)!="{}"){
            let tempOps=option[key].map(obj=>(
                <Option key={obj.value} value={obj.value}>{obj.text}</Option>
            ))
            return tempOps;
        }
    };
    /**
     * @description  生成自定义档案的 Options; 
     * @param key 需要翻译的字段的key;
     * @param option 字典数据源;
     */
    generateDicOptions(key,dicOption){
        if(JSON.stringify(dicOption)!="{}"){
            let tempOps=dicOption[key].map(obj=>(
                <Option key={obj.dicItemValue} value={obj.dicItemValue}>{obj.dicItemField}</Option>
            ))
            return tempOps;
        }
    }

    render() {
        const _this = this;

        let { formData, btnFlag, form,option,docOption,copy} = _this.props;
        const { getFieldProps, getFieldError } = form;
        //默认授信结束日期
        let {creditTerm}=this.state;
        let date=new Date(),year=date.getFullYear()+1,month=date.getMonth()+1,day=date.getDate();
        if(copy){
            this.initCopyData()
        }
        return (
            <div className="edit-collapse">
                <div className="collapse-title" onClick={this.openStateFun.bind(this, 1)}>基本信息
                    <Icon type={this.state.openState.open1 ? "uf-minus" : "uf-plus"} ></Icon>
                    <span className="line"></span>
                </div>
                <Collapse in={this.state.openState.open1}>
                    <div>
                        <Row className='detail-body form-panel order-panel'>
							 <FormItem>
								<Label className="required">{btnFlag === GROBAL_PAGE_STATE.VIEW &&<span>：</span>}单据编码</Label>
								{btnFlag === GROBAL_PAGE_STATE.VIEW ? <div className='u-form-control-text'>{formData.billNo || ""}</div> : 
								<FormControl disabled={true}
									placeholder="系统自动生成"
									{...getFieldProps('billNo', {
										initialValue: formData.billNo || "",
									})}
							
								/>}
								<FormError errorMsg={getFieldError('billNo')} />
							</FormItem>
							<#list tb.columns as item>
								<FormItem>
									<Label className="required">${item.remarks}</Label>
									{btnFlag === GROBAL_PAGE_STATE.VIEW ?
										<div className='u-form-control-text'>{formData${"."}${item.fLowerColName} || ""}</div> :
										<FormControl placeholder="${item.remarks}"
											{...getFieldProps('${item.fLowerColName}', {
												initialValue: formData${"."}${item.fLowerColName} || "",
												}
											)}
										/>
									}
									<FormError errorMsg={getFieldError('${item.fLowerColName}')} />
								</FormItem>
							</#list>
                        </Row>
                    </div>
                </Collapse>
                <div className="collapse-title" onClick={this.openStateFun.bind(this, 2)}>操作数据
                    <Icon type={this.state.openState.open2 ? "uf-minus" : "uf-plus"} ></Icon>
                    <span className="line"></span>
                </div>
                <Collapse in={this.state.openState.open2}>
                    <div>
                        <Row className='detail-body form-panel order-panel'>
                            <FormItem>
                                <Label>{btnFlag === GROBAL_PAGE_STATE.VIEW&&<span>：</span>}单据状态</Label>
                                {btnFlag === GROBAL_PAGE_STATE.VIEW ? <div className='u-form-control-text'>{this.dicFormatter(formData.approveStatus,'DIC_BILL_STATE','value','text')}</div> : <Select disabled={true}
                                    {...getFieldProps('approveStatus', {
                                        initialValue: formData.approveStatus ? formData.approveStatus.toString() : "1",
                                    })}
                                >
                                    {this.generateOptions('DIC_BILL_STATE',option)}
                                </Select>}
                                <FormError errorMsg={getFieldError('approveState')} />
                            </FormItem>
                            <FormItem>
                                <Label>{btnFlag === GROBAL_PAGE_STATE.VIEW&&<span>：</span>}创建人</Label>
                                {btnFlag === GROBAL_PAGE_STATE.VIEW ? <div className='u-form-control-text'>{formData.createUserName || ""}</div> :
                                    <FormControl
                                        disabled={true}
                                        {...getFieldProps('createUserName', {
                                            initialValue: formData.createUserName || "",
                                        })} 
                                    />
                                }
                                <FormError errorMsg={getFieldError('createUserName')} />
                            </FormItem>
                            <FormItem>
                                <Label>{btnFlag === GROBAL_PAGE_STATE.VIEW&&<span>：</span>}创建机构</Label>
                                {btnFlag === GROBAL_PAGE_STATE.VIEW ? <div className='u-form-control-text'>{formData.pkOrgName || ""}</div> : 
                                    <FormControl
                                        disabled={true}
                                        {...getFieldProps('pkOrgName', {
                                            initialValue: formData.pkOrgName || "",
                                        })} 
                                    />}
                                <FormError errorMsg={getFieldError('pkOrgName')} />
                            </FormItem>
                            <FormItem>
                                <Label>{btnFlag === GROBAL_PAGE_STATE.VIEW && <span>：</span>}创建部门</Label>
                                {btnFlag === GROBAL_PAGE_STATE.VIEW ? <div className='u-form-control-text'>{formData.pkDeptName || ""}</div> : 
                                    <FormControl
                                        disabled={true}
                                        {...getFieldProps('pkDeptName', {
                                            initialValue: formData.pkDeptName || "",
                                        })} />
                                }
                                <FormError errorMsg={getFieldError('pkDeptName')} />
                            </FormItem>
                            <FormItem>
                                <Label>{btnFlag === GROBAL_PAGE_STATE.VIEW && <span>：</span>}创建时间</Label>
                                {btnFlag === GROBAL_PAGE_STATE.VIEW ? 
                                <div className='u-form-control-text'>{formData.createTime || ""}</div> : 
                                <DatePicker disabled={true} format={format}
                                    {...getFieldProps('createTime', {
                                        initialValue: moment(formData.createTime)|| moment(),
                                        }
                                    )}
                                />}
                                <FormError errorMsg={getFieldError('createTime')} />
                            </FormItem>
                            <FormItem>
                                <Label>{btnFlag === GROBAL_PAGE_STATE.VIEW&&<span>：</span>}审核人</Label>
                                {btnFlag === GROBAL_PAGE_STATE.VIEW ? <div className='u-form-control-text'>{formData.approver || ""}</div> : 
                                    <FormControl
                                        disabled={true}
                                        {...getFieldProps('approver', {
                                            initialValue: formData.approver || "",
                                        })} 
                                    />
                                }
                                <FormError errorMsg={getFieldError('approver')} />
                            </FormItem>
                            <FormItem>
                                <Label>{btnFlag === GROBAL_PAGE_STATE.VIEW && <span>：</span>}审核日期</Label>
                                {btnFlag === GROBAL_PAGE_STATE.VIEW ? <div className='u-form-control-text'>{formData.approveDate || ""}</div> : 
                                <DatePicker disabled={true} format={format}
                                    {...getFieldProps('approveDate', {
                                        initialValue: moment(formData.approveDate)||moment(),
                                        }
                                    )}
                                />}
                                <FormError errorMsg={getFieldError('approveDate')} />
                            </FormItem>
                            <FormItem>
                                <Label>{btnFlag === GROBAL_PAGE_STATE.VIEW&&<span>：</span>}审批批语</Label>
                                {btnFlag === GROBAL_PAGE_STATE.VIEW ? <div className='u-form-control-text'>{formData.approverNote || ""}</div> : 
                                <FormControl disabled={true}
                                    {...getFieldProps('approverNote', {
                                        initialValue: formData.approverNote || '',
                                    }
                                    )}
                                />}
                                <FormError errorMsg={getFieldError('approverNote')} />
                            </FormItem>
                        </Row>
                    </div>
                </Collapse>
            </div>

        )
    }
}

export default MainForm

