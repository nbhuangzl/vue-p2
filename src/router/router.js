import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)
// 路由表
const routes = [
  {
    path: '/Login',
    name: 'login',
    // component: () => import('@/views/login/index.vue')
    // 自动加载目录下的index.vue
    component: () => import('@/views/login')
  },
  {
    path: '/',
    name: 'layout', // 若父路由有默认子路由，那么 它的name没有意义
    component: () => import('@/views/layout'),
    children: [
      {
        path: '', // 默认子路由 空即可
        name: 'home',
        component: () => import('@/views/home')
      },
      {
        path: '/my',
        name: 'my',
        component: () => import('@/views/my')
      },
      {
        path: '/qa',
        name: 'qa',
        component: () => import('@/views/qa')
      },
      {
        path: '/video',
        name: 'video',
        component: () => import('@/views/video')
      }
    ]
  }
]
const router = new Router({
  routes
})
export default router
