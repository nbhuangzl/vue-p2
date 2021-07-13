import request from '@/utils/request'
// import store from '@/store'

/*
 * 文章列表
 */
export const getArticles = params => {
  return request({
    method: 'GET',
    url: '/sys/getArticles',
    // params: params 名称1样 可简化为1个
    params
  })
}

/*
 * 依据id取文章
 */
export const getArticleById = articleId => {
  return request({
    method: 'GET',
    url: `/sys/getArticleById/${articleId}`
  })
}

/*
 * 关注用户
 */
export const addCollect = target => {
  return request({
    method: 'POST',
    url: '/sys/addCollect',
    data: {
      target
    }
  })
}
/*
 * 取消收藏
 */
export const deleteCollect = target => {
  return request({
    method: 'DELETE',
    url: `/sys/deleteCollect/${target}`
  })
}
