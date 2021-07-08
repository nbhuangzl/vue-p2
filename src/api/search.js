import request from '@/utils/request'
/**
 * 联想建议
 */
export const getSearchAdvisory = q => {
  return request({
    method: 'GET',
    url: '/sys/getSearchAdvisory',
    params: {
      q
    }
  })
}

/**
 * 搜索结果
 */
export const getSearchResult = params => {
  return request({
    method: 'GET',
    url: '/sys/getSearchResult',
    params
  })
}
