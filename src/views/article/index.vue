<template>
  <div class="article-container">
    <!-- 导航栏 -->
    <van-nav-bar
     class="page-nav-bar"
     left-arrow
     title="黑马头条" >
    </van-nav-bar>
    <div class="main-wrap">
      <!--加载中-->
      <div class="loading-wrap">
        <van-loading
          color="#3296fa"
          vertical
        >加载中
        </van-loading>
      </div>
      <div class="article-detail">
        <!-- 文章标题 -->
        <h1 class="article-title">这是文章标题</h1>
        <van-cell class="user-info" center :border="false">
          <van-image
            class="avatar"
            slot="icon"
            round
            fit="cover"
            src="https://img.yzcdn.cn/vant/cat.jpeg"
          />
          <div slot="title" class="user-name">头条信息</div>
          <div slot="label" class="publish-date">7小时前</div>
          <van-button
            class="follow-btn"
            type="info"
          />
        </van-cell>
        <div
          class="article-content markdown-body"
          v-html="'<h1>你好</h1>'"
        >
        </div>
        <van-divider>正文结束</van-divider>
        <!-- 评论列表 -->
        <comment-list></comment-list>

        <!-- 底部区域 -->
        <div class="article-bottom">
          <van-button
            class="comment-btn"
            type="default"
            round
            size="small"
            >写评论</van-button>
          <van-icon name="comment-o" color="#777" />
          <van-icon name="share" color="#777777"></van-icon>
        </div>
      </div>
    </div>
    文章详情页
  </div>
</template>
<script>
export default {
  name: 'ArticleIndex',
  components: {},
  props: {
    // articleId 是router.js映射过来的
    articleId: {
      // 可能是数字 或者 字符串
      type: [Number, String],
      required: true
    }
  },
  data () {
    return {
    }
  },
  watch: {
  },
  computed: {
  },
  created () {
  },
  mounted () {
  },
  methods: {
  }
}
</script>
<style lang="less" scoped>
.article-container {
  .van-nav-bar .van-icon {
    color: #fff !important
  }
}
</style>
