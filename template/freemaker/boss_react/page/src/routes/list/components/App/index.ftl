/**
 *  AppList 组件(列表页)
 */
import React, { Component } from "react";
import { actions } from "mirrorx";
import { Loading, Button, Modal, Icon, Table } from "tinper-bee";
import Grid from "components/Grid";
import Alert from "components/Alert";
import Header from "components/Header";
import { BpmWrap, BpmButtonSubmit, BpmButtonRecall } from "yyuap-bpm";
import SearchArea from "../SearchArea/index";
import { deepClone, success, Error,dicFormatter} from "utils";
import imgURL from "static/images/zhuling05@2x.png";

export default class AppList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      delModalVisible: false,  // 删除模态框开关;
      showApproveModel: false, //联查审批弹出框 开关;
      showModalDetail: false,  //联查授信弹出框 开关;
      filterable: false,
      record: {},
      billId: "",      // 选中的单据id;
      selectArr: [],   // 复选框选择的数据;
      selectRecord:{}, // 选中的删除对象;
      Modaldata: [],   // 授信弹出框显示的列表数据;
      deleteIds: "",   // 删除Id;
      submit: true,    // 处理按钮区域相应按钮 显示/隐藏
      approve: true,
      frezee: true,
      export: true
    };
  }
  
  // 生命周期-在渲染前调用
  componentWillMount() {}
  // 生命周期-在渲染后调用
  componentDidMount() {
    // 查询数据字典
    actions.mainModel.loadDicData(this.props.dicItemList);
    // 查询自定义档案
    actions.mainModel.loadDefDoc(this.props.defDocList);
  }

  /**
   *  加载表格数据的方法
   */
  loadData =(queryParam)=>{
    actions.mainModel.loadList(queryParam);
  }
  
  /**
   * @description 新增操作
   */
  addFun = () => {
    this.onClickAddEditView(GROBAL_PAGE_STATE.NEW);
  };

  /**
   * @description 删除操作 (批量删除列数据)
   */
  deleteFun = () => {
    this.setState({ delModalVisible: true });
  };
  
  /**
   * @description 审批操作
   */
  auditFun = () => {
    console.log("auditFun");
  };

  /**
   * @description 取消审批操作
   */
  cancelApprovalFun = () => {
    console.log("cancelApprovalFun");
  };

  /**
   * @description 解冻操作
   */
  frozenFun = () => {
    console.log("frozenFun");
  };
 
  /**
   * @description 解冻操作
   */
  thawFun = () => {
    console.log("thawFun");
  };

  /**
   * @description 导入操作
   */
  importFun = () => {
    // todo 根据业务需求加
    console.log(importFun);
  };

  /**
   * @description 导出操作
   */
  exportFun = () => {
    this.grid.exportExcel();
  };

  /**
   * @description 刷新操作
   */
  refreshFun = () => {
    const { listQueryParam} = this.props;
    this.grid.refreshData(listQueryParam);
  };

  // 列表中点击删除弹出确认窗口
  rowDeleteFun=(record)=>{
    this.setState({ 
      delModalVisible: true,
      selectRecord:record 
    });
  }

  /**
   * @description 点击弹出框的确认，删除数据库的数据;
   * @param {Number} status  1:确定删除 2:取消删除
   */
  onConfirmDel(status) {
    let param = {
      idList: []
    };

    let {selectRecord}=this.state;
    let selectArr=this.grid.getSelectedAllList(); //从表格获取选中的数据数组;
    //点击行内删除；
    if(JSON.stringify(selectRecord)!="{}"){
      param.idList.push(selectRecord.id)
    }
    // 点击批量删除；
    if (selectArr && selectArr.length) {
      let len=selectArr.length;
      for (let i = 0; i < len; i++) {
        param.idList.push(selectArr[i].id);
      }
    }

    this.setState({ delModalVisible: false });
    if (status === 1) {
      // 主表删除操作
      actions.mainModel.delListData(param);
    }
    this.setState({
      selectRecord:{},
    })
  }

  /**
   * @description 通过btnFlag判断用户是添加、修改和详情操作
   * @param {Number} btnFlag GROBAL_PAGE_STATE.NEW: 新增
   * @param {Number} btnFlag GROBAL_PAGE_STATE.EDIT:修改
   * @param {Number} btnFlag GROBAL_PAGE_STATE.VIEW:详情
   */
  onClickAddEditView = (btnFlag, item) => {
    let id = "";
    if (btnFlag === GROBAL_PAGE_STATE.NEW) {
      id = "";
    } else {
      id = item.id;
    }
    this.gotoDetail(id, btnFlag, false);
  };

  /**
   * @description 点击复制按钮操作; 
   * @param item  选中的数据Id;
   */
  copyItem = item => {
    let btnFlag = GROBAL_PAGE_STATE.EDIT,
      id = item.id;
    this.gotoDetail(id, btnFlag, true);
  };
  
  /**
   * @description  流程请求时的loading处理
   * @params type  start/end;
   */
  bpmLoading = type => async () => {
    actions.mainModel.updateState({
      showLoading: type == "start"
    });
  };

  /**
   * @description 流程提交/撤回操作的回掉函数；
   * @param  operation: submit/recall/reject ...
   * @param  type: success/error
   */
  bpmCallback = (operation, type) => async error => {
    if (type == "error") {
      Error(error.msg);
    } else {
      //成功
      let msg = "";
      switch (operation) {
        case "submit":
          msg = "单据提交成功!";
          break;
        case "recall":
          msg = "单据撤回成功!";
          break;
        default:
          msg = "未知操作!";
          break;
      }
      success(msg);
      //刷新页面操作；
      this.refreshFun();
    }
  };

  /**
   *  判断按钮是否可以 提交/回撤;
   */
  handleBpmState = (list, selectIndex) => {
    let resObj = {
      submitForbid: true,
      recallForbid: true
    };
    if (list.length) {
      let bpmState = list[selectIndex]["bpmState"];
      let submitForbid = !!bpmState,
        recallForbid = bpmState != 1;
      resObj = {
        submitForbid,
        recallForbid
      };
    }

    return resObj;
  };

  /** 联查审批 显示弹出框*/
  checkApprove(record) {
    let { id = "" } = record;
    this.setState({
      showApproveModel: true, // 显示弹出框
      billId: id // 选中的单据Id
    });
  }

  /**
   * 联查审批 隐藏 取消选中;
   */
  closeApproveModal = str => {
    this.setState({
      showApproveModel: false,
      billId: ""
    });
  };

  /**
   * @description 联查授信明细
   */
  checkDetail = () => {
    this.setState({
      showModalDetail: true
    });
  };

  /**
   * @description 根据URL跳转至详情页;
   * @param {string} id 主表id
   * @param {Number} btnFlag 页面状态 0:新增，1:修改，2:详情
   * @param {boolean} 是否包含复制操作;
   */
  gotoDetail = (id, btnFlag, copy) => {
    actions.routing.push({
      pathname: "edit",
      search: `?search_id=${r"${"}id}&btnFlag=${r"${"}btnFlag}&copy=${r"${"}copy}`
    });
  };

  /**
   *  @description 弹出授信明细信息的数据列
   */
  Modalcolumns = [
    {
      title: "授信品种",
      dataIndex: "pkProds",
      key: "pkProds",
      width: 200
    },
    {
      title: "资金用途",
      dataIndex: "pundPurpose",
      key: "pundPurpose",
      width: 200
    },
    {
      title: "控制方式",
      dataIndex: "ctrlMethod",
      key: "ctrlMethod",
      width: 200
    },
    {
      title: "授信额度",
      dataIndex: "creditAmt",
      key: "creditAmt",
      width: 200
    },
    {
      title: "期初已用授信额度",
      dataIndex: "initUsedCreditAmt",
      key: "initUsedCreditAmt",
      width: 200
    },
    {
      title: "本期已用授信额度",
      dataIndex: "curUsedCreditAmt",
      key: "curUsedCreditAmt",
      width: 200
    },
    {
      title: "是否可循环",
      dataIndex: "isCycle",
      key: "isCycle",
      width: 200
    }
  ];

  /**
   *  @description 显示隐藏联查审批的弹出框
   */
  closeApproveModal = () => {
    this.setState({
      showApproveModel: false,
      billId: ""
    });
  };
  /**
   *  @description 关闭联查授信的弹出框;
   */
  showClose = () => {
    this.setState({ showModalDetail: false });
  };
  /**
   * @description 处理列表页,右肩按钮 去按钮下拉后无法收回的问题;
   */
  closeGroupBtn = () => {
    debugger;
    this.setState({ 
      submit: true,
      export: true,
      approve: true,
      frezee: true 
    });
  };

  render() {
    const _this = this;
    const { showLoading, option, docOption } = _this.props;
    const { listQueryParam:queryParam, listGridData:gridData } = _this.props;
    const { pageIndex, total, totalPages } = gridData;
    const {
      delModalVisible,
      showApproveModel,
      Modaldata,
      showModalDetail,
      selectArr,
      billId
    } = _this.state;
    // const selectArr=this.grid.getSelectedAllList();
    //grid 分页对象;
    const paginationObj = {
      activePage: pageIndex, //当前页
      total, //总条数
      items: totalPages,
    };
    //grid 排序对象-排序属性设置
    const sortObj = {
      mode: "multiple",
      backSource: true,
    };

    /**
     * @description 主表的数据列
     */
		let mainColumn = [
			<#list tb.columns as item>
					{
							title: <#if (item.remarks)!="">"${item.remarks}"<#else>"${item.fLowerColName}"</#if>,
							dataIndex: "${item.fLowerColName}",
							key: "${item.fLowerColName}",
							width: 160,
							filterType: "text",
							filterDropdownType: "string",
							filterDropdown: "show",
							sorter: (a, b) => a.c - b.c,
							//render: (text, record, index) => {
							//    return(<span>{this.formatterColum(record.creditState,'fund_creditgrant_state')}</span>)
							//}
					},
			</#list>
			{
			  title: "操作",
			  dataIndex: "operate",
			  key: "operate",
			  width: 270,
			  fixed: "right",
			  render: (text, record, index) => {
			    return (
			      <div className="operation-btn">
			        <a
			          className="operation-item"
			          href="javascript:;"
			          onClick={this.onClickAddEditView.bind(this,GROBAL_PAGE_STATE.EDIT, record)}>
			          修改
			        </a>
			        <a className="operation-item" href="javascript:;">
			          提交
			        </a>
			        <a className="operation-item" 
							   href="javascript:;"
			           onClick={this.rowDeleteFun.bind(this, record)}> 
			          删除
			        </a>
			        <a className="operation-item" href="javascript:;">
			          收回
			        </a>
			        <a
			          className="operation-item"
			          href="javascript:;"
			          onClick={this.copyItem.bind(this, record)}>
			          复制
			        </a>
			        {record.approveStatus != "1" && (
			          <a className="operation-item"
			             href="javascript:;"
			             onClick={this.checkApprove.bind(this, record)}>
			             联查审批
			          </a>
			        )}
			        <a
			          className="operation-item"
			          href="javascript:;"
			          onClick={this.checkDetail.bind(this)}>
			          联查授信明细
			        </a>
			      </div>
			    );
			  }
			}
		];
    
    return (
      <div className="temp-demo-manage">
        <Loading
          loadingType="line"
          showBackDrop={true}
          show={showLoading}
          fullScreen={true}
        />
        {/* 遮罩层，有下拉按钮的时候添加 */}
        {(!this.state.export ||
          !this.state.submit ||
          !this.state.approve ||
          !this.state.frezee) && (
          <div className="shadow-page" onClick={() => this.closeGroupBtn()} />
        )}
        {/* header 部分*/}
        <Header title="融资授信管理" titleIcon={imgURL}>
          <div className="header-btn-group">
            <Button colors="primary" onClick={_this.addFun.bind(this)}>
              <span className="btn-text">新增</span>
            </Button>
            {/* 提交/撤回 */}
            <div className="list-select-btn ml8">
              <BpmButtonSubmit
                checkedArray={selectArr}
                funccode="${tb.fLowerTName}"
                nodekey="${tb.fLowerTName}"
                url={`${r'${GROBAL_BS_HTTP_CTX}'}/${tb.fLowerTName}/submit`}
                // urlAssignSubmit=${r'${GROBAL_BS_HTTP_CTX}'}/purchase_order/assignSubmit`}
                onStart={this.bpmLoading("start")}
                onEnd={this.bpmLoading("end")}
                onSuccess={this.bpmCallback("submit", "success")}
                onError={this.bpmCallback("submit", "error")}
              >
                <Button bordered> 提交 </Button>
              </BpmButtonSubmit>
              <span
                className="select-arrow"
                onClick={() => this.setState({ submit: !this.state.submit })}
              >
                {this.state.submit && <i className="iconfont">&#xe7ce;</i>}
                {!this.state.submit && <i className="iconfont">&#xe7cb;</i>}
              </span>
              {!this.state.submit && (
                <div className="group-btn">
                  <BpmButtonRecall
                    checkedArray={selectArr}
                    url={`${r'${GROBAL_BS_HTTP_CTX}'}/${tb.fLowerTName}/recall`}
                    onStart={this.bpmLoading("start")}
                    onEnd={this.bpmLoading("end")}
                    onSuccess={this.bpmCallback("recall", "success")}
                    onError={this.bpmCallback("recall", "error")}
                  >
                      <Button bordered> 收回 </Button>
                  </BpmButtonRecall>
                </div>
              )}
            </div>
            {/* 审批/取消审批 */}
            <div className="list-select-btn ml8">
              <Button bordered onClick={this.auditFun.bind(this)}>
                <span className="btn-text">审批</span>
              </Button>
              <span
                className="select-arrow"
                onClick={() => this.setState({ approve: !this.state.approve })}
              >
                {this.state.approve && <i className="iconfont">&#xe7ce;</i>}
                {!this.state.approve && <i className="iconfont">&#xe7cb;</i>}
              </span>
              {!this.state.approve && (
                <div className="group-btn">
                  <Button bordered onClick={this.cancelApprovalFun.bind(this)}>
                    取消审批
                  </Button>
                </div>
              )}
            </div>
            {/* 冻结/解冻 */}
            <div className="list-select-btn ml8">
              <Button bordered onClick={this.frozenFun.bind(this)}>
                <span className="btn-text">冻结</span>
              </Button>
              <span
                className="select-arrow"
                onClick={() => this.setState({ frezee: !this.state.frezee })}
              >
                {this.state.frezee && <i className="iconfont">&#xe7ce;</i>}
                {!this.state.frezee && <i className="iconfont">&#xe7cb;</i>}
              </span>
              {!this.state.frezee && (
                <div className="group-btn">
                  <Button bordered onClick={this.thawFun.bind(this)}>
                    解冻
                  </Button>
                </div>
              )}
            </div>
            {/* 删除 */}
            <Button bordered onClick={_this.deleteFun.bind(this)}>
              <span className="btn-text">删除</span>
            </Button>
            <Alert
              show={delModalVisible}
              context="是否要删除 ?"
              confirmFn={() => this.onConfirmDel(1)}
              cancelFn={() => this.onConfirmDel(2)}
            />
            {/* 导入/导出 */}
            <div className="list-select-btn ml8">
              <Button bordered onClick={_this.exportFun.bind(this)}>
                <span className="btn-text">导入</span>
              </Button>
              <span
                className="select-arrow"
                onClick={() => this.setState({ export: !this.state.export })}
              >
                {this.state.export && <i className="iconfont">&#xe7ce;</i>}
                {!this.state.export && <i className="iconfont">&#xe7cb;</i>}
              </span>
              {!this.state.export && (
                <div className="group-btn">
                  <Button bordered onClick={_this.importFun.bind(this)}>
                    导出
                  </Button>
                </div>
              )}
            </div>
            {/* 刷新*/}
            <Button bordered onClick={this.refreshFun.bind(this)}>
              <i className="iconfont">&#xe7e2;</i>
            </Button>
          </div>
        </Header>
        {/* 搜索区域 */}
        <SearchArea
          queryParam={queryParam}
          loadData={this.loadData}
          option={option}
          docOption={docOption}
        />
        {/* 列表区域 */}
        <div className="gird-parent">
          <Grid
            ref={el => (this.grid = el)}
            data={gridData.list}
            queryParam={queryParam}  //查询参数对象;
            loadData={this.loadData} 
            showFilterMenu={true} //是否显示行过滤菜单
            filterable={false} //是否开启过滤数据功能
            rowKey={(r, i) => i}
            columns={mainColumn}
            dragborder={true}
            afterRowFilter={_this.afterRowFilter} //控制栏位的显示/隐藏
            sort={sortObj} //排序属性设置
            // rowClassName={(record, index, indent) => {
            //     return selectIndex === index ? "selected" : "";
            // }}

            // 分页
            paginationObj={paginationObj}
          />
        </div>
        {/* 联查审批 */}
        <Modal
          show={showApproveModel}
          onHide={this.closeApproveModal.bind(this)}
          size={"xlg"}
        >
          <Modal.Body>
            <div className="model-title">
              <span className="title-name">联查审批</span>
              <Icon
                type="uf-close"
                onClick={this.closeApproveModal.bind(this)}
              />
            </div>
            <BpmWrap id={billId} />
          </Modal.Body>
        </Modal>
        {/* 联查授信明细 */}
        <Modal
          show={showModalDetail}
          onHide={this.showClose.bind(this)}
          size={"xlg"}
        >
          <Modal.Header>
            <Modal.Title>
              <span className="left-name">联查授信明细</span>
              <i className="iconfont">&#xe7c3;</i>
              <i className="iconfont" onClick={this.showClose}>
                &#xeb6a;
              </i>
            </Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <Table columns={this.Modalcolumns} data={Modaldata} />
          </Modal.Body>
        </Modal>
      </div>
    );
  }
}
