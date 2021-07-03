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
      <van-list
        v-model="loading"
        :finished="finished"
        finished-text="没有更多了"
        @load="onLoad"
      >
        <van-cell v-for="item in list" :key="item" :title="item" />
      </van-list>
    </div>
</template>
<script>
export default {
  name: '',
  components: {},
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
      loading: false, // 控制加载中 loading状态
      finished: false // 控制数据加载结束的状态
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
    onLoad () {
      console.log('aaaa')
      // 异步更新数据
      // setTimeout 仅做示例，真实场景中一般为 ajax 请求
      setTimeout(() => {
        for (let i = 0; i < 10; i++) {
          this.list.push(this.list.length + 1)
        }
        // 加载状态结束
        this.loading = false

        // 数据全部加载完成
        if (this.list.length >= 40) {
          this.finished = true
        }
      }, 1000)
    }
  }
}
</script>
<style lang="less" scoped>

</style>
