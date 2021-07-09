<template>
  <div class="search-advisory">
    <!-- <van-cell
      :title="ad_text"
      icon="search"
      v-for="(ad_text, index) in advisory"
      :key="index"
    >
    </van-cell>-->
    <!-- 双花括号绑定 纯文本显示 -->
    <!-- <div>{{htmlStrTest}}</div> -->
    <!-- v-html 可渲染 -->
    <!-- <div v-html="htmlStrTest"></div> -->
    <van-cell
      icon="search"
      v-for="(ad_text, index) in advisory"
      :key="index"
      @click="$emit('search', ad_text)"
    >
      <div slot="title" v-html="highlight(ad_text)"></div>
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
      advisory: [], // 联想建议数据列表
      htmlStrTest: 'Hello <span style="color: red">World</span>' // 测试数据
    }
  },
  watch: {
    /**
     * //简写方式
     * searchText () {}
     *
     * // 完整写法
     * searchText: {
     *   hander () {}
     * }
     */
    // 监听 searchText属性 当其发生改变时 调用hander
    // 完整写法
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
        // console.log(value)
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
    },
    highlight (text) {
      const highlightStr = `<span class="active">${this.searchText}</span>`
      // 正则表达式 gi:gloable ignorecase
      const reg = new RegExp(this.searchText, 'gi')
      const var01 = text.replace(reg, highlightStr)
      // console.log(var01)
      return var01
    }
  }
}
</script>
<style lang="less" scoped>
.search-advisory {
  /deep/ span.active {
    color: #3296fa;
  }
}
</style>
