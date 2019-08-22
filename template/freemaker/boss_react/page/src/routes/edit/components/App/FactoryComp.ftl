
import React, { Component } from 'react';
//文本输入组件
import TextField from 'components/RowField/TextField';
//下拉选择组件
import SelectField from 'components/RowField/SelectField';
//数值选择组件
import NumberField from 'components/RowField/NumberField';
//年份选择组件
import YearField from 'components/RowField/YearField';
//参照部门
import RefDept from 'components/RowField/RefDept';
//普通参照
import Ref from 'components/RowField/Ref';
//多选参照
import MultipleRef from 'components/RowField/MultipleRef';
//日期组件
import DateField from 'components/RowField/DateField';
import moment from "moment";

class FactoryComp extends Component {
    /**
     * 参照选择值的操作
     * 
     */
    onClickItem=()=>{

    }
    /*
    *字段的翻译
    */
   formatterState=(str,option,value,label)=>{
    if(!option){return str};
        if(str&&option.length){
            for(let i=0;i<option.length;i++){
                if(str===option[i][value].toString()){
                    return option[i][label]
                }
            }
        }else{
            return ""
        }
   }
   /*
   *授信点击确认的回调
   */
   pkProdsSave=(value)=>{
        
   }
    /**
     * 渲染组件函数
     * @returns JSX
     */
    renderComp = () => {
        let { type, value, record,docOption} = this.props;
        let fundPurposeData;
        
        if(docOption&&docOption.fund_fund_use){
            fundPurposeData=docOption.fund_fund_use;
            for(let i=0;i<fundPurposeData.length;i++){
                fundPurposeData[i].value=fundPurposeData[i].dicItemValue;
                fundPurposeData[i].key=fundPurposeData[i].dicItemField;
            }
        }
        switch (type) {
            case 'pkProds'://授信品种
            return (<div>
                
                {record._edit ?
                    <MultipleRef {...this.props}
                        title="授信品种"
                        multiple={true}
                        emptyBut={true}
                        backdrop={true}
                        status={record['_status']}//是否修改过标记
                        validate={record['_validate']}//启用验证
                        url={{
                            tableBodyUrl:'/imfbp-fms-web/common-ref/blobRefTreeGrid',
                            refInfo:'/imfbp-fms-web/fms-ref/refInfo'
                        }}
                        onSave={this.pkProdsSave}
                        param={{refCode: 'financeproduct'}}
                        value={JSON.stringify({refpk:record.pkProds,
                        refname: record.pkProdsName})}
                    /> : <div>{record.pkProdsName||record.pkProds}</div>}
            </div>);
            case 'fundPurpose'://资金用途
                return (<div>
                    {record._edit ?
                        <SelectField {...this.props}
                            status={record['_status']}//是否修改过标记
                            validate={record['_validate']}//启用验证
                            data={fundPurposeData}
                        /> : <div>{this.formatterState(record.fundPurpose,fundPurposeData,'dicItemValue','dicItemField')}</div>}
                </div>);
            case 'ctrlMethod'://控制方式
            const ctrlData = [{
                key: "请选择",
                value: '',
            }, {
                key: "控制",
                value: "1"
            }, {
                key: "不控制",
                value:"2"
            }];
            return (<div>
                {record._edit ?
                    <SelectField {...this.props}
                        status={record['_status']}//是否修改过标记
                        validate={record['_validate']}//启用验证
                        data={ctrlData}
                    /> : <div>{this.formatterState(record.ctrlMethod,ctrlData,'value','key')}</div>}
            </div>);
            case 'creditAmt'://授信额度
                return (<div>
                    {record._edit ?//编辑态
                        <TextField {...this.props}
                            status={record['_status']}//是否修改过标记
                            validate={record['_validate']}//启用验证
                        /> : <div>{value}</div>}
                </div>);
            // case 'initUsedCreditAmt'://期初已用授信额度
            //     return (<div>
            //         {record._edit ?//编辑态
            //             <TextField {...this.props}
            //                 status={record['_status']}//是否修改过标记
            //                 validate={record['_validate']}//启用验证
            //             /> : <div>{value}</div>}
            //     </div>);
            
            case 'curUsedCreditAmt'://本期已用授信额度
            return (<div>
                {record._edit ?//编辑态
                    <TextField {...this.props}
                        status={record['_status']}//是否修改过标记
                        validate={record['_validate']}//启用验证
                    /> : <div>{value}</div>}
            </div>);
            case 'isCycle'://是否可循环
                const isCycleData = [{
                    key: "请选择",
                    value: '',
                }, {
                    key: "是",
                    value: "1"
                }, {
                    key: "否",
                    value:"2"
                }];
                return (<div>
                    {record._edit ?
                        <SelectField {...this.props}
                            status={record['_status']}//是否修改过标记
                            validate={record['_validate']}//启用验证
                            data={isCycleData}
                        /> : <div>{this.formatterState(record.isCycle,isCycleData,'value','key')}</div>}
                </div>);
            case 'filename'://附件名称
                return (<div>
                    {record._edit ?//编辑态
                        <TextField {...this.props}
                            status={record['_status']}//是否修改过标记
                            validate={record['_validate']}//启用验证
                        /> : <div>{value}</div>}
                </div>);
            case 'uploadnote'://附件说明
            return (<div>
                {record._edit ?//编辑态
                    <TextField {...this.props}
                        status={record['_status']}//是否修改过标记
                        validate={record['_validate']}//启用验证
                    /> : <div>{value}</div>}
            </div>);
            default:
                return (<div>组件类型错误</div>)
        }
    }
    render() {
        return (<div>
            {this.renderComp()}
        </div>);
    }
}

export default FactoryComp;
