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
