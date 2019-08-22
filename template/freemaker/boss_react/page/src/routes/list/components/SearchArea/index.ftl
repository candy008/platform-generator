/**
 *  SearchArea 查询组件
 */
import React, { Component } from 'react'
import { actions } from "mirrorx";
import PropTypes from 'prop-types';
import { Col, Row, FormControl, Label, Panel, Button,Collapse,Icon,Select,Form,InputGroup} from "tinper-bee";
import DatePicker from "tinper-bee/lib/Datepicker";
import {RefIuapDept,RefWalsinComboLevel} from 'components/RefViews';
import { deepClone,buildSearchData } from "utils";
import RefMultipleTableWithInput, { RefMultipleTable } from 'pap-refer/lib/pap-common-table/src/index';
import RefTreeWithInput, { RefTree } from 'pap-refer/lib/pap-common-tree/src/index';
import RefComboBox,{ ComboStore } from 'pap-refer/lib/pap-common-combobox/src/index';
import 'pap-refer/lib/pap-common-combobox/src/index.css';
const { RangePicker } = DatePicker;


const { FormItem } = Form;
const { Option } = Select;
const propTypes = {
    searchOpen: PropTypes.bool,//是否默认展开，false默认关闭
    handleSearch: PropTypes.func,//查询的回调
    reset: PropTypes.func,//重置的回调
    resetName: PropTypes.string,//重置的文字
    searchName: PropTypes.string,//查询的文字
    title: PropTypes.string
};

const defaultProps = {
    searchOpen: true,
    handleSearch: () => { },
    reset: () => { },
};
class SearchArea extends Component {
    constructor(props) {
        super(props)
        this.state = {
            searchOpen: this.props.searchOpen,
            moreSearch:false,
            //特殊处理Condition，如果不是LIKE，则在下面声明；
            conditionMap:{
                "creditState":"IN",
                "startDate":"EQ",
                "endDate":"EQ",
                "signDate":"EQ",
                "serviceYearsCompany":"GTEQ",
            }
        }
    }

    /**
     * @description 查询数据
     * @param {*} error 校验是否成功
     * @param {Object} values 表单数据
     */
    handleSearch = () => {
        let _this=this;
        this.props.form.validateFields((err, values) => {
            if (err) {
                return
            } else {
                // 年份特殊处理
                if (values.year) {
                    values.year = values.year.format('YYYY');
                }
                // 参照特殊处理
                const { dept } = values;
                if (dept) {
                    const { refpk } = JSON.parse(dept);
                    values.dept = refpk;
                }
                if(!values.creditTerm){
                    values.creditUnit="";
                }
                
                let queryParam = deepClone(_this.props.queryParam);
                let { pageParams } = queryParam;
                pageParams.pageIndex = 0;
                let {conditionMap}=this.state;
                // 对搜索条件拼接
                const arrayNew = buildSearchData(values,conditionMap);
                queryParam.whereParams = arrayNew;

                this.props.loadData(queryParam);
            }
        });

    }
    /**
     * @description 重置搜索表单中搜索条件,同时清空model中相应数据;
     */
    reset = () => {
        this.props.form.resetFields();
        actions.mainModel.updateState({
            listQueryParam: {
                pageParams: {
                    pageIndex: 0,
                    pageSize: 10,
                },
                sortMap: [],
                whereParams: []
            },
        });
    }

    render() {
        const { form,option,docOption } = this.props;
        const { getFieldProps } = form;
        let creditStateOptions,creditgrantOptions,creditUnitOptions;
        //单据状态;
        if(option.DIC_BILL_STATE){
            creditStateOptions = option.DIC_BILL_STATE.map(item => (
                <Option key={item.value}>{item.text}</Option>
            ));
        }
        // 
        if(option.fund_creditgrant_state){
            creditgrantOptions=option.fund_creditgrant_state.map(item => (
                <Option key={item.value}>{item.text}</Option>
            ));
        }
        if(option.term_unit){
            creditUnitOptions=option.term_unit.map(item => (
                <Option key={item.value}>{item.text}</Option>
            ));
        }

        return (
            <Panel className="search-panel">
                <Row>
            <#assign x=0 />
            <#list tb.columns as item>
                <#if x<4>
                    <div className="search-panel-item">
                        <FormItem>
                            <FormControl placeholder='${item.remarks}' showClose={true} {...getFieldProps('${item.fLowerColName}', {initialValue: ''})}/>
                        </FormItem>
                    </div>
                </#if>
                <#assign x=x+1 />
            </#list>
                    <div className='search-panel-item'>
                        <Button
                            className='submit-btn'
                            colors="primary"
                            onClick={this.search}
                        >查询</Button>
                        <Button
                            className='reset-btn'
                            shape='border'
                            onClick={this.reset}>清空
                        </Button>
                        <span style={{marginLeft:'8px'}} onClick={()=>{
                            this.setState({
                                moreSearch:!this.state.moreSearch
                            })
                        }}>
                            更多
                            <Icon type={this.state.moreSearch?"uf-arrow-up":"uf-anglearrowdown"}></Icon>
                        </span>

                    </div>
                </Row>
                <Collapse in={this.state.moreSearch}>
                    <div>
                        <Row>
                            <#assign x=0 />
                        <#list tb.columns as item>
                            <#if x gt  3>
                            <div className="search-panel-item">
                                <FormItem>
                                    <FormControl placeholder='${item.remarks}' showClose={true} {...getFieldProps('${item.fLowerColName}', {initialValue: ''})}/>
                                </FormItem>
                            </div>
                            </#if>
                            <#assign x=x+1 />
                        </#list>
                        </Row>
                    </div>
                </Collapse>
            </Panel>
        )
    }
}
SearchArea.propTypes = propTypes;
SearchArea.defaultProps = defaultProps;
export default Form.createForm()(SearchArea)
