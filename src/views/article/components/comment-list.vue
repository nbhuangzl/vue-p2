<template>
    <!-- <div class="comment-list"></div> -->
  <van-list
    class="comment-list"
    v-model="loading"
    :finished="finished"
    finished-text="没有更多了"
    :error="error"
    error-text="加载失败, 点击重试"
    @load="onLoad">
   <van-cell
     v-for="(item, index) in list"
     :key="index"
     :title="item.content" />
  </van-list>
</template>
<script>
import { getComments } from '@/api/comment'
export default {
  name: 'CommentList',
  components: {
  },
  props: {
    source: {
      type: [Number, String, Object],
      required: true
    }
  },
  data () {
    return {
      list: [],
      loading: false,
      finished: false,
      offset: 1, // 取下一頁數據的標記
      limit: 10,
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
        console.log('11111')
        // 1. 取數
        const { data } = await getComments({
          type: 'a', // 評論類型, a-對文章(article)的評論 c對評論的回復
          source: this.source, // 源id, 文章id或者評論id
          offset: this.offset,
          limit: this.limit
        })
        // 2. 數據添加到列表
        const { results } = data.data
        this.list.push(...results)
        // 3. loading 設置爲 false
        this.loading = false
        // 4. 判斷是否還有數據
        // if (results.length) {
        if (results.length) {
          // 有就更新取下一頁數據
          this.offset = data.data.last_id
          console.log('offset数据', this.offset)
        } else {
          // 沒有 finished 設置為結束
          this.finished = true
        }
      } catch (err) {
        console.log('err show')
        this.error = true
        this.loading = false
      }
    }
  }
}
</script>
<style lang="less" scoped>

</style>
