/**
 *  SubTableGroup.js 详情页-表格组件(组)
 */
import React, { Component } from "react";
import { actions } from "mirrorx";
import {
  Icon,
  Modal,
  Button,
  Collapse,
  Upload
} from "tinper-bee";
import {
  uuid,
  deepClone,
  Info,
  getPageParam
} from "utils";
import Alert from "components/Alert";
import Grid from "components/Grid";

import FactoryComp from '../App/FactoryComp';

import "bee-complex-grid/build/Grid.css";
import "bee-pagination/build/Pagination.css";
import "bee-datepicker/build/DatePicker.css";
import "./index.less";

class SubTableGroup extends Component {
  constructor(props) {
    super(props);
    this.state = {
      zoom: true,
      titleName: "授信品种",
      activeTableName:"fmsFcVarietyData", // 当前显示的子表;
      showPopAlert: false,    // 删除时弹出框的开关;
      selectCreditData:[],    // 授信列表选中数据;
      collapseState: {
        open: true
      },
    };
  }
  // 生命周期
  componentWillMount() {}
  // 生命周期
  componentDidMount() {}
  // 生命周期: 属性改变监控
  componentWillReceiveProps(newProps) {}
  
  // 切换Tab部分;
  childTabInfo = (titleName,activeTableName)=> {
    this.setState({
      titleName,
      activeTableName   //选中的table
    });
  };
  /**
   *  @description 关闭弹出框
   */ 
  closeModal() {
    actions.mainModel.updateState({
      showModalCover: false
    });
    window.history.go(-1);
  }
  /**
   * @description 删除子表选中的数据
   * @param {Number} type 1、取消 2、确定
   * @memberof Order
   */
  async confirmDel(type) {
    this.setState({ showPopAlert: false });
    if (type === 1) {
      // 确定 
      const { selectCreditData, searchId } = this.state;
      let {cacheDataObj}=this.props;
      let tempData=deepClone(cacheDataObj);
      if (this.clearOldData()) {
        const { status } = await actions.mainModel.delOrderDetail(selectCreditData);
        if (status === "success") {
          actions.mainModel.queryChild({ search_orderId: searchId }); // 获取子表
          // this.oldData = []; //清空用于编辑和添加的缓存数据
          tempData['oldData']=[];
          this.props.cacheDataCallback(tempData)
        }
      }
    }
    this.setState({ showPopAlert: false });
  }
  /**
   * @description 判断选中的行数据中是否有从后端的数据，有则后端删除，没有则前端删除;
   */
  clearOldData = () => {
    const fmsFcVarietyData = deepClone(this.props);
    let { list } = fmsFcVarietyData;
    const { selectCreditData } = this.state;
    for (const elementSelect of selectCreditData) {
      for (const [indexOld, elementOld] of list.entries()) {
        // 判断当前数据是否来自后端，如果是来自后端，后端删除,
        if (elementSelect.id && elementOld.id === elementSelect.id) {
          return true;
        }
        // 判断当前数据是否新增，如果是新增，前端删除
        if (elementSelect.key && elementOld.key === elementSelect.key) {
          list.splice(indexOld, 1);
        }
      }
    }
    // this.oldData = list; //将数据加入缓存
    let {cacheDataObj}=this.props;
    cacheDataObj['oldData']=list;
    this.props.cacheDataCallback(cacheDataObj)
    fmsFcVarietyData.list = list;
    this.setState({ selectCreditData: [] }); //清空选中的数据
    actions.mainModel.updateState({ 
        fmsFcVarietyData
    }); //更新action里的子表数据
    return false;
  };
  /**
   * @description 同步修改后的数据不操作State
   * @param {string} field 字段
   * @param {any} value 值
   * @param {Number} index 位置
   */
  changeAllData(field, value, index, refName){
    // let fmsFcVarietyData=this.state.activeTableName;  //操作的表名称
    let tableData = deepClone(this.props.fmsFcVarietyData);
    let _tempList = tableData.list;
    _tempList[index][field] = value;
    if (field === "pkProds") {
      _tempList[index][field + "Name"] = refName;
    }
    
    if (!_tempList[index]["_checked"]) {
      _tempList[index]["_checked"] = true;
      actions.mainModel.updateState({
        fmsFcVarietyData:tableData
      });
    }
    // _tempList[index]["_checked"] = true;

    let {cacheDataObj}=this.props;
    cacheDataObj['oldData']=deepClone(_tempList);
    this.props.cacheDataCallback(cacheDataObj);
   
    if (field === "creditAmt") {
      this.countCreditAmt(value);
    }
    actions.mainModel.updateState({ 
      fmsFcVarietyData:tableData
    });
  };
  /**
   * 处理验证后的状态
   *
   * @param {string} field 校验字段
   * @param {Object} flag 是否有错误
   * @param {Number} index 位置
   */
  onValidate = (field, flag, index) => {
    //只要是修改过就启用校验
    let {cacheDataObj}=this.props;
    if (cacheDataObj['oldData'].length > index) {
      cacheDataObj['oldData'][index][`_${r"${"}field}Validate`]=flag==null;
      // this.oldData[index][`_${r"${"}field}Validate`] = flag == null;
      this.props.cacheDataCallback(cacheDataObj);
    }
  };
  /**
   * @description 新增行数据
   */
  handleNew(){
    debugger;
    let _this=this;
    let {titleName}=_this.state;
    
    if(titleName=="授信品种"){
      let cacheList=deepClone(_this.props.cacheDataObj.oldData);  //缓存数据
      let activeTableData = deepClone(_this.props.fmsFcVarietyData); 
      let { list } = activeTableData; // 获取 授信品种子表数据
      // 如果是第一次添加，则从 actions 取值
      if (cacheList.length === 0) {
        cacheList = list || [];
      }
      //开始校验
      const { rowData, flag } = this.filterListKey(cacheList);

      if (!flag) {
        activeTableData.list = rowData;
        actions.mainModel.updateState({
          fmsFcVarietyData:activeTableData
        });
        return;
      }
      // 行数据
      let tmp = {
        key: uuid(),
        _edit: true,
        _isNew: true,
        _checked: false,
        pkProds: "", //授信品种
        pkProdsName: "", //授信品种名称
        fundPurpose: "", //资金用途
        ctrlMethod: 1, //控制方式
        creditAmt: "", //授信额度
        curUsedCreditAmt: "", //占用授信额度
        isCycle: 1, //是否可循环
        _pkProdsValidate: false, // detailName默认验证没有通过
        _fundPurposeValidate: false,
        _ctrlMethodValidate: false, 
        _creditAmtValidate: false,
        _curUsedCreditAmtValidate: true,
        _isCycleValidate: false
      };
      cacheList.unshift(tmp); //插入到最前
      //禁用其他checked
      for (let i = 0; i < cacheList.length; i++) {
        if (!cacheList[i]["_isNew"]) {
          cacheList[i]["_checked"] = false;
          cacheList[i]["_status"] = "new";
        }
      }
      //同步状态数据
      let {cacheDataObj}=this.props
      cacheDataObj['oldData']=cacheList;
      this.props.cacheDataCallback(cacheDataObj);

      //保存处理后的数据，并且切换操作态'新增'
      activeTableData.list = deepClone(cacheList);
      this.setState({ selectCreditData: [] }); //清空选中的数据
      
      actions.mainModel.updateState({
        fmsFcVarietyData:activeTableData,
        status: "new",
        rowEditStatus: false
      });
    }
  };
  /**
   * @description 新增附件
   */
  // handlerFileNew = obj => {
  // };
  /**
   *
   * @descripition 验证子表的数据是否通过;
   * @param {*}   data 子表数据集
   * @returns 
   */
    filterListKey = (childData) => {
      const data = this.validateChild(childData);
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
     * @description 处理验证后的状态,子表字段非空校验；通过设置了true；否则false；
     * @param {string} field 校验字段
     * @param {Object} flag 是否有错误
     * @param {Number} index 位置
     */
    validateChild = (data) => {
      for (const [index, ele] of data.entries()) {
          for (const field in ele) {
              if (data[index][field] && data[index][`_${r"${"}field}Validate`] !== undefined) {
                  data[index][`_${r"${"}field}Validate`] = true;
              }
          }
      }
      return data;
  }
  /**
   * @description 子表从其他状态切换到修改状态
   * @param flag  是否为行内操作;
   * @param index 选中行Index;
   */
  onClickUpdate = (index, flag) => {
    // let {titleName}=this.state;
    // if(titleName=="授信品种"){ 
    // }
    let {fmsFcVarietyData, cacheDataObj}=this.props;
    let _fmsFcVarietyData=deepClone(fmsFcVarietyData);
    let { list } = _fmsFcVarietyData; // 获取子表数据
    let tempList = cacheDataObj['oldData']

    // 如果是第一次修改，则从action取值
    if (tempList.length === 0) {
      tempList = list;
    }
    //当前行数据设置编辑态
    if (flag) {
      tempList[index]["_checked"] = false;
      tempList[index]["_status"] = "edit";
      tempList[index]["_edit"] = true;
    } else {
      for (const index in tempList) {
        tempList[index]["_checked"] = false;
        tempList[index]["_status"] = "edit";
        tempList[index]["_edit"] = true;
      }
    }
    //同步状态数据
    cacheDataObj['oldData']= deepClone(tempList);
    this.props.cacheDataCallback(cacheDataObj);
    //保存处理后的数据，并且切换操作态'编辑'
    _fmsFcVarietyData.list = deepClone(tempList);
    this.setState({ selectCreditData: [] }); //清空选中的数据
    actions.mainModel.updateState({
      fmsFcVarietyData:_fmsFcVarietyData,
      status: "edit",
      rowEditStatus: false
    });
  };
  /**
   *  @description 子表删除操作--行内删除；
   */
  handleDeleteItem = index => {
    const {fmsFcVarietyData} = deepClone(this.props);
    let list = deepClone(fmsFcVarietyData.list); // 获取子表数据
    let { deleteData } = this.props;
    let arr = list.splice(index, 1);
    deleteData = this.dealDeleteItem(arr);
    fmsFcVarietyData.list = list;
    actions.mainModel.updateState({
      fmsFcVarietyData,
      status: "edit",
      rowEditStatus: false,
      deleteData
    });
  };
  /**
   *  @description  删除子表数据行的处理
   *  @arr 要处理的数组
   */
  dealDeleteItem = arr => {
    for (let i = 0; i < arr.length; i++) {
      arr[i].rowState = "D";
    }
    return arr;
  };

  /**
   *  @description 子表删除操作--批量删除
   */
  handleDeleteBatch = () => {
    const { selectCreditData } = this.state;
    if (selectCreditData.length === 0) {
      Info("请勾选数据后再删除");
    } else {
      this.setState({ showPopAlert: true });
    }
  };

  /**
   * @description 这种删除，直接调用删除接口执行删除， 如果有对应的字表删除接口就可以这么写；
   * @param {Number} type 1、取消 2、确定
   * @memberof Order
   */
  // async confirmDel(type) {
  //   let _this=this;
  //   this.setState({ showPopAlert: false });
  //   let {cacheDataObj}=this.props;
  //   if (type === 1) {
  //     // 确定
  //     const { selectCreditData, searchId } = this.state;
  //     if (this.clearOldData()) {
  //       const { status } = await actions.mainModel.delOrderDetail(selectCreditData);
  //       if (status === "success") {
  //         actions.mainModel.queryChild({ search_orderId: searchId }); // 获取子表
  //         cacheDataObj['oldData'] = []; //清空用于编辑和添加的缓存数据
  //         _this.props.cacheDataCallback(cacheDataObj);
  //       }
  //     }
  //   }
  //   this.setState({ showPopAlert: false });
  // }
  /**
   *  @description 常规删除操作 不调用后台接口： 而是在点击删除后再前台执行删除，
   *               改变tempDetailObj的list，当点击保存后实现删除；
   *  @params      1 确认删除 2.取消删除
   */
  async confirmDel(type) {
    let { titleName }=this.state;
    if(titleName=="授信品种" && type==1){
      this.clearOldData();
    }else if(titleName=="附件信息" && type==1){
      // 附件部分删除；
    }else{
      console.log("选择错误!");
    }
    this.setState({ 
      showPopAlert: false, 
    });
  }

  /**
   * @description 判断选中的行数据中是否有从后端的数据，有则后端删除，没有则前端删除;
   */
  clearOldData = () => {
    const {fmsFcVarietyData} = deepClone(this.props);
    let { list } = fmsFcVarietyData;
    const { selectCreditData } = this.state;
    let {deleteData} = this.props;
    for (const elementSelect of selectCreditData) {
      for (const [indexOld, elementOld] of list.entries()) {
        // 判断当前数据是否来自后端，如果是来自后端，后端删除,
        if (elementSelect.id && elementOld.id === elementSelect.id) {
          elementOld.rowState="D";
          deleteData.push(elementOld);
          list.splice(indexOld,1);
        }
        // 判断当前数据是否新增，如果是新增，前端删除
        if (elementSelect.key && elementOld.key === elementSelect.key) {
          list.splice(indexOld, 1);
        }
      }
    }
    let {cacheDataObj}=this.props;
    cacheDataObj['oldData'] = list; //将数据加入缓存
    this.props.cacheDataCallback(cacheDataObj);
    fmsFcVarietyData.list = list;
    this.setState({ selectCreditData: [] }); //清空选中的数据
    actions.mainModel.updateState({
      fmsFcVarietyData,
    }); //更新action里的子表数据
    return false;
  };

  /**
   * @param {Number} pageIndex 指定页数
   */
  freshData = pageIndex => {
    this.onPageSelect(pageIndex, 0);
  };

  /**
   * @param {Number} index 分页页数
   * @param {Number} value 分页条数
   */
  onDataNumSelect = (index, value) => {
    this.onPageSelect(value, 1);
  };

  /**
   * @description 分页操作中的
   * @param {Number} value pageIndex 或者 pageSize
   * @param {Number} type type 为0标识为 pageIndex,为1标识 pageSize
   */
  onPageSelect = (value, type) => {
    const { fmsFcVarietyData, orderRow } = this.props;
    const { pageIndex, pageSize } = getPageParam(value, type, fmsFcVarietyData);
    const { id: search_orderId } = orderRow;
    const temp = { search_orderId, pageSize, pageIndex };
    actions.mainModel.queryChild(temp);
  };

  /**
   * @description 点击子表中多选框的回调函数;
   * @param {object} selectData 选择的数据
   * @param {object} record 当前行数据，空为点击全选
   * @param {number} index 当前索引
   */
  getSelectedDataFunc = (selectData, record, index) => {
    let { fmsFcVarietyData } = this.props;
    let { titleName}=this.state;
    if(titleName=="授信品种"){
      this.setState({ selectCreditData:selectData});
      let _list = deepClone(fmsFcVarietyData.list);
      //同步list数据状态
      if (index != undefined) {
          _list[index]['_checked'] = !_list[index]['_checked'];
      } else {//点击了全选
        if (selectData.length > 0) {//全选
          _list.map(item => {
              if (!item['_disabled']) {
                  item['_checked'] = true
              }
          });
        } else {//反选
          _list.map(item => {
              if (!item['_disabled']) {
                  item['_checked'] = false
              }
          });
        }
      }
      fmsFcVarietyData.list = _list;
    }else if(titleName=="附件信息"){
      // 处理附件选择；
    }
    actions.mainModel.updateState({
        fmsFcVarietyData
    });
  }
  /**
   *  金额单独处理的逻辑;
   */
  countCreditAmt = (value) => {
    // let { orderRow } = this.props;
    // orderRow = deepClone(orderRow);
    // let _sourseData = this.oldData;
    // let sum = 0;
    // _sourseData.map(function (item) {
    //     sum += Number(item.creditAmt)
    // })
    // console.log(sum);
    // orderRow.totalCreditAmt = sum.toFixed(2);
    // actions.mainModel.updateState({ orderRow: orderRow });
  }

  render() {
    const _this = this;
    const {
      btnFlag,
      showModalCover,
      filterable,
      fmsFcVarietyData //授信品种对象;
    } = _this.props;
    const { zoom, showPopAlert } = _this.state;
    const rowEditStatus = btnFlag === 2 ? true : false;
    let btnForbid = fmsFcVarietyData.list.length > 0 ? false : true;
    // 授信品种-Grid 列头;
    let detailColumn = [
      {
        title: "授信品种",
        dataIndex: "pkProds",
        key: "pkProds",
        width: 150,
        className: "must",
        render: (text, record, index) => {
          return (
            <FactoryComp
              type="pkProds" //性别业务组件类型
              field="pkProds" //修改的字段
              index={index} //字段的行号
              required={true} //必输项
              record={record} //记录集用于多字段处理
              onChange={this.changeAllData.bind(this)} //回调函数
              onValidate={this.onValidate} //校验的回调
            />
          );
        }
      },
      {
        title: "资金用途",
        dataIndex: "fundPurpose",
        key: "fundPurpose",
        width: 150,
        className: "must",
        render: (text, record, index) => {
          return (
            <FactoryComp
              type="fundPurpose" //物料型号业务组件类型
              value={text} //初始化值
              field="fundPurpose" //修改的字段
              index={index} //字段的行号
              required={true} //必输项
              record={record} //记录集用于多字段处理
              onChange={this.changeAllData.bind(this)} //回调函数
              docOption={this.props.docOption}
              // onValidate={this.onValidate}//校验的回调
            />
          );
        }
      },
      {
        title: "控制方式",
        dataIndex: "ctrlMethod",
        key: "ctrlMethod",
        width: 150,
        className: "must",
        render: (text, record, index) => {
          return (
            <FactoryComp
              type="ctrlMethod" //物料数量业务组件类型
              value={text} //初始化值
              field="ctrlMethod" //修改的字段
              index={index} //字段的行号
              required={true} //必输项
              record={record} //记录集用于多字段处理
              onChange={this.changeAllData.bind(this)} //回调函数
            />
          );
        }
      },
      {
        title: "授信额度",
        dataIndex: "creditAmt",
        key: "creditAmt",
        width: 150,
        className: "must",
        sumCol: true,
        render: (text, record, index) => {
          return (
            <FactoryComp
              type="creditAmt" //物料数量业务组件类型
              value={text} //初始化值
              field="creditAmt" //修改的字段
              index={index} //字段的行号
              required={true} //必输项
              record={record} //记录集用于多字段处理
              onChange={this.changeAllData.bind(this)} //回调函数
            />
          );
        }
      },
      {
        title: "本期已用授信额度",
        dataIndex: "curUsedCreditAmt",
        key: "curUsedCreditAmt",
        width: 150,
        sumCol: true,
        className: "must"
      },
      {
        title: "是否可循环",
        dataIndex: "isCycle",
        key: "isCycle",
        width: 150,
        className: "must",
        render: (text, record, index) => {
          return (
            <FactoryComp
              type="isCycle" //物料数量业务组件类型
              value={text} //初始化值
              field="isCycle" //修改的字段
              index={index} //字段的行号
              required={true} //必输项
              record={record} //记录集用于多字段处理
              onChange={this.changeAllData.bind(this)} //回调函数
              // onValidate={this.onValidate}//校验的回调
            />
          );
        }
      },
      {
        title: "操作",
        dataIndex: "operate",
        key: "operate",
        width: 120,
        fixed: "right",
        render: (text, record, index) => {
          let {btnFlag}=this.props;
          if(btnFlag==2){
            return (<div></div>)
          }else{
            return (
              <div className="operation-btn">
                <a
                  className="operation-item"
                  href="javascript:;"
                  onClick={this.handleNew.bind(this)}
                >增行</a>
                <a
                  className="operation-item"
                  href="javascript:;"
                  onClick={this.onClickUpdate.bind(this, index, true)}
                >修改</a>
                <a
                  className="operation-item"
                  href="javascript:;"
                  onClick={this.handleDeleteItem.bind(this, index)}
                >
                  删行
                </a>
              </div>
            );
          }
        }
      }
    ];

    // 上传附件部分;
    const draggerProps = {
      name: "file",
      multiple: true,
      showUploadList: false,
      action: "/upload.do",
      onChange(info) {
        const status = info.file.status;
        if (status !== "uploading") {
          _this.handlerFileNew(info.file);
        }
        if (status === "done") {
          console.log(`${r"${"}info.file.name} file uploaded successfully.`);
        } else if (status === "error") {
          console.log(`${r"${"}info.file.name} file upload failed.`);
        }
      }
    };

    //分页对象
    const paginationObj = {
      // 分页
      activePage: 1, //当前页
      total: 25, //总条数
      items: 25
    };

    return (
      <div className={zoom ? "" : "child-wrapper-meng"}>
        {/* tab 部分 */}
        <div className="child-tab-title">
          <div className="child-tab-back">
            <Icon
              type={
                this.state.collapseState.open
                  ? "uf-triangle-down"
                  : "uf-triangle-up"
              }
              onClick={() => {
                this.setState({
                  collapseState: { open: !this.state.collapseState.open }
                });
              }}
            />
          </div>
          <div className="childTitle">
            <span
              className={`titleName ${r"${"}this.state.titleName} === "授信品种" ? "active" : "" }`}
              onClick={this.childTabInfo.bind(this, "授信品种","fmsFcVarietyData")}
            >
              授信品种
            </span>
            <span className="line" />
            <span
              className={`titleName ${r"${"}this.state.titleName} === "附件信息" ? "active" : "" }`}
              onClick={this.childTabInfo.bind(this, "附件信息","fmsAttachmentData")}
            >
              附件信息
            </span>
          </div>
          <div className="btn-group">
            <span style={{ display: btnFlag != 2 ? "inline-flex" : "none" }}>
              <Button
                style={{
                  display:
                    this.state.titleName === "授信品种" ? "block" : "none"
                }}
                shape="border"
                onClick={_this.handleNew.bind(_this)}
              >
                <span className="btn-text">增行</span>
              </Button>
              <Button
                style={{
                  display:
                    this.state.titleName === "授信品种" ? "block" : "none"
                }}
                shape="border"
                disabled={btnForbid}
                onClick={this.handleDeleteBatch}
              >
                <span className="btn-text">删行</span>
              </Button>
              <Button
                style={{
                  display:
                    this.state.titleName === "附件信息" ? "block" : "none"
                }}
                shape="border"
                onClick={this.upLoadFile}
              >
                <span className="btn-text">上传</span>
              </Button>
              <Button
                style={{
                  display:
                    this.state.titleName === "附件信息" ? "block" : "none"
                }}
                shape="border"
                onClick={this.upLoadFile}
              >
                <span className="btn-text">删行</span>
              </Button>
              <Button
                shape="border"
                onClick={() => {
                  this.setState({ zoom: !zoom });
                }}
              >
                <Icon type={zoom ? "uf-maxmize" : "uf-minimize"} />
              </Button>
            </span>
            <span style={{ display: btnFlag === 2 ? "inline-flex" : "none" }}>
              <Button
                style={{
                  display:
                    this.state.titleName === "附件信息" ? "block" : "none"
                }}
                className="ml8"
                size="sm"
                colors="primary"
                onClick={this.upLoadFile}
              >
                <span className="btn-text">下载</span>
              </Button>
            </span>
            <Alert
              show={showPopAlert}
              context="新增、修改数据未保存将无法生效，确定删除这些记录吗 ?"
              confirmFn={() => {
                _this.confirmDel(1);
              }}
              cancelFn={() => {
                _this.confirmDel(2);
              }}
            />
          </div>
        </div>
        {/* panel 部分 */}
        <Collapse in={this.state.collapseState.open}>
          <div>
            <div
              className="child-table"
              style={{  display: this.state.titleName === "授信品种" ? "block" : "none" }}
            >
              <Grid
                scroll={{ y: 350 }}
                ref={"grid"}
                data={fmsFcVarietyData.list}
                rowKey={(r, i) => (r.id ? r.id : r.key)}
                columns={detailColumn}
                columnFilterAble={true}
                showHeaderMenu={true}
                dragborder={rowEditStatus}
                draggable={rowEditStatus}
                syncHover={rowEditStatus}
                showFilterMenu={true}
                getSelectedDataFunc={this.getSelectedDataFunc}
                emptyText={() => (
                  <Icon style={{ fontSize: "60px" }} type="uf-nodata" />
                )}
                // 分页
                paginationObj={paginationObj}
                canSum={true}
              />
            </div>
            <div
              className="child-table"
              style={{
                display: this.state.titleName === "附件信息" ? "block" : "none"
              }}
            >
              {/* <Grid
                ref={el => (this.grid = el)}
                data={.fileList}
                rowKey={(r, i) => (r.id ? r.id : r.key)}
                columns={this.fileColumn}
                columnFilterAble={true}
                dragborder={rowEditStatus}
                syncHover={rowEditStatus}
                draggable={rowEditStatus}
                showFilterMenu={true}
                getSelectedDataFunc={this.getSelectedDataFunc}
                emptyText={() => (
                  <Icon style={{ fontSize: "60px" }} type="uf-nodata" />
                )}
                // 分页
                paginationObj={paginationObj}
              /> */}
            </div>
          </div>
        </Collapse>
        {/* 弹出框部分 */}
        <Modal show={showModalCover} onHide={this.close}>
          <Modal.Header>
            <Modal.Title>警告</Modal.Title>
          </Modal.Header>

          <Modal.Body>未获取到单据信息</Modal.Body>

          <Modal.Footer>
            <Button onClick={this.closeModal}>是</Button>
          </Modal.Footer>
        </Modal>
      </div>
    );
  }
}

export default SubTableGroup;
