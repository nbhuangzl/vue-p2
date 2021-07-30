<template>
  <div class="article-container">
    <!-- 导航栏 -->
    <van-nav-bar
     class="page-nav-bar"
     left-arrow
     title="黑马头条"
     @click-left="$router.back()">
    </van-nav-bar>
    <div class="main-wrap">
      <!--加载中-->
      <div v-if="loading" class="loading-wrap">
        <van-loading
          color="#3296fa"
          vertical
        >加载中</van-loading>
      </div>

      <!-- 加载完成显示文章详情 -->
      <div v-else-if="article.title" class="article-detail">
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
          <!-- 已关注 未关注 切换 -->
          <!-- 父组件 监听子组件的update-is_followed事件 $event会接收子组件事件的传参 -->
          <!-- 优化：当我们传递给子组件的数据既要使用还要修改时
                    传递：props
                    :is-followed="article.is_followed"
                    修改：自定义事件
                    @update-is_followed="article.is_followed = $event"
                    ---
                    简化方式:v-model
                    ---
                    1个组件上只能用1次v-model
                    若1个组件多个数据需要实现类似v-model
                    可以 .sync修饰符
           -->
          <!-- <follow-user
            class="follow-btn"
            :is-followed="article.is_followed"
            @update-is_followed="article.is_followed = $event"
            :aut-id="article.aut_id"
          />
          v-model 所在标签 对应的组件里 默认为 props:value 监听事件为input
          可以修改默认值 [例如 components/follow-user/index]
            model: {
              prop: 'isFollowed', // 默认名称为value
              event: 'update-is_followed' // 默认名称为input
            },
          -->
          <follow-user
            class="follow-btn"
            v-model="article.is_followed"
            :aut-id="article.aut_id"
          />
          <!-- 提取到组件follow-user
          <van-button
            v-if="article.is_followed"
            class="follow-btn"
            round
            size="small"
            @click="onFollow"
            :loading="followLoading"
          >已关注</van-button>
          <van-button
            v-else
            class="follow-btn"
            type="info"
            round
            color="#3296fa"
            icon="plus"
            size="small"
            @click="onFollow"
            :loading="followLoading"
          >关注</van-button> -->
        </van-cell>
        <div
          class="article-content markdown-body"
          v-html="article.content"
          ref="article-content"
        >
        </div>
        <van-divider>正文结束</van-divider>
        <!-- 文章评论列表 -->
        <comment-list
          :source="article.art_id"
          @onload-success="totalCommentCount = $event.total_count"
        />
        <!-- 评论列表 -->
              <!-- 底部区域 -->
      <div class="article-bottom">
        <van-button
          class="comment-btn"
          type="default"
          round
          size="small"
          >写评论</van-button>
        <van-icon
          class="comment-icon"
          name="comment-o"
          :info="totalCommentCount" />
        <article-like
          class="btn-item"
          v-model="article.is_liked"
          :art-id="article.art_id"
        />
        <article-collect
          class="btn-item"
          v-model="article.is_collected"
          :art-id="article.art_id"
        />
        <van-icon name="share" color="#777777"></van-icon>
      </div>
      </div>
      <!-- 加载失败：404 -->
      <div v-else-if="errStatus === 404" class="error-wrap">
        <van-icon name="failure"/>
        <p class="text">该资源不存在或者已删除</p>
      </div>
      <!-- 加载失败 其他未知错误(如网络或者服务器) -->
      <div v-else class="error-wrap">
        <van-icon name="failure"/>
        <p class="text">内容加载失败！</p>
        <van-button
          class="retry-btn"
          @click="loadArticle"
        >点击重试</van-button>
      </div>
    </div>
  </div>
</template>
<script>
import { getArticleById } from '@/api/article'
import { ImagePreview } from 'vant'
import FollowUser from '@/components/follow-user'
import ArticleCollect from '@/components/article-collect'
import ArticleLike from '@/components/article-like'
import CommentList from '@/views/article/components/comment-list'

export default {
  name: 'ArticleIndex',
  components: {
    FollowUser,
    ArticleCollect,
    ArticleLike,
    CommentList
  },
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
      article: {}, // 文章详情
      loading: true, // 加载中的loading状态
      errStatus: 0, // 失败的状态码
      totalCommentCount: 0
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
      this.loading = true
      try {
        const { data } = await getArticleById(this.articleId)
        // JSON.parse('afadsfaf') 模拟异常
        // 数据驱动视图不是立即的，
        this.article = data.data
        // 控制打印undefined,图片无法立即那倒
        // console.log(this.$refs['article-content'])
        // 所以 0秒的延时器 用以 初始化图片点击预览
        setTimeout(() => {
          this.previewImage()
        }, 0)
      } catch (err) {
        if (err.response && err.response.status === 404) {
          this.errStatus = 404
        }
        console.log('取数失败', err)
      }
      // 不论 取数成功或者失败 均关闭loading
      this.loading = false
    },
    async previewImage () {
      // 取img节点
      const articleContent = this.$refs['article-content']
      const imgs = articleContent.querySelectorAll('img')
      const images = []
      imgs.forEach((img, index) => {
        images.push(img.src)
        img.onclick = () => {
          ImagePreview({
            // images: images,
            images,
            startPosition: index,
            onClose () {
              console.log('xxx')
            }
          })
        }
      })
    }
  }
}
</script>
<style lang="less" scoped>
@import "./github-markdown.css";

.article-container {
  // border:1px red solid;
  .main-wrap {
    position: fixed;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    background-color: #fff;
  }
  .page-nav-bar {
    position: fixed;
    right: 0;
    left: 0;
    top: 0;
  };
  /deep/.van-nav-bar .van-icon {
    color: #fff
  }
  .loading-wrap {
    padding: 200px 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    // #fff 调为 #ffa是自测
    background-color: #ffa;
  }
  /deep/.article-detail {
    position: fixed;
    left: 0;
    right: 0;
    top: 92px;
    bottom: 88px;
    overflow-y: scroll; // y轴滚动
    background-color: #fff;
    .article-title {
      font-size: 40px;
      margin: 0;
      padding: 50px 32px;
      color: #3a3a3a;
    }
    .user-info {
      padding: 0 32px;
      .avatar {
        margin-right: 17px;
        width: 70px;
        height: 70px;
      }
      .van-cell__label {
        margin-top: 0;
      }
      .user-name {
        font-size: 24px;
        color: #3a3a3a;
      }
      .publish-date {
        font-size: 23px;
        color: #b7b7b7;
      }
      .follow-btn {
        width:170px;
        height:58px;
      }
    }
    .article-content {
      padding: 55px 32px;
      /deep/ p {
        text-align: justify; // 文本对齐
      }
    }
  }
  /deep/.error-wrap {
    padding-top: 220px;
    display: flex;
    flex-direction: column; // 内部元素 众向排序
    align-items: center; // error-warp内部元素 各自横向居中
    justify-content: center; // 内部元素 众向居中
    background-color: #fff;
    .van-icon {
      font-size: 100px;
      color: #b4b4b4;
    }
    .text {
      font-size: 30px;
      color: #666666;
      margin: 33px 0 46px;
    }
    .retry-btn {
      width: 280px;
      height: 70px;
      line-height: 70px;
      border: 1px solid #c3c3c3;
      font-size: 30px;
      color: #666666;
    }
  }
  .article-bottom {
    position: fixed;
    left: 0;
    right: 0;
    bottom: 0;
    display: flex;
    justify-content: space-around;
    // 让几个元素 上下排序 默认是水平排序
    // flex-direction: column;
    // 让几个元素 居中
    align-items: center;
    // https://blog.csdn.net/lengyue1084/article/details/82191095
    // 设置的边框和内边距的值是包含在width内
    // content-box  是默认值
    box-sizing: border-box;
    height: 88px;
    border-top: 1px solid #d8d8d8;
    background-color: #fff;
    .comment-btn {
      width: 282px;
      height: 46px;
      line-height: 46px; // 搭配height 居中
      border: 2px solid #eeeeee;
      font-size: 30px;
      // 字体颜色
      color: #a7a7a7;
    }
    // 底部div内的图标大小
    /deep/.van-icon {
      font-size: 40px;
    }
    .comment-icon {
      top: 2px;
      color: #777;
      font-size: 40px;
      .van-info {
        font-size: 16px;
        background-color: #e22829;
      }
    }
    .btn-item {
      border: none;
      padding: 0;
      height: 30px;
      line-height: 70px;
      color: #777777;
    }
  }
}
</style>
