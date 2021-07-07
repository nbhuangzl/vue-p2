<template>
    <div class="search-container">
    <!-- 在 van-search 外层增加 form 标签，且 action 不为空，
         即可在 iOS与android 输入法中 显示 搜索按钮 -->
    <form action="/">
      <van-search
        v-model="searchText"
        show-action
        placeholder="请输入搜索关键词"
        background="#3296fa"
        @search="onSearch"
        @cancel="onCancel"
        @focus="isResultShow = false"/>
    </form>
    <!-- 搜索结果 -->
    <search-result v-if="isResultShow"/>
    <!-- 搜索历史-->
    <search-advisory v-else-if="searchText"/>
    <!-- 联想建议 -->
    <search-history v-else/>
    </div>
</template>
<script>
import SearchHistory from './components/search-history.vue'
import SearchAdvisory from './components/search-advisory.vue'
import SearchResult from './components/search-result.vue'

export default {
  name: 'SearchIndex',
  components: { SearchHistory, SearchAdvisory, SearchResult },
  props: {},
  data () {
    return {
      searchText: '',
      isResultShow: false // 控制搜索结果的展示
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
    onSearch (val) {
      this.$toast(val)
      this.isResultShow = true
    },
    onCancel () {
      this.$router.back()
    }
  }
}
</script>
<style lang="less" scoped>
.search_container {
  .van-search__action {
    color: #fff;
  }
}

</style>
