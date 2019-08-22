import request from "utils/request";
import { deepClone } from 'utils';
//定义接口地址
const URL = {
    "GET_LIST":  `${r'${GROBAL_BS_HTTP_CTX}'}/${tb.fLowerTName}/get${tb.fUpperTName}ByPage`, // 获取主表
    "GET_ORDER_DETAIL":  `${r'${GROBAL_BS_HTTP_CTX}'}/purchase_order_detail/list`, // 获取子表
    "DEL_ORDER":  `${r'${GROBAL_BS_HTTP_CTX}'}/${tb.fLowerTName}/logicDelete${tb.fUpperTName}ByBatchId`, // 删除主表
    "DEL_ORDER_DETAIL":  `${r'${GROBAL_BS_HTTP_CTX}'}/purchase_order_detail/deleteBatch`, // 删除子表
    "SAVE_ASSO":  `${r'${GROBAL_BS_HTTP_CTX}'}/${tb.fLowerTName}/insertOrUpdate`, //保存
    "GET_USER": `${r'${GROBAL_BS_HTTP_CTX}'}/purchase_order/listForAdd`, //保存
    "GET_List_Id": `${r'${GROBAL_BS_HTTP_CTX}'}/${tb.fLowerTName}/get${tb.fUpperTName}ById`,//通过id获取字表信息
}

/**
 * 获取主列表
 * @param {*} params
 */
export const getList = (param) => {
    
    let newParam = Object.assign({}, param),
        pageParams = deepClone(newParam.pageParams);
    delete newParam.pageParams;
    return request(URL.GET_LIST, {
        method: "post",
        data: newParam,
        param: pageParams
    });
}
/**
 * 根据ID获取详情页信息;
 * @param {*} params
 */
export const getListById = (param) => {
    return request(URL.GET_List_Id, {
        method: "post",
        data: param,
    });
}

/**
 * 保存数据
 * @param {*} params
 */
export const saveAsso = (params) => {
    return request(URL.SAVE_ASSO, {
        method: "post",
        data:params
    });
}
/**
 * 保存并提交
 * @param {*} params
 */
export const saveSubmit = (params) => {
    return request(URL.SAVE_SUBMIT, {
        method: "post",
        data:params
    });
}

/**
 * 列表页-删除数据 
 * @param {*} params
 */
export const delOrder = (params) => {
    return request(URL.DEL_ORDER, {
        method: "post",
        data:params
    });
}

/**
 * 子表-删除数据
 * @param {*} params
 */
export const delOrderDetail = (params) => {
    return request(URL.DEL_ORDER_DETAIL, {
        method: "post",
        data:params
    });
}

/**
 * 获取申请人信息
 * @param {*} params
 */
export const getUser = (param) => {
    return request(URL.GET_USER, {
        method: "get",
        param
    });
}