import { actions } from "mirrorx";
// 引入services，如不需要接口请求可不写
import * as api from "./service";
import * as commonapi from "utils/commonapi";
// 接口返回数据公共处理方法，根据具体需要
import { processData, deepAssign, structureObj, initStateObj, Error } from "utils";
import { deepClone } from "../../../../../ucf-common/src/utils";

/**
 *          btnFlag为按钮状态，新增、修改是可编辑，查看详情不可编辑，
 *          新增表格为空
 *          修改需要将行数据带上并显示在卡片页面
 *          查看详情携带行数据但是表格不可编辑
 *          0表示新增、1表示编辑，2表示查看详情 3提交
 *async loadList(param, getState) {
 *          rowData为行数据
 */

export default {
    // 确定 Store 中的数据模型作用域
    name: "${tb.fLowerTName}",
    // 设置当前 Model 所需的初始化 state
    initialState: {
        cacheData: [],//新增、修改缓存原始数据
        tableData: [],//表格最终处理渲染的数据
        selectData: [],//选中的状态数组
        status: 'view',//表格状态：view=查看、edit=编辑、new=新增、del=删除
        queryParam: {
            pageParams: {
                pageIndex: 0,
                pageSize: 10,
            },
            sortMap: [],
            whereParams: [],
        },//查询条件参数
        selectIndex: 0,
        showLoading: false,
        showDetailLoading: false,
        showModalCover: false,
        listSearchObj: {
            list: [],
            pageIndex: 1,
            pageSize: 10,
            totalPages: 1,
            total: 0,
        },
        detailObj: {
            list: [],
            pageIndex: 1,
            pageSize: 10,
            totalPages: 1,
            total: 0,
        },
        searchParam: {},
        queryParent: {
            creditTerm:"1"
        },
        //总数据
        queryDetailObj: {
            list: [],
            fileList:[],
            pageIndex: 1,
            pageSize: 10,
            totalPages: 1,
            total: 0,
        },
         //字典
         dicItemList: "DIC_BILL_STATE,fund_creditgrant_state,fund_Capital_use,term_unit",
         //字典项的存储
         option:{},
         //自定义档案
         defDocList:"fund_fund_use,insert_creditgrant_type",
         //自定义档案存储
         docOption:{},
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

        /**
         * 加载主列表数据
         * @param {*} param
         * @param {*} getState
         */
        async loadList(param={}, getState) {
            actions.${tb.fLowerTName}.updateState({showLoading: true});
            const {result} = processData(await api.getList(param));  // 调用 getList 请求数据
            const {data:res}=result;
            actions.${tb.fLowerTName}.updateState({showLoading: false});
            if (res) {
                const {pageParams} = param;
                const listSearchObj = structureObj(res, pageParams);
                actions.${tb.fLowerTName}.updateState({listSearchObj, queryParam: param}); // 更新数据和查询条件
            } else {
                // 如果请求出错,数据初始化
                const {listSearchObj} = getState().${tb.fLowerTName};
                actions.${tb.fLowerTName}.updateState({listSearchObj: initStateObj(listSearchObj)});
            }
        },
		/**
         * getSelect：通过id查询主表数据
         * @param {*} param
         * @param {*} getState
         */
        async queryParent(param, getState) {
            actions.${tb.fLowerTName}.updateState({ showLoading: true });   // 正在加载数据，显示加载 Loading 图标
            const { result } = {...processData(await api.getListById(param))};  // 调用 getList 请求数据
            console.log(await api.getListById(param));
            actions.${tb.fLowerTName}.updateState({ showLoading: false });
            const { data } = result;

            // 跳转消息中心
            const { search_from } = param;

            const { content = [] } = data || {};
            const queryParent = data ? data : {};
            actions.${tb.fLowerTName}.updateState({ queryParent });
            actions.${tb.fLowerTName}.queryChild(queryParent);
        },
		/**
         * 保存数据
         * @param param
         * @param getState
         * @returns {Promise<void>}
         */
        async adds(params, getState) {
            const {param,addFlag,submitFlag}=params;
            actions.${tb.fLowerTName}.updateState({ showLoading: true });
			//保存成功后跳转列表页
            if(submitFlag){
                const { result } = processData(await api.saveSubmit(param), '保存并提交成功');
                const { data: res } = result;
                actions.${tb.fLowerTName}.updateState({ showLoading: false });
                if (res) {
                    actions.routing.push({ pathname: '/' });
                }
            }
			//保存成功后跳转到新增页
			else{
                const { result } = processData(await api.saveAsso(param), '保存成功');
                const { data: res } = result;
                actions.${tb.fLowerTName}.updateState({ showLoading: false });
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
         * 加载子表信息
         * @param param
         * @param getState
         * @returns {Promise<void>}
         */
        async loadOrderDetailList(param, getState) {
            // 调用 getList 请求数据
            // 正在加载数据，显示加载 Loading 图标
            actions.${tb.fLowerTName}.updateState({showLoading: true});
            const {result} = processData(await api.getList(param));  // 调用 getList 请求数据
            const {data:res}=result;
            actions.${tb.fLowerTName}.updateState({showLoading: false});
            if (res) {
                const {pageParams} = param;
                const ${tb.fLowerTName} = structureObj(res, pageParams);
                actions.${tb.fLowerTName}.updateState({listSearchObj, queryParam: param}); // 更新数据和查询条件
            } else {
                // 如果请求出错,数据初始化
                const {listSearchObj} = getState().${tb.fLowerTName};
                actions.${tb.fLowerTName}.updateState({listSearchObj: initStateObj(listSearchObj)});
            }
        },
        /**
         * getSelect：通过id查询子表数据 紧急联系人
         * @param {*} param
         * @param {*} getState
         */
        async queryChild(queryParent,getState) {
            let { queryDetailObj } = getState().${tb.fLowerTName};
            let listObj=deepClone(queryDetailObj);

            if(queryParent.fmsFcVarietyList){
                listObj.list=queryParent.fmsFcVarietyList;
            }
            actions.${tb.fLowerTName}.updateState({ queryDetailObj:listObj });
        },


        /**
         * 删除主表数据
         * @param {*} param
         * @param {*} getState
         */
        async delOrder(param, getState) {
            actions.${tb.fLowerTName}.updateState({ showLoading: true });
            const { result } = processData(await api.delOrder(param), '删除成功');
            actions.${tb.fLowerTName}.updateState({ showLoading: false });
            const { status } = result;
            if (status) {
                // 获取 pageSize
                const { queryParam } = getState().${tb.fLowerTName};
                await actions.${tb.fLowerTName}.updateState({
                    selectIndex: 0
                })
                actions.${tb.fLowerTName}.loadList(queryParam);
            }
        },
        /**
         * 删除子表数据
         * @param {*} param
         * @param {*} getState
         */
        async delOrderDetail(param, getState) {
            actions.${tb.fLowerTName}.updateState({ showLoading: true });
            const { result } = processData(await api.delOrderDetail(param), '删除成功');
            actions.${tb.fLowerTName}.updateState({ showLoading: false });
            return result;

        },
		
		/**
         * 加载字典的数据
         * @param {*} param
         * @param {*} getState
         */
        async loadDicItem(param, getState) {
            let {data} = await commonapi.getDicByCodes(param);
            let {detailMsg}=data;
            console.log(detailMsg.data);
            if(detailMsg.data){
                actions.${tb.fLowerTName}.updateState({option: detailMsg.data});
            }

        },
         /**
         * 加载自定义档案的数据
         * @param {*} param
         * @param {*} getState
         */
        async loadDefDoc(param, getState) {
            let {data} = await commonapi.getTenantDicByTypes(param);
            let {detailMsg}=data;
            console.log(detailMsg.data);
            if(detailMsg.data){
                actions.${tb.fLowerTName}.updateState({docOption: detailMsg.data});
            }

        },
    }
};
