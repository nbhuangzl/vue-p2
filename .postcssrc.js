module.exports = {
  plugins: {
    // Vue CLI默认集成了PostCSS 且 开启了autoprefixer插件
    // 所以 这里需注释掉
    // 'autoprefixer': {
    //   browsers: ['Android >= 4.0', 'iOS >= 8']
    // },
    'postcss-pxtorem': {
      // lib-flexible的rem适配方案：1行分10份,每份 10分之1
      // 所以 rootValue应该设置为设计稿宽度的10分之1
      // 而 vant 基于 37.5  自己的样式 则基于设计稿的像素
      // 比如750： 750 / 10 = 75
      // rootValue: 37.5,
      rootValue ({ file }) {
        return file.indexOf('vant') !== -1 ? 37.5 : 75
      },
      propList: ['*']
    }
  }
}
