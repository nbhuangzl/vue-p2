<template>
  <div class="search-advisory">
    <van-cell
      :title="ad_text"
      icon="search"
      v-for="(ad_text, index) in advisory"
      :key="index"
    >
    </van-cell>
  </div>
</template>
<script>
import { getSearchAdvisory } from '@/api/search'
// 按需加载有好处: 只会将使用到的成员打包到结果中
// import lodash from 'lodash'
import { debounce } from 'lodash'
export default {
  name: 'SearchAdvisory',
  components: {},
  props: {
    searchText: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      advisory: [] // 联想建议数据列表
    }
  },
  watch: {
    // 监听 searchText属性 当其发生改变时 调用hander
    // 未简写
    searchText: {
      // 方式1，未加入lodash
      // handler (value) {
      //   this.loadSearchAdvisory(value)
      // },
      // 方式2 未加入lodash
      // handler: function (value) {
      //   console.log(value)
      // },
      // 方式3 加入lodash
      // debounce 函数
      // 参数1：需要被限时调用的函数
      // 参数2：延迟时间 毫秒
      // 返回值： 防抖之后的函数
      handler: debounce(function (value) {
        console.log(value)
        this.loadSearchAdvisory(value)
      }, 500),
      // 该回调将会在侦听开始之后被立即调用
      immediate: true
    }
  },
  computed: {
  },
  created () {
  },
  mounted () {
  },
  methods: {
    async loadSearchAdvisory (q) {
      try {
        const { data } = await getSearchAdvisory(q)
        // console.log(data)
        this.advisory = data.data.options
      } catch (err) {
        this.$toast('数据加载失败, 请稍后重试')
      }
    }
  }
}
</script>
<style lang="less" scoped>

</style>
