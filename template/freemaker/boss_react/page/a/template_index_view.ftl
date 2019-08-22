import React, {Component} from 'react';
import {actions} from 'mirrorx';
import {Tooltip, Menu, Icon, Loading} from 'tinper-bee';
import queryString from "query-string";
import moment from 'moment'
import Grid from 'components/Grid';
import Header from 'components/Header';
import Button from 'components/Button';
import PopDialog from 'components/Pop';
import SearchArea from '../SearchArea'
import Dropdown from 'bee-dropdown'
import {deepClone, getHeight, getSortMap} from "utils";

import './index.less';

const {Item} = Menu;
const format = "YYYY-MM-DD HH:mm:ss";
const beginFormat = "YYYY-MM-DD 00:00:00";
const endFormat = "YYYY-MM-DD 23:59:59";


class IndexView extends Component {
    constructor(props) {
        super(props);
        this.state = {
            tableHeight: 0,
            filterable: false,
            showModal: false,
            record: {}, // 存储关联数据信息
        }

    }

    componentWillMount() {
        //计算表格滚动条高度
        this.resetTableHeight(true);
    }
    componentDidMount() {
        actions.query.loadList(this.props.queryParam); // 查询默认条件
    }

    componentWillReceiveProps(nextProps) {
        //后台获取部门行过滤下拉列表 动态更新 colFilterSelectdept 部门行过滤下拉列表
        if (!this.props.colFilterSelectdept && nextProps.colFilterSelectdept) {
            for (let i = 0, len = this.gridColumn.length; i<len; i++) {
                let item = this.gridColumn[i];
                if (item.key === 'dept') {
                    item.filterDropdownData = nextProps.colFilterSelectdept;
                    break;
                }
            }
        }
    }

    /**
     *
     * 关联数据钻取
     * @param {object} record 关联数据行数据
     * @param {string} key menu菜单key值
     */
    onRelevance = (record, key) => {
        let {name} = record;
        if (key === "name") { // 跳转百度
            window.open(window.location.href+'?a=' + name, "_blank");
        }
        if (key === "code") {  // 弹出模态框
            this.setState({record, showModal: true});
        }
        if (key === "year") {  // 跳转新页面
            let {code, name, sexEnumValue, levelName} = record;
            actions.routing.push({
                pathname: '/employee',
                search: queryString.stringify({code, name, sexEnumValue, levelName})
            })
        }
    }

    /**
     *
     *排序属性设置
     * @param {Array} sortParam 排序参数对象数组
     */
    sortFun = (sortParam) => {
        let {queryParam} = this.props;
        queryParam.sortMap = getSortMap(sortParam);
        actions.query.loadList(queryParam);
    }

    /**
     *
     *触发过滤输入操作以及下拉条件的回调
     * @param {string} key 过滤字段名称
     * @param {*} value 过滤字段值
     * @param {string} condition 过滤字段条件
     */
    onFilterChange = (key, value, condition) => {
        let isAdd = true; //是否添加标识
        let queryParam = deepClone(this.props.queryParam);
        let {whereParams, pageParams} = queryParam;
        pageParams.pageIndex = 0; // 默认跳转第一页
        for (let [index, element] of whereParams.entries()) {
            if (element.key === key) { // 判断action 中是否有 过滤对象
                whereParams[index] = this.handleFilterData(key, value, condition);
                isAdd = false;
            }
        }
        if (isAdd) {
            let filterData = this.handleFilterData(key, value, condition);
            whereParams.push(filterData);
        }
        actions.query.loadList(queryParam);
    }


    /**
     *
     * 拼接过滤条件对象
     * @param {string} key 过滤字段名称
     * @param {*} value 过滤字段值
     * @param {string} condition 过滤字段条件
     */

    handleFilterData = (key, value, condition) => {
        let filterObj = {key, value, condition};
        if (Array.isArray(value)) { // 判断是否日期
            filterObj.value = this.handleDateFormat(value); // moment 格式转换
            filterObj.condition="RANGE";
        }
        return filterObj;
    }


    /**
     * 清除过滤条件的回调函数，回调参数为清空的字段
     * @param {string} key 清除过滤字段
     */
    onFilterClear = (key) => {
        let queryParam = deepClone(this.props.queryParam);
        let {whereParams, pageParams} = queryParam;
        for (let [index, element] of whereParams.entries()) {
            if (element.key === key) {
                whereParams.splice(index, 1);
                pageParams.pageIndex = 0; // 默认跳转第一页
                break;
            }
        }
        actions.query.loadList(queryParam);
    }


    /**
     *
     *行过滤，日期数组拼接
     * @param {Array} value 日期数组
     * @returns
     */
    handleDateFormat = (value) => {
        let dateArray = value.map((item, index) => {
            let str = '';
            if (index === 0) {
                str = item.format(beginFormat);
            } else {
                str = item.format(endFormat);
            }
            return str;
        });
        return dateArray;
    }

    /**
     *
     * @param {Number} pageIndex 跳转指定页数
     */
    freshData = (pageIndex) => {
        this.onPageSelect(pageIndex, 0);
    }

    /**
     *
     * @param {Number} index 跳转指定页数
     * @param {Number} value 设置一页数据条数
     */
    onDataNumSelect = (index, value) => {
        this.onPageSelect(value, 1);
    }

    /**
     *
     * @param {Number} value  pageIndex 或者 pageIndex
     * @param {Number} type 为0标识为 pageIndex,为1标识 pageSize
     */
    onPageSelect = (value, type) => {
        let queryParam = deepClone(this.props.queryParam); // 深拷贝查询条件从 action 里
        let {pageIndex, pageSize} = queryParam.pageParams;
        if (type === 0) {
            pageIndex = value - 1;
        } else {
            pageSize = value;
            pageIndex = 0;
        }
        if (value && value.toString().toLowerCase() === "all") { // 对分页 pageSize 为 all 进行处理，前后端约定
            pageSize = 1;
        }
        queryParam['pageParams'] = {pageIndex, pageSize};
        actions.query.loadList(queryParam);
    }

    /**
     *
     * @param {Boolean} status 控制栏位的显示/隐藏
     */
    afterRowFilter = (status) => {
        if (!status) { // 清空行过滤数据
            let {queryParam, cacheFilter} = deepClone(this.props);
            queryParam.whereParams = cacheFilter;
            actions.query.updateState({queryParam}); //缓存查询条件
        }
        this.setState({filterable: status});
    }


    clearRowFilter = () => {
        this.setState({filterable: false});
    }

    /**
     * 导出excel
     */
    export = () => {
        this.grid.exportExcel();
    }

    /**
     * 重置表格高度计算回调
     *
     * @param {Boolean} isopen 是否展开
     */
    resetTableHeight = (isopen) => {
        let tableHeight = 0;
        if (isopen) {
            //展开的时候并且适配对应页面数值px
            tableHeight = getHeight() - 470
        } else {
            //收起的时候并且适配对应页面数值px
            tableHeight = getHeight() - 270
        }
        this.setState({ tableHeight });
    }

    gridColumn = [
	<#list tb.columns as item>
	    {
	    title: <#if (item.remarks)!="">"${item.remarks}"<#else>"${item.fLowerColName}"</#if>,
	    dataIndex: "${item.fLowerColName}",
	    key: "${item.fLowerColName}",
	    width: 160,
	    },
	</#list>
	]

    render() {

        let {queryObj, showLoading, queryParam} = this.props;
        let {pageIndex, total, totalPages} = queryObj;
        let {filterable, record, tableHeight} = this.state;

        let paginationObj = {   // 分页
            activePage: pageIndex,//当前页
            total,//总条数
            items: totalPages,
            freshData: this.freshData,
            onDataNumSelect: this.onDataNumSelect,
        }

        // const
        let sortObj = {  //排序属性设置
            mode: 'multiple',
            backSource: true,
            sortFun: this.sortFun
        }

        return (
            <div className='single-table-query'>
                <Loading showBackDrop={true} show={showLoading} fullScreen={true}/>
                <Header title='A1单表查询示例'/>
                <SearchArea
                    queryParam={queryParam}
                    clearRowFilter={this.clearRowFilter}
                    onCallback={this.resetTableHeight}
                />
                <div className='table-header'>
                    <Button
                        className="ml8"
                        colors="primary"
                        onClick={this.export}
                    >导出</Button>
                </div>
                <div className="gird-parent">
                    <Grid
                        ref={(el) => this.grid = el} //存模版
                        columns={this.gridColumn}
                        data={queryObj.list}
                        rowKey={(r, i) => i} //生成行的key
                        paginationObj={paginationObj} //分页
                        multiSelect={false}  //false 单选，默认多选
                        showFilterMenu={true} //是否显示行过滤菜单
                        filterable={filterable}//是否开启过滤数据功能
                        onFilterChange={this.onFilterChange}  // 触发过滤输入操作以及下拉条件的回调
                        onFilterClear={this.onFilterClear} //清除过滤条件的回调函数，回调参数为清空的字段
                        afterRowFilter={this.afterRowFilter} //控制栏位的显示/隐藏
                        sort={sortObj} //排序属性设置
                        scroll={{y: tableHeight}}
                        sheetHeader={{height: 30, ifshow: false}} //设置excel导出的表头的样式、支持height、ifshow
                    />
                </div>

                <PopDialog
                    show={this.state.showModal}
                    title={"模态弹出"}
                    close={this.close}
                    btns={[]}
                >
                    <div>
                        <span>员工编号：</span>
                        <span>{record.code}</span>
                    </div>
                    <div>
                        <span>员工姓名：</span>
                        <span>{record.name}</span>
                    </div>
                    <div>
                        <span>员工性别：</span>
                        <span>{record.sexEnumValue}</span>
                    </div>
                    <div>
                        <span>职级：</span>
                        <span>{record.levelName}</span>
                    </div>
                </PopDialog>
            </div>
        )
    }
}

export default IndexView;
