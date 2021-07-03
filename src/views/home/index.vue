<template>
  <div class="home-container">
    <!-- 导航栏 -->
    <van-nav-bar class="page-nav-bar">
      <!-- 自定义插槽 -->
      <van-button
        class="search-btn"
        slot="title"
        size="small"
        type="info"
        round
        icon="search"
      >搜索</van-button>
    </van-nav-bar>
    <!-- 频道列表 -->
    <!-- 通过v-model绑定当前激活标签对应的索引值，默认情况下启用第一个标签 -->
    <!-- 通过animated属性可以开启切换标签内容时的转场动画 -->
    <!-- 通过swipeable属性可以开启滑动切换标签页 -->
    <van-tabs v-model="active" class="channel-tabs" swipeable animated>
      <van-tab
        :title="channel.name"
        v-for="channel in channels"
        :key="channel.id"
      >
        <article-list :channel="channel"/>
      </van-tab>
      <!-- 标签到最后时 部分内容 被最右边的图标 所以加入占位符 flex-shrink: 0 宽度设置才生效-->
      <div slot="nav-right" class="placeholder"></div>
      <!-- slot="nav-right"插入到最右侧tab的右边 -->
      <div slot="nav-right" class="more-btn">
        <van-icon size="25px" class="points-icon" name="points"/>
      </div>
    </van-tabs>

  </div>
</template>
<script>

import { getUserChannels } from '@/api/user'
import ArticleList from './components/article-list'

export default {
  name: 'HomeIndex',
  components: {
    ArticleList
  },
  props: {},
  data () {
    return {
      active: 0,
      channels: [] // 频道列表
    }
  },
  watch: {},
  computed: {},
  created () {
    // 加载数据
    this.loadChannels()
  },
  mounted () {},
  methods: {
    async loadChannels () {
      try {
        const { data } = await getUserChannels()
        this.channels = data.data.channels
        console.log(data)
        console.log(this.channels)
      } catch (err) {
        this.$toast('频道数据加载失败')
      }
    }
  }
}
</script>
<style lang="less">
.home-container {
  .van-nav-bar__title {
      max-width: unset;
  }
}
</style>
<style lang="less" scoped>
.home-container {
  .search-btn {
    width: 555px;
    height: 64px;
    background-color: #5babfb;
    .van-button__icon {
      color:white
    }
    // 去除边框
  }
  // 因导航栏固定于底部 遮挡了列表文字提示特效
  padding-bottom: 85px;
  .channel-tabs {
    .more-btn {
      position: fixed;
      right: 0%;
      .points-icon {
        width: 66px;
        padding-top: 15px;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #fff;
        opacity: 0.7;
      }
      &:before {
        content: "";
        position: absolute;
        left: 0;
        width: 3px;
        height: 100%;
        background-image: url(~@/assets/black_line.png);
        // 填充模式 contain：图片完全包含在内
        background-size: contain;
      }
    }
    .placeholder {
      width: 66px;
      flex-shrink: 0;
    }
  }
}
</style>
