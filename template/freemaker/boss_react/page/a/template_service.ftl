import request from "utils/request";
import { deepClone } from 'utils';
//定义接口地址
const URL = {
    "GET_LIST": `${r"${"}GROBAL_HTTP_CTX${r"}"}/${tb.fLowerTName}/get${tb.fUpperTName}ByPage`,
}

/**
* 获取列表
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

