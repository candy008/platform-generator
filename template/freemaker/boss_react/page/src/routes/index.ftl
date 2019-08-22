/**
 * 前端路由说明：
 * 1、基于浏览器 History 的前端 Hash 路由
 * 2、按业务模块和具体页面功能划分了一级路由和二级路由
 */
import React from "react";
import {Route} from "mirrorx";
import {ListContainer,EditContainer} from "./container";
import BpmChart from 'components/bpmChart/container';   //调用组件库的流程组件(BpmChart)页面

export default () => (
    <div className="route-content">
        <Route exact path='/' component={ListContainer}/>
        <Route exact path='/edit' component={EditContainer}/>
        <Route exact path='/bpm-chart' component={BpmChart} />
    </div>
)