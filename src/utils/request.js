import axios from 'axios'

const request = axios.create({
  baseURL: 'http://localhost:8081',
  timeout: 5000 // 请求超时 5000毫秒
})
/* 请求拦截器 */
/* 请求拦截器 */
request.interceptors.request.use(config => {
  return config
}, error => {
  return Promise.reject(error)
})
/* 响应拦截器 */
request.interceptors.response.use(response => {
  return response
}, error => {
  return Promise.reject(error)
})
export default request // 导出自定义创建的axios对象
