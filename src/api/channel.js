/**
 * 频道请求模块
 */
import request from '@/utils/request'

/**
 * 取所有频道列表
 */
export const getAllChannels = () => {
  return request({
    method: 'GET',
    url: '/sys/getAllChannels'
  })
}
