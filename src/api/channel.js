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

/**
 * 添加用户频道
 */
export const addUserChannel = channel => {
  return request({
    method: 'PATCH',
    url: '/sys/addUserChannel',
    data: {
      channels: [channel]
    }
  })
}

/**
 * 删除用户频道
 */
export const deleteUserChannel = channelId => {
  return request({
    method: 'DELETE',
    url: `/sys/deleteUserChannel/${channelId}`
  })
}
