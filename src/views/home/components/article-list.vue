<template>
    <div class="article-list">
        <!--
          -load 事件：
            + List 初始化后会触发一次 load 事件，用于加载第一屏的数据。
            + 如果一次请求加载的数据条数较少，导致列表内容无法铺满当前屏幕，List 会继续触发 load 事件
            直到内容铺满屏幕或数据全部加载完成
            List 组件通过 loading 和 finished 两个变量控制加载状态，
          当组件初始化或滚动到到底部时，会触发 load 事件并将 loading 自动设置成 true，此时可以发起异步操作并更新数据，
          数据更新完毕后，将 loading 设置成 false 即可
          若数据已全部加载完毕，则直接将 finished 设置成 true 即可。
        -->
      <van-pull-refresh
        v-model="refreshLoading"
        :success-text="refreshSuccessText"
        :success-duration="1500"
        @refresh="onRefresh">
        <van-list
          v-model="loading"
          :error.sync="error"
          error-text="请求失败，点击重新加载"
          :finished="finished"
          finished-text="没有更多了"
          @load="onLoad"
        >
          <article-item
            v-for="(article, index) in list"
            :key="index"
            :article="article"/>
          <!-- <van-cell v-for="(item, index) in list" :key="index" :title="item.title" /> -->
        </van-list>
      </van-pull-refresh>
    </div>
</template>
<script>
import { getArticles } from '@/api/article'
import ArticleItem from '@/components/article-item'

export default {
  name: 'ArticleList',
  components: {
    ArticleItem
  },
  props: {
    // 定义属性
    channel: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      list: [], // 存储列表数据的数组
      list_test: [],
      loading: false, // 控制加载中 loading状态
      finished: false, // 控制数据加载结束的状态
      timestamp: null, // 下一页数据的时间戳
      error: false, // 控制列表加载失败时的提示状态
      refreshLoading: false,
      refreshSuccessText: '刷新成功'
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
    async onLoad () {
      try {
        // const { xxx } = this.state; 相当于 const xxx = this.state.xxx
        const { data } = await getArticles({
          channel_id: this.channel.id, // 频道ID
          timestamp: this.timestamp || Date.now(),
          with_top: 1 // 是否包含置顶
        })
        // 模拟错误提示
        // if (Math.random() > 0.5) {
        //   JSON.parse('afadsfaf')
        // }
        // es6语法 const { xxx } = this.state 相当于 const xxx = this.state.xxx
        const { results } = data.data
        // ... 为数组的展开操作符, 它会把数组元素1个1个拿出来
        this.list.push(...results)
        // this.list_test.push(...[{ title: 'aa你好', name: 'aa' }, { title: 'bb你好', name: 'bb' }])
        // console.log('测试', this.list_test)
        // 本次数据加载之后 设置为加载结束
        this.loading = false
        // 判断数据是否全都加载完成
        if (results.length) {
          // 下一页数据的时间戳
          this.timestamp = data.data.pre_timestamp
        } else {
          this.finished = true
        }
      } catch (err) {
        // console.log('请求失败', err)
        // this.$toast('请求失败了')
        this.error = true
        this.loading = false
      }
    },
    async onRefresh () {
      try {
        // const { xxx } = this.state; 相当于 const xxx = this.state.xxx
        const { data } = await getArticles({
          channel_id: this.channel.id, // 频道ID
          timestamp: Date.now(), // 下拉刷新 每次请求最新数据
          with_top: 1 // 是否包含置顶
        })
        // // 模拟错误提示
        // if (Math.random() > 0.5) {
        //   JSON.parse('afadsfaf')
        // }
        // 将数据追加到列表顶部
        const { results } = data.data
        this.list.unshift(...results)
        // 刷新成功提示
        this.refreshSuccessText = `刷新成功,更新了${results.length}条数据`
        // 本次数据加载之后 设置为加载结束
        this.refreshLoading = false
      } catch (err) {
        // console.log('请求失败', err)
        this.refreshSuccessText = '刷新失败'
        this.refreshLoading = false
      }
    }
  }
}
</script>
<style lang="less" scoped>
.article-list {
  height: 82vh;
  overflow-y: auto;
}
</style>
