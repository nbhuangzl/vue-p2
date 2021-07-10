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
