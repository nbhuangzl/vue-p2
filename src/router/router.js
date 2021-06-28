import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)
// 路由表
const routes = [
  {
    path: '/login',
    name: 'login',
    // component: () => import('@/views/login/index.vue')
    // 自动加载目录下的index.vue
    component: () => import('@/views/login')
  }
]
const router = new Router({
  routes
})
export default router
