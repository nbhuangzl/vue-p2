<template>
    <div class="search-container">
    <!-- 在 van-search 外层增加 form 标签，且 action 不为空，
         即可在 iOS与android 输入法中 显示 搜索按钮 -->
    <form action="/">
      <van-search
        class="van-search"
        v-model="searchText"
        show-action
        placeholder="请输入搜索关键词"
        background="#3296fa"
        @search="onSearch"
        @cancel="onCancel"
        @focus="isResultShow = false"/>
    </form>
    <!-- 搜索结果 -->
    <!-- 传递searchText 给search-result组件的searchText -->
    <search-result
      v-if="isResultShow"
      :search-text="searchText"
      />
    <!-- 搜索历史-->
    <!-- @search="onSearch"
         监听 子组件的search事件 传递给onSearch
         -- @click="$emit('search', ad_text)
          -->
    <search-advisory
      v-else-if="searchText"
      :search-text="searchText"
      @search="onSearch"
      />
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
      // this.$toast(val)
      this.searchText = val // 将点击的联想建议内容 传递给父组件的搜索框内
      this.isResultShow = true
    },
    onCancel () {
      this.$router.back()
    }
  }
}
</script>
<style lang="less">
.search-container {
  padding-top:90px;
  .van-search__action {
    color: #fff;
  }
  .van-search {
      position: fixed;
      right: 0;
      left: 0;
      top: 0;
      z-index: 1;
  }
}
</style>
