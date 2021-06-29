import Vue from 'vue'
import App from './App.vue'
import router from './router/router'
import store from './store'
// 加载全局样式
import './styles/index.less'
// npm i vant
// 加载 Vant 核心组件
import Vant from 'vant'
// 加载 Vant全局样式
import 'vant/lib/index.css'
// npm i amfe-flexible之后
// 加载动态设置 rem基准值
import 'amfe-flexible'
// 注册使用Vant组件库
Vue.use(Vant)

Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
