import React, { Component } from "react";
import moment from "moment";
import { Col, Row, FormControl, Label, InputNumber, Icon, Collapse, InputGroup, Button } from "tinper-bee";
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
//普通参照
import Ref from 'components/RowField/Ref';

import { getCookie } from "utils";

import './index.less';
import { deepClone } from "../../../../../../../ucf-common/src/utils";

const { Option } = Select;
const { FormItem } = Form;
const format = "YYYY-MM-DD";

class ${tb.fUpperTName}Form extends Component {
    constructor(props) {
        super(props);
        this.state = {
            openState: {
                open1: true,
                open2: true
            }
        }
    }
    openStateFun = (num) => {
        let obj = deepClone(this.state.openState);
        obj["open" + num] = !obj["open" + num];
        this.setState({ openState: obj })
    }
    /**
     * 获取当前时间
     */
    render() {
        const _this = this;
        let { orderRow, btnFlag, form } = _this.props;
        const { getFieldProps, getFieldError } = form;
        return (
            <div className="edit-collapse">
                <div className="collapse-title" onClick={this.openStateFun.bind(this, 1)}>基本信息
                    <Icon type={this.state.openState.open1 ? "uf-minus" : "uf-plus"} ></Icon>
                    <span className="line"></span>
                </div>
                <Collapse in={this.state.openState.open1}>
                    <div>
                        <Row className='detail-body form-panel order-panel'>
                        <#list tb.columns as item>
                            <FormItem>
                                <Label className="required">${item.remarks}</Label>
                                {btnFlag === GROBAL_FORM_STATE.VIEW ?
                                <div className='u-form-control-text'>{orderRow${"."}${item.fLowerColName} || ""}</div> :
                                <FormControl placeholder="${item.remarks}" {...getFieldProps('${item.fLowerColName}', {initialValue: orderRow${"."}${item.fLowerColName} || "",})}/>}
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
                                <Label>创建人</Label>
                                {btnFlag === 2 ? <div className='u-form-control-text'>{orderRow.createUser || ""}</div> :
                                    <FormControl
                                        disabled={true}
                                        {...getFieldProps('createUser', {
                                            initialValue: orderRow.createUser || "",
                                        })} />}
                                <FormError errorMsg={getFieldError('createUser')} />
                            </FormItem>
                            <FormItem>
                                <Label>创建机构</Label>
                                {btnFlag === 2 ? <div className='u-form-control-text'>{orderRow.pkOrg || ""}</div> : <FormControl
                                    disabled={true}
                                    {...getFieldProps('pkOrg', {
                                        initialValue: orderRow.pkOrg || "",
                                    })} />}
                                <FormError errorMsg={getFieldError('pkOrg')} />
                            </FormItem>
                            <FormItem>
                                <Label>创建部门</Label>
                                {btnFlag === 2 ? <div className='u-form-control-text'>{orderRow.pkDept || ""}</div> : <FormControl
                                    disabled={true}
                                    {...getFieldProps('pkDept', {
                                        initialValue: orderRow.createUser || "",
                                    })} />}
                                <FormError errorMsg={getFieldError('pkDept')} />
                            </FormItem>
                            <FormItem>
                                <Label>创建时间</Label>
                                {btnFlag === 2 ? <div className='u-form-control-text'>{orderRow.createTime || ""}</div> :
                                <DatePicker disabled={true}
                                    {...getFieldProps('createTime', {
                                        validateTrigger: 'onBlur',
                                        initialValue: orderRow.reationTime || moment(),
                                    }
                                    )}
                                    format={format}
                                    placeholder="请选择时间"
                                />}
                                <FormError errorMsg={getFieldError('createTime')} />
                            </FormItem>
                            <FormItem>
                                <Label>审核日期</Label>
                                {btnFlag === 2 ? <div className='u-form-control-text'>{orderRow.approveDate || ""}</div> : <DatePicker disabled={true}
                                    {...getFieldProps('approveDate', {
                                        initialValue: orderRow.approveDate || moment(),
                                    }
                                    )}
                                    format={format}
                                    placeholder="请选择时间"
                                />}
                                <FormError errorMsg={getFieldError('approveDate')} />
                            </FormItem>
                        </Row>
                    </div>
                </Collapse>
            </div>

        )
    }
}

export default ${tb.fUpperTName}Form

