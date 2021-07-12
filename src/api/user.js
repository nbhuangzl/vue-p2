import request from '@/utils/request'
// import store from '@/store'

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

/**
 * 用户信息
 */
export const getUserInfo = mobile => {
  return request({
    method: 'GET',
    // 手机号仅为测试验证
    url: `/sys/getUserInfo/${mobile}`
    // 优化请求头信息 不写于每个请求方法内 采用axios请求拦截器
    // 发送请求头数据
    // headers: {
    //  Authorization: `Bearer ${store.state.user.token}`
    //  // Authorization: 'afafaf'
    // }
  })
}

/**
 * 用户频道信息
 */
export const getUserChannels = () => {
  return request({
    method: 'GET',
    url: '/sys/getUserChannels'
  })
}

/*
 * 关注用户
 */
export const addFollow = target => {
  return request({
    method: 'POST',
    url: '/sys/addFollow',
    data: {
      target
    }
  })
}
/*
 * 取消关注
 */
export const deleteFollow = target => {
  return request({
    method: 'DELETE',
    url: `/sys/deleteFollow/${target}`
  })
}
