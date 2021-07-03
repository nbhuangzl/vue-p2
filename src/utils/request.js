import axios from 'axios'
import store from '@/store'

const request = axios.create({
  baseURL: 'http://localhost:8081',
  timeout: 5000 // 请求超时 5000毫秒
})

// Add a request interceptor
request.interceptors.request.use(config => {
  // 除登录请求之外的其他ajax请求均会带上token
  // config 请求配置对象
  const { user } = store.state
  if (user && user.token) {
    config.headers.Authorization = `Bearer ${user.token}`
  }
  return config
}, error => {
  return Promise.reject(error)
})
// Add a response interceptor
request.interceptors.response.use(response => {
  return response
}, error => {
  return Promise.reject(error)
})
export default request // 导出自定义创建的axios对象
