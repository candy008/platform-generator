/**
 *  AppEdit 详情页-主页
 */
import React, { Component } from "react";
import { actions } from "mirrorx";
import queryString from 'query-string';
import { uuid, deepClone, success, Error , Info,getCookie, getPageParam } from "utils";
import { Loading, Icon, Modal, Button } from "tinper-bee";
import Form from 'bee-form';
import Header from "components/Header";
import Alert from 'components/Alert';
import {BpmButtonSubmit, BpmButtonRecall} from 'yyuap-bpm';
import PositionScroll from 'components/PositionScroll';
import ApprovalProcess from 'components/ApprovalProcess';
// import SubTableGroup from '../SubTableGroup';
// import MainForm from '../MainForm';
import { SubTableGroup } from "../../../container";
import { MainForm } from '../../../container';
import 'bee-datepicker/build/DatePicker.css';
import './index.less';

let titleArr = ["新增", "修改", "详情"];
class AppEdit extends Component {
    constructor(props) {
        super(props);
        this.state = {
            showPopBackVisible: false,  //是否返回列表页的弹出框开关;
            searchId: "",   //单据ID;
            btnFlag: GROBAL_PAGE_STATE.NEW, //页面状态;
            copy: false,   //是否拷贝页面;
            selectFileData: [], 
            filterable: false,
            submit: true,  // 遮罩层判断 的开关;
            approve: true,
            frezee: true,
            export: true,
        }
    }

    //缓存数据
    cacheDataObj={
        oldData:[],
        oldFileData:[],
    }
    // 页面滚动每部分信息; 
    scrollData=[{
        id: "#open1", text: "基本信息", flag: true
    }, {
        id: "#open2", text: "操作信息", flag: true
    }];
    componentWillMount() {
    };
    componentDidMount() {
        // 查询数据字典;
        actions.mainModel.loadDicData(this.props.dicItemList);
        // 查询自定义档案
        actions.mainModel.loadDefDoc(this.props.defDocList);

        const searchObj = queryString.parse(this.props.location.search);
        let { btnFlag: flag, search_id: searchId, copy } = searchObj;
        const btnFlag = Number(flag);
        this.setState({ btnFlag, searchId, copy });
        if (btnFlag && btnFlag > 0) {
            const param = { id: searchId };
            actions.mainModel.queryEditObj(param); // 获取详情页;
        }
    }
    /**
     * 重置和清空
     */
    clearQuery() {
        this.props.form.resetFields();
        actions.mainModel.updateState({ 
            status: "view",
            editFormData:{},
            fmsFcVarietyData:{
                list:[],
                pageIndex: 0,
                pageSize: 25,
                totalPages: 1,
                total: 0
            },
            fmsAttachmentData:{
                list:[],
                pageIndex: 0,
                pageSize: 25,
                totalPages: 1,
                total: 0
            }
        });
    }

    /**
     * 返回上一级弹框提示
     * @param {Number} type 1、取消 2、确定
     * @memberof Order
     */
    async confirmGoBack(type) {
        this.setState({ showPopBackVisible: false });
        if (type === 1) { // 确定
            this.clearQuery();
            actions.routing.replace({ pathname: '/' });
        }
    }

    /**
     * 返回
     * @returns {Promise<void>}
     */
    backFun = async () => {
        const { btnFlag } = this.state;
        if (btnFlag === GROBAL_PAGE_STATE.VIEW) { //判断是否为详情态
            const searchObj = queryString.parse(this.props.location.search);
            let { from } = searchObj;
            switch (from) {
                case undefined:
                    this.clearQuery();
                    actions.routing.replace({ pathname: '/' });
                    break;
                default:
                    window.history.go(-1);
            }
        } else {
            this.setState({ showPopBackVisible: true });
        }
    }
    /**
     *
     * @description 验证子表的数据是否通过，
     * @param {*}  data 子表数据集
     * @returns
     */
    filterListKey = (data) => {
        // 非空校验
         for (const [index, ele] of data.entries()) {
            for (const field in ele) {
                if (data[index][field] && data[index][`_${r"${"}field}Validate`] !== undefined) {
                    data[index][`_${r"${"}field}Validate`] = true;
                }
            }
        }
        // 
        let flag = true;
        for (const [index, rowObj] of data.entries()) {
            for (const key in rowObj) {
                // 默认验证通过
                data[index]['_validate'] = false;
                // 只要一个值为空，验证不通过
                if (key.includes("Validate") && !rowObj[key]) {
                    data[index]['_validate'] = true;
                    flag = false;
                    break
                }
            }
        }
        return { rowData: data, flag }
    }

    /**
     * @param {*} entity 获取主表数据
     * @returns
     */
    filterForm = (entity) => {
        let { btnFlag, copy } = this.state;
        if (copy === 'true') {
            btnFlag = GROBAL_PAGE_STATE.NEW;
        }
        btnFlag = Number(btnFlag)
        if (btnFlag === GROBAL_PAGE_STATE.EDIT) {  //为主表添加编辑信息
            const { editFormData } = this.props;
            if (editFormData && editFormData.id) {
                entity.id = editFormData.id;
                entity.ts = editFormData.ts;
            }
        }
        if (btnFlag === GROBAL_PAGE_STATE.NEW) {
            entity.id = "";
        }
        // 主表日期处理
        const { signDate, startDate, endDate, approveDate,createTime,pkOrgCredit,
            pkCoopOrg, pkBelongDept, pkCustManager, pkCurrency, creditMeasures, pkBelongCoopOrg } = entity;
        entity.signDate = signDate.format("YYYY-MM-DD");
        entity.startDate = startDate.format("YYYY-MM-DD");
        entity.endDate = endDate.format("YYYY-MM-DD");
        entity.approveDate = approveDate.format("YYYY-MM-DD");
        entity.createTime=createTime.format("YYYY-MM-DD");
        // 主表参照特殊处理
        if (pkOrgCredit) {
            let { refpk } = JSON.parse(pkOrgCredit);
            entity.pkOrgCredit = refpk;
        }
        if (pkCoopOrg) {
            let { refpk } = JSON.parse(pkCoopOrg);
            entity.pkCoopOrg = refpk;
        }
        if (pkBelongDept) {
            let { refpk } = JSON.parse(pkBelongDept);
            entity.pkBelongDept = refpk;
        }
        if (pkCustManager) {
            let { refpk } = JSON.parse(pkCustManager);
            entity.pkCustManager = refpk;
        }
        if (pkCurrency) {
            let { refpk } = JSON.parse(pkCurrency);
            entity.pkCurrency = refpk;
        }
        if (pkBelongCoopOrg) {
            let { refpk } = JSON.parse(pkBelongCoopOrg);
            entity.pkBelongCoopOrg = refpk;
        }
        if (creditMeasures) {
            entity.creditMeasures = creditMeasures.toString();
        }

        return entity;
    }

    /**
     *  点击保存的操作
     */
    onClickSave = async function (addFlag, submitFlag) {   
        debugger; 
        let _this = this;
        let entity = {};  // 单据实体对象
        let formData={};  // 单据表单对象
        let { form } = this.props;
        // 主表数据校验
        let formValidate = false;
        form.validateFields((error, value) => {
            if (!error) {
                formData = _this.filterForm(value);
                formValidate = true;
            }
        });
        // 子表数据校验
        const {fmsFcVarietyData, deleteData} = _this.props;
        let _fmsFcVarietyData=deepClone(fmsFcVarietyData);

        // if (_this.oldPlanData.length==0) {
        //     _this.oldPlanData = deepClone(__fmsFcVarietyData.list);
        // }
        // const { rowData:oldPlanRowData, flag:flag1 } = _this.filterListKey(_this.oldPlanData);
        // _queryDetailObj.fmsPlanExtendList = oldPlanRowData;


        // if (_this.oldOtherBudget.length==0) {
        //     _this.oldOtherBudget = deepClone(_queryDetailObj.fmsWdObudgetplanExtendList);
        // }
        // const { rowData:otherBudgetRowData, flag:flag2 } = _this.filterListKey(_this.oldOtherBudget);
        // _queryDetailObj.fmsWdObudgetplanExtendList = otherBudgetRowData;

        //保存到 model;
        actions.mainModel.updateState({
            editFormData:formData,
            // 添加字表对象；
        });
        
        //通过校验后执行保存到后台;
        // if (flag1 && flag2 && formValidate) {
        if(formValidate){
            //装配提交数据对象;
            entity=deepClone(formData);
            //装配子表数据,增加是"I",还是"M";
            let _fmsFcVarietyList = _this.dealChildGrid(
                _fmsFcVarietyData.list,
                deleteData
            );
            // let _fmsPlanExtendList = _this.dealChildGrid(
            //     oldPlanRowData,
            //     delPlanData
            // );
            // 装配子表数据;
            entity.fmsFcVarietyList = _fmsFcVarietyList;
            // 保存操作
            let params = {
                param: entity,
                addFlag: addFlag,
                submitFlag: submitFlag
            };
            //保存并跳转主页面
            await actions.mainModel.adds(params);
            actions.mainModel.updateState({ status: "view" }); // 更新按钮状态
            //清空model中的详情页主子表数据
            this.clearQuery();
        }
    }
    /*
     * 子表的处理
     */
    dealChildGrid = (list, deleteData) => {
        let { btnFlag, copy } = this.state;
        if (copy === 'true') {
            btnFlag = GROBAL_PAGE_STATE.NEW;
        }
        if (btnFlag === GROBAL_PAGE_STATE.NEW) {
            for (let i = 0; i < list.length; i++) {
                list[i].rowState = "I";
                list[i].id = "";
            }
        }
        if (btnFlag === GROBAL_PAGE_STATE.EDIT) {
            for (let i = 0; i < list.length; i++) {
                if (list[i].id) {
                    list[i].rowState = "M"
                } else {
                    list[i].rowState = "I"
                }
            }
            list = list.concat(deleteData)
        }
        return list
    }

    /**
     * @description  流程请求时的loading处理
     * @params type  start/end;
     */
    bpmLoading =(type)=> async()=>{
        actions.mainModel.updateState({
            showLoading: (type=="start")
        })
    }
    /**
     * @description 流程提交/撤回操作的回掉函数；
     * @param  operation: submit/recall/reject ...
     * @param  type: success/error
     */
    bpmCallback= (operation, type) => async (error) => {
        if(type=="error"){
        Error(error.msg);
        }else{ //成功
        let msg="";
        switch (operation) {
            case "submit":
            msg="单据提交成功!";
            break;
            case "recall":
            msg="单据撤回成功!";
            break;
            case "reject":
            msg="单据驳回成功!";
            break;
            default:
            msg="未知操作!"
            break;
        }
        success(msg);
        //刷新页面操作；
        this.initDetailPage();
        }
    }
    /*
    *详情页编辑功能
    */
    editFun = () => {
        this.setState({
            btnFlag: GROBAL_PAGE_STATE.EDIT
        })
    }
    /*
    *详情页复制功能
    */
    copyFun = () => {
        this.setState({
            btnFlag: GROBAL_PAGE_STATE.VIEW
        })
    }
    closeGroupBtn = () => {
        this.setState({
            submit: true,
            approve: true,
            frezee: true
        })
    }
    //右侧 悬浮 子表点击悬浮的回调
    childPosition = (item, title, index) => {
        this.childTabInfo(title, index)
    }
     /** 上一页,下一页 */
    getNextPage = () => {
        console.log("getNextPage")
    };
    getPrePage = () => {
        console.log("getPrePage")
    };
    /** 上一条,下一条 */
    getNextItem = () => {
        console.log("getNextItem")
    };
    getPreItem = () => {
        console.log("getPreItem")
    };
    /** 处理缓存数据的回掉函数 */
    cacheDataCallback = (cacheDataObj) => {
        this.cacheDataObj=cacheDataObj;
    }
    render() {
        // debugger;
        const _this = this;
        const { 
            showLoading, 
            form, 
            appType, 
            option, 
            docOption,
            positionIndex,
            scrollFlag,
        } = _this.props;
        
        const { editFormData,fmsFcVarietyData,fmsAttachmentData} =_this.props;
        this.cacheDataObj['oldData'] = fmsFcVarietyData.list;

        const { showPopBackVisible, btnFlag: flag } = _this.state;
        const btnFlag = Number(flag);
        let approveStatus=editFormData.approveStatus|| 0;
        return (
            <div className='common-detail-wrap'>
                {/* 详情-右侧-定位菜单 */} 
                <PositionScroll 
                    scrollFlag={scrollFlag} 
                    positionIndex={positionIndex} 
                    scrollData={this.scrollData} 
                    open={true} 
                    callBack={this.childPosition} 
                    modelName="mainModel" 
                />
                {/* blockUI loading 加载效果 */}
                <Loading showBackDrop={true} loadingType="line" show={showLoading} fullScreen={true} />
                <Alert
                    show={showPopBackVisible}
                    context="数据未保存，确定离开 ?"
                    confirmFn={() => {
                        _this.confirmGoBack(1)
                    }}
                    cancelFn={() => {
                        _this.confirmGoBack(2)
                    }} />
                {/* 页面遮罩层 */}
                {(!this.state.submit || !this.state.approve || !this.state.frezee) && <div className="shadow-page" onClick={() => this.closeGroupBtn()}></div>}
                {/* Header 部分 */}
                <Header backFn={_this.backFun} back title={titleArr[btnFlag]}>
                    <div className='head-btn-group'>
                        {(btnFlag !== GROBAL_PAGE_STATE.VIEW) &&
                            <div>
                                <Button colors="primary">
                                    <span className="btn-text" onClick={_this.onClickSave.bind(_this, false, false)}>保存</span>
                                </Button>
                                <Button bordered>
                                    <span className="btn-text" onClick={_this.onClickSave.bind(_this, false, true)}>保存提交</span>
                                </Button>
                                <Button bordered>
                                    <span className="btn-text" onClick={_this.onClickSave.bind(_this, true, false)}>保存新增</span>
                                </Button>
                                <Button bordered className="u-button">
                                    <span className="btn-text" onClick={_this.backFun}>取消</span>
                                </Button>
                            </div>}
                        {(btnFlag === GROBAL_PAGE_STATE.VIEW) &&
                            <div>
                                {(approveStatus=="1") && <Button bordered>
                                    <span className="btn-text" onClick={_this.editFun.bind(this)}>修改</span>
                                </Button>}
                                {(approveStatus=="1") && 
                                    <BpmButtonSubmit
                                        className="u-button"
                                        checkedArray={[editFormData]}
                                        funccode="${tb.fLowerTName}"
                                        nodekey="${tb.fLowerTName}"
                                        url={`${r'${GROBAL_BS_HTTP_CTX}'}/${tb.fLowerTName}Bpm/submit`}
                                        onStart={this.bpmLoading('start')}
                                        onEnd={this.bpmLoading('end')}
                                        onSuccess={this.bpmCallback('submit','success')}
                                        onError={this.bpmCallback('submit', 'error')}
                                    >
                                        <Button bordered className="special_btn">
                                            <span className="btn-text">提交</span>
                                        </Button>
                                    </BpmButtonSubmit>
                                }
                                {(approveStatus=="2") && 
                                    <BpmButtonRecall
                                        className="u-button"
                                        checkedArray={[editFormData]}
                                        url={`${r'${GROBAL_BS_HTTP_CTX}'}/${tb.fLowerTName}Bpm/recall`}
                                        onStart={this.bpmLoading('start')}
                                        onEnd={this.bpmLoading('end')}
                                        onSuccess={this.bpmCallback('recall','success')}
                                        onError={this.bpmCallback('recall', 'error')}
                                        >
                                        <Button bordered className="special_btn"> <span className="btn-text">回收</span></Button>
                                    </BpmButtonRecall>
                                }
                                {(approveStatus=="2") && 
                                    <Button bordered className="u-button">
                                        <span className="btn-text" onClick={this.approveFun.bind(this)}>审批</span>
                                    </Button>}
                                {/* 已审批的 */}
                                {/* {(approveStatus=="2") && 
                                    <Button bordered className="u-button">
                                        <span className="btn-text" onClick={this.cancelApprovalFun.bind(this)}>取消审批</span>
                                    </Button>
                                } */}
                                {/* 冻结操作 */}
                                {/* {(approveStatus=="2") && 
                                    <Button bordered className="u-button">
                                        <span className="btn-text" onClick={this.frozenFun.bind(this)}>冻结</span>
                                    </Button>
                                } */}
                                {/* 解冻操作 */}
                                {/* {(approveStatus=="2") && 
                                    <Button bordered className="u-button">
                                        <span className="btn-text" onClick={this.thawFun.bind(this)}>解冻</span>
                                    </Button>
                                } */}
                                <Button bordered>
                                    <span className="btn-text" onClick={_this.copyFun}>复制</span>
                                </Button>
                                <Button bordered onClick={this.getPrePage.bind(this)}><i className="iconfont">&#xe854;</i></Button>
                                <Button bordered onClick={this.getPreItem.bind(this)}><i className="iconfont">&#xe7f2;</i></Button>
                                <Button bordered onClick={this.getNextItem.bind(this)}><i className="iconfont">&#xe7cd;</i></Button>
                                <Button bordered onClick={this.getNextPage.bind(this)}><i className="iconfont">&#xe853;</i></Button>
                            </div>}
                    </div>
                </Header>
                {/* 流程:审批组件- 已提交,详情页展示 */}
                {(approveStatus!=1) && (btnFlag==GROBAL_PAGE_STATE.VIEW) && 
                    <ApprovalProcess 
                        appType={appType} 
                        btnFlag={btnFlag} 
                        billId={editFormData.id}
                        onStart={this.bpmLoading('start')}
                        onEnd={this.bpmLoading('end')}
                    />
                }
                {/** 详情页 主表Form信息 
                   * editFormData 选中行数据/选中的主表数据;
                   * contract 合同信息;
                   */}
                <MainForm 
                       formData={editFormData} 
                       btnFlag={btnFlag} 
                       form={form} 
                       option={option} 
                       docOption={docOption} 
                       copy={this.state.copy} > 
                </MainForm>
                {/* 详情页 子表组件 信息 */}
                <SubTableGroup
                   btnFlag={btnFlag}
                   option={option} 
                   docOption={docOption}
                   cacheDataObj={this.cacheDataObj}
                   cacheDataCallback={this.cacheDataCallback.bind(this)}
                >
                </SubTableGroup>
            </div>
        )
    }
}

export default Form.createForm()(AppEdit);
