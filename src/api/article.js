import request from '@/utils/request'
// import store from '@/store'

/*
 * 发送验证码
 */
export const getArticles = (params) => {
  return request({
    method: 'GET',
    url: '/sys/getArticles',
    // params: params 名称1样 可简化为1个
    params
  })
}
