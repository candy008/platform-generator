import { actions } from "mirrorx";
// 引入services，如不需要接口请求可不写
import * as commonapi from "utils/commonapi";
import * as api from "./service.js";
// 接口返回数据公共处理方法，根据具体需要
import { processData, deepAssign, structureObj, initStateObj, Error,deepClone } from "utils";

/**
 *  btnFlag 为按钮状态, 0表示新增、1表示编辑，2表示查看详情 3提交;
 *  新增表格为空,修改需要将行数据带上并显示在卡片页面, 查看详情携带行数据但是表格不可编辑;
 */
export default {
    // store 中的数据模型作用域;
    name: "mainModel",
    // 设置当前 Model 所需的初始化 state
    initialState: {
        //列表页 查询条件对象
        listQueryParam: {       //queryParam
            pageParams: {
                pageIndex: 0,
                pageSize: 10,
            },
            sortMap: [],
            whereParams: [],
        },
        //列表页 查询结果对象
        listGridData: {    //queryObj
            list: [],
            pageIndex: 0,
            pageSize: 25,
            totalPages:0,
            total: 0
        },
        //详情页-查询条件对象
        editQueryParam:{
            id:"",
        },
        //详情页-form表单数据
        editFormData:{},
        //详情页-子表-授信品种
        fmsFcVarietyData:{
            queryParam: {   
                pageParams: {
                    pageIndex: 0,
                    pageSize: 10,
                },
                sortMap: [],
                whereParams: [],
            },
            list: [],
            pageIndex: 0,
            pageSize: 25,
            totalPages: 1,
            total: 0
        },
        //详情页-子表-附件
        fmsAttachmentData:{
            queryParam: {   
                pageParams: {
                    pageIndex: 0,
                    pageSize: 10,
                },
                sortMap: [],
                whereParams: [],
            },
            list: [],
            pageIndex: 0,
            pageSize: 25,
            totalPages: 1,
            total: 0
        },
       
        status: 'view', //表格状态：view=查看、edit=编辑、new=新增、del=删除
        
        selectIndex: 0,
        showLoading: false,
        showModalCover: false,
        //查询字典项的key值
        dicItemList: "DIC_BILL_STATE,fund_creditgrant_state,fund_Capital_use,term_unit,insNormYorn,",
        //查询字典项结果集合
        option:{},
        //查询自定义档案的key值
        defDocList:"fund_fund_use,insert_creditgrant_type",
        //查询自定义档案结果集合
        docOption:{},
        //详情页子表-删除数据集合
        deleteData:[],
        //悬浮选中的index
        positionIndex:999,
        //滚动加载开关 
        scrollFlag:true,  
    },
    reducers: {
        /**
         * 纯函数，相当于 Redux 中的 Reducer，只负责对数据的更新。
         * @param {*} state
         * @param {*} data
         */
        updateState(state, data) { //更新state
            return {
                ...state,
                ...data
            };
        },
        /**
         * 纯函数 合并 initialState
         * @param {*} state
         * @param {*} data
         */
        initState(state, data) { //更新state
            const assignState = deepAssign(state, data);
            return {
                ...assignState,
            };
        },
    },
    effects: {
        // 获取字典数据
        async loadDicData(param, getState) {
            let { result } = processData(await commonapi.getDicByCodes({codeList:param}), '');
            let { status } = result;
            if (status) {
                //1. 此处不能使用Object.assign ,model不会更新;
                //2. 此处没必要进行重新合并. 字典是后台取得,每次都是最新的.
                // let obj = Object.assign(option,result.data);
                actions.mainModel.updateState({
                    option: result.data
                })
            }
        },
        /**
         * 获取自定义档案数据
         * @param {*} param
         * @param {*} getState
         */
        async loadDefDoc(param, getState) {
            let { result } = processData(await commonapi.getTenantDicByTypes({codeList:param}),'');
            let {status} = result;
            if(status){
                actions.mainModel.updateState({
                    docOption: result.data
                });
            }
        },

        /**
         * 加载主列表数据
         * @param {*} param (分页条件和查询条件)
         * @param {*} getState
         */
        async loadList(param={}, getState) {
            actions.mainModel.updateState({showLoading: true});
            const {result} = processData(await api.getList(param));  // 调用 getList 请求数据
            const {data:res}=result;
            actions.mainModel.updateState({showLoading: false});
            if (res) {
                let {pageParams} = param; 
                actions.mainModel.updateState({
                    listGridData:structureObj(res, pageParams),
                    listQueryParam:param
                }); 
            } else {
                // 如果请求出错,数据初始化
                let {pageParams:errorPageParams} = param; 
                actions.mainModel.updateState({
                    listGridData:initStateObj(errorPageParams),
                })
            }
        },

        /**
         * @description：通过id查询详情页数据
         * @param {*} param   单据ID;
         * @param {*} getState
         */
        async queryEditObj(param, getState) {
            actions.mainModel.updateState({ showLoading: true });   // 正在加载数据，显示加载 Loading 图标
            const { result } = {...processData(await api.getListById(param))};  // 调用 getList 请求数据
            actions.mainModel.updateState({ showLoading: false });
            const { data } = result; 
            const editObj = data ? data : {};
            // 子表表单数据
            const temp=deepClone(editObj);
            delete temp.fmsFcVarietyList;
            // delete temp.fileList;
            actions.mainModel.updateState({
                editFormData:temp,
                fmsFcVarietyData:{
                    list:editObj.fmsFcVarietyList
                },

            })
        },

        /**
         * @description 单据的新增/修改操作
         * @param param
         * @param getState
         * @returns {Promise<void>}
         */
        async adds(params, getState) {
            const {param,addFlag,submitFlag}=params;
            actions.mainModel.updateState({ showLoading: true });
            if(submitFlag){
                const { result } = processData(await api.saveSubmit(param), '保存并提交成功');
                actions.mainModel.updateState({ showLoading: false });
                const { data: res } = result;
                if (res) {
                    actions.routing.push({ pathname: '/' });
                }
            }else{
                const { result } = processData(await api.saveAsso(param), '保存成功');
                actions.mainModel.updateState({ showLoading: false });
                const { data: res } = result;
                if(addFlag){
                    let url=window.location.origin+window.location.pathname+"#/edit?search_id=&btnFlag=0&copy=false"
                    window.location.replace(url);
                }else{
                    if (res) {
                        actions.routing.push({ pathname: '/' });
                    }
                }

            }

        },

        /**
         * @description 列表数据删除操作;
         * @param {*} param {idList:[id1,id2,...]}
         * @param {*} getState
         */
        async delListData(param, getState) {
            actions.mainModel.updateState({ showLoading: true });
            const { result } = processData(await api.delOrder(param), '删除成功');
            actions.mainModel.updateState({ showLoading: false });
            const { status } = result;
            if (status) {
                // 获取 pageSize
                const { listQueryParam } = getState().mainModel;
                actions.mainModel.loadList(listQueryParam);
            }
        },

        /**
         * @description 子表数据删除操作，只有个别情况，主子表分开保存时调用，
         *              一般删除不调用该接口，而是直接修改单据对象后，执行保存操作。
         * @param {*} param  单据对象
         * @param {*} getState
         */
        async delOrderDetail(param, getState) {
            actions.mainModel.updateState({ showLoading: true });
            const { result } = processData(await api.delOrderDetail(param), '删除成功');
            actions.mainModel.updateState({ showLoading: false });
            return result;
        }
    }
};
