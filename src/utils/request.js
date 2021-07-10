import axios from 'axios'
import store from '@/store'
import JSONBig from 'json-bigint'

/* JSONB 处理不了 超出正负2^53范围的数据 */
// JSON.parse()
// JSON.stringfy()

/* JSONBig能处理 超出正负2^53范围的数据 */
// JSONBig.parse() 将json格式字符串转为js对象
// JSONBig.stringfy() 将js对象转为JSON格式字符串
// 示例
// const jsonStr = '{ "art_id": 123456655555555555555}'
// console.log(JSON.parse(jsonStr)) // 123456655555555560000
// console.log(JSONBig.parse(jsonStr))
/* art_id: BigNumber
c: (2) [1234566, 55555555555555]
e: 20
s: 1 */
// console.log(JSONBig.parse(jsonStr).art_id.toString()) // 字符串:123456655555555555555

// JSON
// {"art_id":"123456655555555555555"}
// console.log(JSON.stringify(JSONBig.parse(jsonStr)))
// JSONBig
// {"art_id":123456655555555555555}
// console.log(JSONBig.stringify(JSONBig.parse(jsonStr)))

const request = axios.create({
  baseURL: 'http://localhost:8081',
  timeout: 5000, // 请求超时 5000毫秒
  // 自定义后端返回的原始数据解析, 参详 github.com/axios/axios
  // data：后端返回的JSON格式的字符串
  transformResponse: [function (data) {
    try {
      return JSONBig.parse(data)
    } catch (err) {
      return data
    }
    /* 未自定义transformResponse方法
       axios 默认处理后端返回的数据的方式为
       return JSON.parse(data) */
  }]
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
