import React from 'react';
import mirror, {connect} from 'mirrorx';

// 组件引入
import App from './components/App';


// 数据和组件UI关联、绑定
export default connect(state => state.${tb.fLowerTName}, null)(App);

