import React from "react";
import mirror, {connect} from 'mirrorx';

// 组件引入
import listApp from './list/components/App';
import editApp from './edit/components/App';
import subTableGroup from './edit/components/SubTableGroup';
import mainForm from './edit/components/MainForm';

// 数据模型引入
import model from './model.js';
mirror.model(model);

// 数据和组件UI关联、绑定
let ListContainer=connect(state => state.mainModel, null)(listApp);
let EditContainer=connect(state => state.mainModel,null)(editApp);
let SubTableGroup=connect(state => state.mainModel,null)(subTableGroup); //详情页表格组-组件绑定model
let MainForm=connect(state => state.mainModel,null)(mainForm);  //详情页表单组件-绑定model

export {ListContainer, EditContainer,SubTableGroup,MainForm};
