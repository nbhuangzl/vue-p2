import request from '@/utils/request'

export const login = data => {
  return request({
    method: 'POST',
    url: '/sys/login',
    // data:data,
    data
  })
}
/*
 * 发送验证码
 */
export const sendSms = mobile => {
  return request({
    method: 'GET',
    url: `/sys/sendSms/${mobile}`
  })
}
