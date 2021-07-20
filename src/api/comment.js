// 評論請求模塊
import request from '@/utils/request'

// 文章評論列表
export const getComments = params => {
  return request({
    method: 'GET',
    url: '/sys/getComments',
    params
  })
}
