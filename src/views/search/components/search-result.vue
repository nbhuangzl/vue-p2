<template>
  <div class="search-result">
    <!-- 错误提示 :error="error" error-text="加载失败, 请重试" -->
    <van-list
      v-model="loading"
      :finished="finished"
      finished-text="没有更多了"
      :error.sync="error"
      error-text="加载失败, 请重试"
      @load="onLoad"
    >
      <van-cell v-for="(item, index) in list" :key="index" :title="item.title" />
    </van-list>
  </div>
</template>
<script>
import { getSearchResult } from '@/api/search'

export default {
  name: 'SearchResult',
  components: {},
  props: {
    searchText: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      list: [],
      loading: false,
      finished: false,
      refreshing: false,
      page: 1,
      perPage: 3,
      error: false
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
        // 1.请求数据
        const { data } = await getSearchResult({
          page: this.page, // 页码
          per_page: this.perPage, // 每页大小
          q: this.searchText
        })
        // console.log(data)
        // 2.将数据添加到数组列表
        const { results } = data.data
        // console.log(results)
        this.list.push(...results)
        // 3.关闭loading
        this.loading = false
        // 4.判断是否还有数据
        //   若有 则更新取下页数据
        if (results.length) {
          // console.log(results.length)
          this.page++
          //   若没有 则将加载状态
        } else {
          this.finished = true
        }
      } catch (err) {
        this.error = true
        this.loading = false // 加载失败 loading关闭
        // this.finished = true
        // this.$toast('数据获取失败, 请稍后重试')
      }
    },
    onRefresh () {
      // 清空列表数据
      this.finished = false
      // 重新加载数据
      // 将 loading 设置为 true，表示处于加载状态
      this.loading = true
      this.onLoad()
    }
  }
}
</script>
<style lang="less" scoped>

</style>
