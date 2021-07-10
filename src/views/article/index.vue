<template>
  <div class="article-container">
    <!-- 导航栏 -->
    <van-nav-bar
     class="page-nav-bar"
     left-arrow
     title="黑马头条"
     @click-left="onClickLeft" >
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

      <!-- 加载完成显示文章详情 -->
      <div class="article-detail">
        <!-- 文章标题 -->
        <h1 class="article-title">{{ article.title }}</h1>
        <van-cell class="user-info" center :border="false">
          <van-image
            class="avatar"
            slot="icon"
            round
            fit="cover"
            :src="article.aut_photo"
          />
          <div slot="title" class="user-name">{{ article.aut_name }}</div>
          <div slot="label" class="publish-date">{{ article.pubdate | relativeTime }}</div>
          <van-button
            class="follow-btn"
            type="info"
            round
            color="#3296fa"
            icon="plus"
            size="mini"
          >关注</van-button>
        </van-cell>
        <div
          class="article-content markdown-body"
          v-html="article.content"
        >
        </div>
        <van-divider>正文结束</van-divider>
        <!-- 评论列表 -->
        <!-- <comment-list></comment-list> -->

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

      <!-- 加载失败：404 -->
      <div class="error-wrap">
        <van-icon name="failure"/>
        <p class="text">该资源不存在或者已删除</p>
      </div>

      <!-- 加载失败 其他未知错误(如网络或者服务器) -->
    </div>
    文章详情页
  </div>
</template>
<script>
import { getArticleById } from '@/api/article'

export default {
  name: 'ArticleIndex',
  components: {},
  props: {
    // articleId 是由router.js映射过来
    articleId: {
      // 可能是数字 或者 字符串
      type: [Number, String, Object],
      required: true
    }
  },
  data () {
    return {
      article: {} // 文章详情
    }
  },
  watch: {
  },
  computed: {
  },
  created () {
    this.loadArticle()
  },
  mounted () {
  },
  methods: {
    async loadArticle () {
      try {
        const { data } = await getArticleById(this.articleId)
        this.article = data.data
      } catch (err) {
        this.$toast('取数失败', err)
      }
    },
    onClickLeft () {
      this.$router.back()
    }
  }
}
</script>
<style lang="less" scoped>
.article-container {
  /deep/.van-nav-bar .van-icon {
    color: #fff
  }
  /deep/.article-detail {
    .article-title {
      font-size: 50px;
    }
    .avatar {
      margin-right: 10px;
      width: 100px;
      height: 100px;
    }
    .follow-btn {
      width:150px;
      height:50px;
      font-size: 10px;
    }
  }
}
</style>
